//
//  InterstitialAd.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "InterstitialAd.h"
#import <TappxFramework/TappxAds.h>
#import "TappxErrorManager.h"
#import "../Conf/NSStringExtensions.h"

@interface InterstitialAd () <TappxInterstitialAdDelegate>

@property (nonatomic, strong, nullable) TappxInterstitialAd *interstitialAd;
@property (nonatomic, weak, nullable) id<InterstitialAdDelegate> delegate;
@property (nonatomic, assign) BOOL autoShow;

@end

@implementation InterstitialAd

- (instancetype)initWithDelegate:(id<InterstitialAdDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _autoShow = NO;
    }
    return self;
}

- (void)setAutoShow:(BOOL)enable {
    _autoShow = enable;
}

- (void)load {
    self.interstitialAd = [[TappxInterstitialAd alloc] initWithDelegate:self];
    [self.interstitialAd setAutoShowWhenReady:self.autoShow];
    [self.interstitialAd load];
}

- (BOOL)isReady {
    return self.interstitialAd.isReady;
}

- (void)showFromViewController:(UIViewController *)viewController {
    [self.interstitialAd showFrom:viewController];
}

#pragma mark - TappxInterstitialAdDelegate

- (void)tappxInterstitialAdDidFail:(TappxInterstitialAd *)interstitialAd withError:(TappxErrorAd *)error {
    self.interstitialAd = nil;
    NSString *errorMessage = [TappxErrorManager messageForErrorCode:error.code];
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@%@",
                                                     @"interstitial".localized,
                                                     @"status.failed".localized,
                                                     errorMessage]];
    [self.delegate interstitialDidFailToLoad:self error:error];
}

- (void)tappxInterstitialAdDidFinishLoad:(TappxInterstitialAd *)interstitialAd {
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                                     @"interstitial".localized,
                                                     @"status.loaded".localized]];
    [self.delegate interstitialDidLoad:self];
}

- (void)tappxInterstitialAdDidAppear:(TappxInterstitialAd *)interstitialAd {
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                                     @"interstitial".localized,
                                                     @"status.appeared".localized]];
    [self.delegate interstitialDidShow:self];
}

- (void)tappxInterstitialAdDidPress:(TappxInterstitialAd *)interstitialAd {
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                                     @"interstitial".localized,
                                                     @"status.pressed".localized]];
    [self.delegate interstitialDidPress:self];
}

- (void)tappxInterstitialAdDidClose:(TappxInterstitialAd *)interstitialAd {
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                                     @"interstitial".localized,
                                                     @"status.closed".localized]];
    [self.delegate interstitialDidClose:self];
}

- (void)tappxInterstitialAdDismissed:(TappxInterstitialAd *)interstitialAd {
    self.interstitialAd = nil;
    [self.delegate updateInterstitialLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                                     @"interstitial".localized,
                                                     @"status.dismissed".localized]];
    [self.delegate interstitialDidDisappear:self];
}

@end
