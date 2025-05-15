//
//  FullScreenView.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "FullScreenView.h"
#import "../Ads/InterstitialAd.h"
#import "../Ads/RewardedAd.h"
#import "../Conf/Color-Theme.h"
#import "../Conf/UIFontExtensions.h"
#import "../Conf/NSStringExtensions.h"

@interface FullScreenView () <InterstitialAdDelegate, RewardedAdDelegate>

@property (nonatomic, weak) IBOutlet UIView *backgroundView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *switchLabel;
@property (nonatomic, weak) IBOutlet UISwitch *autoShowSwitch;
@property (nonatomic, weak) IBOutlet UIView *switchView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonsConstraint;
@property (nonatomic, weak) IBOutlet UILabel *loadLabel;

@property (nonatomic, weak) IBOutlet UIView *readyButtonView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *readyHeightConstraint;
@property (nonatomic, weak) IBOutlet UILabel *readyLabel;
@property (nonatomic, weak) IBOutlet UIView *showButtonView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *showHeightConstraint;
@property (nonatomic, weak) IBOutlet UILabel *showLabel;

@property (nonatomic, weak) IBOutlet UIView *statusBoxBackgroundView;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UIView *statusInputView;
@property (nonatomic, weak) IBOutlet UITextView *statusInputText;

@property (nonatomic, strong) InterstitialAd *interstitialAd;
@property (nonatomic, strong) RewardedAd *rewardedAd;

@end

@implementation FullScreenView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = ((UIViewController *)self.navigationController.viewControllers.firstObject).navigationItem.titleView;
    [self configureView];
    [self setupBackButton];
}

- (void)configureView {
    if (self.viewType == AdTypeInterstitial) {
        [self setInterstitialView];
    } else if (self.viewType == AdTypeRewarded) {
        [self setRewardedView];
    }

    self.autoShowSwitch.on = NO;

    self.backgroundView.backgroundColor = ColorTheme.secondary;
    self.titleLabel.textColor = ColorTheme.primary;
    self.titleLabel.font = [UIFont titleFont];
    self.switchLabel.font = [UIFont bodyFont];
    self.autoShowSwitch.onTintColor = ColorTheme.switchOn;

    self.loadLabel.text = [@"button.load" localized];
    self.loadLabel.font = [UIFont bodyFont];
    self.readyLabel.text = [@"button.ready" localized];
    self.readyLabel.font = [UIFont bodyFont];
    self.showLabel.text = [@"button.show" localized];
    self.showLabel.font = [UIFont bodyFont];

    [self configureStatus];
}

- (void)setupBackButton {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:20 weight:UIImageSymbolWeightBold];
    UIImage *backImage = [[UIImage systemImageNamed:@"chevron.backward" withConfiguration:config] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
    backButton.tintColor = UIColor.whiteColor;

    self.navigationItem.rightBarButtonItem = backButton;
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureStatus {
    self.statusBoxBackgroundView.backgroundColor = ColorTheme.darkGray;
    self.statusLabel.font = [UIFont titleFont];

    self.statusInputView.backgroundColor = ColorTheme.scrollBackground;
    self.statusInputView.layer.cornerRadius = 8.0;
}

- (InterstitialAd *)interstitialAd {
    if (!_interstitialAd) {
        _interstitialAd = [[InterstitialAd alloc] initWithDelegate:self];
    }
    return _interstitialAd;
}

- (RewardedAd *)rewardedAd {
    if (!_rewardedAd) {
        _rewardedAd = [[RewardedAd alloc] initWithDelegate:self];
    }
    return _rewardedAd;
}

- (void)setInterstitialView {
    self.titleLabel.text = [@"interstitial" localized];
    self.switchView.hidden = NO;
    self.buttonsConstraint.constant = 91;
}

- (void)setRewardedView {
    self.titleLabel.text = [@"rewarded" localized];
    self.switchView.hidden = YES;
    self.buttonsConstraint.constant = 35;
}

- (IBAction)autoShowChanged:(id)sender {
    if (self.viewType == AdTypeInterstitial) {
        [self.interstitialAd setAutoShow:self.autoShowSwitch.isOn];
        if (self.autoShowSwitch.isOn) {
            [self setAutoShowOn];
        } else {
            [self setAutoShowOff];
        }
    }
}


- (IBAction)loadAction:(id)sender {
    if (self.viewType == AdTypeInterstitial) {
        [self.interstitialAd loadWithTappxKey:nil];
    } else {
        [self.rewardedAd loadWithTappxKey:nil];
    }
}

- (IBAction)readyAction:(id)sender {
    BOOL isReady = (self.viewType == AdTypeInterstitial) ? [self.interstitialAd isReady] : [self.rewardedAd isReady];
    NSString *readyText = [NSString stringWithFormat:@"%@ isReady: %@", (self.viewType == AdTypeInterstitial ? @"Interstitial" : @"Rewarded"), isReady ? @"true" : @"false"];
    self.statusInputText.text = [NSString stringWithFormat:@"%@\n%@", readyText, self.statusInputText.text];
}

- (IBAction)showAction:(id)sender {
    if (self.viewType == AdTypeInterstitial) {
        [self.interstitialAd showFromViewController:self];
    } else {
        [self.rewardedAd showFromViewController:self];
    }
}

- (void)setAutoShowOn {
    self.readyButtonView.hidden = YES;
    self.readyHeightConstraint.constant = 0;
    self.showButtonView.hidden = YES;
    self.showHeightConstraint.constant = 0;
}

- (void)setAutoShowOff {
    self.readyButtonView.hidden = NO;
    self.readyHeightConstraint.constant = 55;
    self.showButtonView.hidden = NO;
    self.showHeightConstraint.constant = 55;
}

#pragma mark - InterstitialAdDelegate

- (void)interstitialDidLoad:(InterstitialAd *)interstitialAd {}
- (void)interstitialDidFailToLoad:(InterstitialAd *)interstitialAd error:(NSError *)error {}
- (void)interstitialDidShow:(InterstitialAd *)interstitialAd {}
- (void)interstitialDidClose:(InterstitialAd *)interstitialAd {}
- (void)interstitialDidPress:(InterstitialAd *)interstitialAd {}
- (void)interstitialDidDisappear:(InterstitialAd *)interstitialAd {}

- (void)updateInterstitialLogWithMessage:(NSString *)message {
    self.statusInputText.text = [NSString stringWithFormat:@"%@\n%@", message, self.statusInputText.text];
}

#pragma mark - RewardedAdDelegate

- (void)rewardedAdDidFinishLoad:(RewardedAd *)rewardedAd {}
- (void)rewardedAdDidFailToLoad:(RewardedAd *)rewardedAd withError:(NSError *)error {}
- (void)rewardedAdDidClick:(RewardedAd *)rewardedAd {}
- (void)rewardedAdDidClose:(RewardedAd *)rewardedAd {}
- (void)rewardedAdDidRewardUser:(RewardedAd *)rewardedAd {}
- (void)rewardedAdDidAppear:(RewardedAd *)rewardedAd {}
- (void)rewardedAdVideoClosed:(RewardedAd *)rewardedAd {}
- (void)rewardedAdPlaybackFailed:(RewardedAd *)rewardedAd {}

- (void)updateRewarderLogWithMessage:(NSString *)message {
    self.statusInputText.text = [NSString stringWithFormat:@"%@\n%@", message, self.statusInputText.text];
}

@end
