//
//  MainView.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "MainView.h"
#import <TappxFramework/TappxAds.h>
#import "../Conf/NSStringExtensions.h"
#import "../Conf/UIFontExtensions.h"
#import "../Conf/Color-Theme.h"
#import "BannerView.h"
#import "FullScreenView.h"

@interface MainView ()

@property (weak, nonatomic) IBOutlet UILabel *versionText;

@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;

@property (weak, nonatomic) IBOutlet UIImageView *MRECImage;
@property (weak, nonatomic) IBOutlet UILabel *MRECLabel;

@property (weak, nonatomic) IBOutlet UIImageView *interstitialImage;
@property (weak, nonatomic) IBOutlet UILabel *interstitialLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rewardedImage;
@property (weak, nonatomic) IBOutlet UILabel *rewardedLabel;

@property (strong, nonatomic) IBOutlet UIView *mainView;

- (IBAction)bannerAction:(id)sender;
- (IBAction)MRECAction:(id)sender;
- (IBAction)interstitialAction:(id)sender;
- (IBAction)rewardedAction:(id)sender;

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self configNavigationBar];
}

- (void)configNavigationBar {
    UIView *titleView = [[UIView alloc] init];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo tappx"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;

    UILabel *label = [[UILabel alloc] init];
    label.text = [@"app_name" localized];
    label.textColor = UIColor.whiteColor;
    label.font = [UIFont headerFont];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[imageView, label]];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 8;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    [titleView addSubview:stackView];

    [NSLayoutConstraint activateConstraints:@[
        [imageView.widthAnchor constraintEqualToConstant:45],
        [imageView.heightAnchor constraintEqualToConstant:45],
        [stackView.centerXAnchor constraintEqualToAnchor:titleView.centerXAnchor],
        [stackView.centerYAnchor constraintEqualToAnchor:titleView.centerYAnchor],
        [stackView.leadingAnchor constraintGreaterThanOrEqualToAnchor:titleView.leadingAnchor],
        [stackView.trailingAnchor constraintLessThanOrEqualToAnchor:titleView.trailingAnchor]
    ]];

    self.navigationItem.titleView = titleView;
    [self setupNavigationBarHeight];

}

- (void)setupNavigationBarHeight {
    UIView *rectangleView = [[UIView alloc] init];
    rectangleView.backgroundColor = [ColorTheme primary];
    rectangleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rectangleView];
    
    [NSLayoutConstraint activateConstraints:@[
        [rectangleView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [rectangleView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [rectangleView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [rectangleView.heightAnchor constraintEqualToConstant:10.0]
    ]];
}

- (void)setupView {
    [self imageShadow:self.bannerImage];
    self.bannerLabel.text = [@"button.banner" localized];
    self.bannerLabel.font = [UIFont bodyFont];
    self.bannerLabel.textColor = [ColorTheme primaryVariant];

    [self imageShadow:self.MRECImage];
    self.MRECLabel.text = [@"button.MREC" localized];
    self.MRECLabel.font = [UIFont bodyFont];
    self.MRECLabel.textColor = [ColorTheme primaryVariant];

    [self imageShadow:self.interstitialImage];
    self.interstitialLabel.text = [@"button.interstitial" localized];
    self.interstitialLabel.font = [UIFont bodyFont];
    self.interstitialLabel.textColor = [ColorTheme primaryVariant];

    [self imageShadow:self.rewardedImage];
    self.rewardedLabel.text = [@"button.rewarded" localized];
    self.rewardedLabel.font = [UIFont bodyFont];
    self.rewardedLabel.textColor = [ColorTheme primaryVariant];

    self.versionText.text = [NSString stringWithFormat:@"%@ %@", [@"text.version" localized], [TappxFramework versionSDK]];
    self.versionText.font = [UIFont secondFont];

    self.mainView.backgroundColor = [ColorTheme secondary];
}

- (void)imageShadow:(UIImageView *)image {
    image.layer.shadowColor = UIColor.blackColor.CGColor;
    image.layer.shadowOpacity = 0.3;
    image.layer.shadowOffset = CGSizeMake(0, 1);
    image.layer.shadowRadius = 2;
    image.layer.masksToBounds = NO;
}

- (IBAction)bannerAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[@"navigation.name.banner" localized] bundle:nil];
    BannerView *vc = [storyboard instantiateViewControllerWithIdentifier:[@"navigation.id.banner" localized]];
    vc.viewType = AdTypeBanner;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)MRECAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[@"navigation.name.banner" localized] bundle:nil];
    BannerView *vc = [storyboard instantiateViewControllerWithIdentifier:[@"navigation.id.banner" localized]];
    vc.viewType = AdTypeMREC;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)interstitialAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[@"navigation.name.fullScreen" localized] bundle:nil];
    FullScreenView *vc = [storyboard instantiateViewControllerWithIdentifier:[@"navigation.id.fullScreen" localized]];
    vc.viewType = AdTypeInterstitial;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)rewardedAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[@"navigation.name.fullScreen" localized] bundle:nil];
    FullScreenView *vc = [storyboard instantiateViewControllerWithIdentifier:[@"navigation.id.fullScreen" localized]];
    vc.viewType = AdTypeRewarded;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
