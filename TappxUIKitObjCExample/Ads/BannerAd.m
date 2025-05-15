//
//  BannerAd.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "BannerAd.h"
#import "TappxErrorManager.h"
#import "../Conf/NSStringExtensions.h"

@interface BannerAd () <TappxBannerViewDelegate>

@property (nonatomic, strong, nullable) TappxBannerView *bannerView;
@property (nonatomic, weak) id<BannerAdDelegate> delegate;

@end

@implementation BannerAd

- (instancetype)initWithDelegate:(id<BannerAdDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)loadBanner {
    [self removeBanner];

    self.bannerView = [[TappxBannerView alloc] initWithDelegate:self andSize:TappxBannerSmartBanner andPosition:TappxBannerPositionBottom];

    if (self.bannerView && [self.delegate respondsToSelector:@selector(addTappxBannerViewToView:)]) {
        [self.delegate addTappxBannerViewToView:self.bannerView];
    }

    if ([self.delegate respondsToSelector:@selector(rootViewController)]) {
        UIViewController *rootVC = [self.delegate rootViewController];
        [self.bannerView setRootViewController:rootVC];
    }

    [self.bannerView load];
}

- (void)loadBannerWithSize:(TappxBannerSize)size position:(TappxBannerPosition)position {
    [self removeBanner];

    self.bannerView = [[TappxBannerView alloc] initWithDelegate:self andSize:size andPosition:position];

    if (self.bannerView && [self.delegate respondsToSelector:@selector(addTappxBannerViewToView:)]) {
        [self.delegate addTappxBannerViewToView:self.bannerView];
    }

    if ([self.delegate respondsToSelector:@selector(rootViewController)]) {
        UIViewController *rootVC = [self.delegate rootViewController];
        [self.bannerView setRootViewController:rootVC];
    }

    [self.bannerView load];
}

- (void)removeBanner {
    if (self.bannerView) {
        [self.bannerView removeBanner];
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
}

- (void)updateLog:(NSString *)message {
    if ([self.delegate respondsToSelector:@selector(updateLogWithMessage:)]) {
        [self.delegate updateLogWithMessage:message];
    }
}

#pragma mark - TappxBannerViewDelegate

- (void)tappxBannerViewDidFinishLoad:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", @"banner".localized, @"status.loaded".localized]];
    [self.delegate bannerDidLoad:self];
}

- (void)tappxBannerViewDidFail:(TappxBannerView *)bannerView withError:(TappxErrorAd *)error {
    NSString *errorMessage = [TappxErrorManager messageForErrorCode:error.code];
    [self updateLog:[NSString stringWithFormat:@"%@%@%@", @"banner".localized, @"status.failed".localized, errorMessage]];
    [self.delegate bannerDidFailToLoad:self error:error];
}

- (void)tappxBannerViewDidPress:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", @"banner".localized, @"status.pressed".localized]];
    [self.delegate bannerDidClick:self];
}

- (void)tappxBannerViewDidClose:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", @"banner".localized, @"status.closed".localized]];
    [self.delegate bannerDidClose:self];
}

@end
