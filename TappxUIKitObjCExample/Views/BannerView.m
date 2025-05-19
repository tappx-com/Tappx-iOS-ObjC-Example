//
//  BannerView.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "BannerView.h"
#import "../Conf/NSStringExtensions.h"
#import "../Conf/UIFontExtensions.h"
#import "../Conf/Color-Theme.h"
#import "MainView.h"
#import "../Ads/BannerAd.h"
#import "../Ads/MRECAd.h"

@interface BannerView () <BannerAdDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *advertisementView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIView *statusInputView;
@property (weak, nonatomic) IBOutlet UITextView *statusInputText;

@property (nonatomic, strong) BannerAd *bannerAd;
@property (nonatomic, strong) MRECAd *mrecAd;
@property (nonatomic, strong) NSMutableArray<NSString *> *logLines;

@end

@implementation BannerView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = ((MainView *)self.navigationController.viewControllers.firstObject).navigationItem.titleView;
    self.logLines = [NSMutableArray array];
    
    self.bannerAd = [[BannerAd alloc] initWithDelegate:self];
    self.mrecAd = [[MRECAd alloc] initWithDelegate:self];

    [self configureView];
    [self setupBackButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadAds];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self cleanupAds];
}

- (void)configureView {
    switch (self.viewType) {
        case AdTypeBanner:
            [self setBannerView];
            break;
        case AdTypeMREC:
            [self setMRECView];
            break;
        default:
            break;
    }

    self.backgroundView.backgroundColor = [ColorTheme secondary];
    self.titleLabel.textColor = [ColorTheme primary];
    self.titleLabel.font = [UIFont titleFont];
    self.statusView.backgroundColor = [ColorTheme darkGray];

    [self configureStatus];
}

- (void)configureStatus {
    self.statusLabel.font = [UIFont titleFont];
    self.statusInputView.backgroundColor = [ColorTheme scrollBackground];
    self.statusInputView.layer.cornerRadius = 8;
    [self configureTextStatus];
}

- (void)configureTextStatus {
    self.statusInputText.font = [UIFont secondFont];
    self.statusInputText.textColor = [ColorTheme secondaryVariant];
}

- (void)setBannerView {
    self.titleLabel.text = [@"banner" localized];
}

- (void)setMRECView {
    self.titleLabel.text = [@"MREC" localized];
}

- (void)loadAds {
    switch (self.viewType) {
        case AdTypeBanner:
            [self.bannerAd loadBanner];
            break;
        case AdTypeMREC:
            [self.mrecAd loadBanner];
            break;
        default:
            break;
    }
}

- (void)cleanupAds {
    switch (self.viewType) {
        case AdTypeBanner:
            [self.bannerAd removeBanner];
            break;
        case AdTypeMREC:
            [self.mrecAd removeBanner];
            break;
        default:
            break;
    }
}

- (void)setupBackButton {
    [self setupNavigationBarHeight];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:20 weight:UIImageSymbolWeightBold];
    UIImage *backImage = [[UIImage systemImageNamed:@"chevron.backward" withConfiguration:config] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
    backButton.tintColor = UIColor.whiteColor;
    self.navigationItem.rightBarButtonItem = backButton;
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

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BannerAdDelegate

- (void)updateLogWithMessage:(NSString *)message {
    NSString *newText = [NSString stringWithFormat:@"%@\n%@", message, self.statusInputText.text];
    self.statusInputText.text = newText;
}

- (void)bannerDidLoad:(BannerAd *)bannerAd {
    // Handle success
}

- (void)bannerDidFailToLoad:(BannerAd *)bannerAd error:(NSError *)error {
    // Handle failure
}

- (void)bannerDidClick:(BannerAd *)bannerAd {
    // Handle click
}

- (void)bannerDidClose:(BannerAd *)bannerAd {
    // Handle close
}

- (UIViewController *)rootViewController {
    return self;
}

- (void)addTappxBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.advertisementView addSubview:bannerView];
    
    [self.advertisementView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.advertisementView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.advertisementView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]
    ]];
}


@end
