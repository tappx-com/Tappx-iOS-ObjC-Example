//
//  MRECAd.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "MRECAd.h"
#import "../Conf/NSStringExtensions.h"
#import <TappxFramework/TappxAds.h>
#import "../Ads/TappxErrorManager.h"

@interface MRECAd ()

@property (nonatomic, strong, nullable) TappxBannerView *tappxMREC;

@end

@implementation MRECAd

- (void)loadBanner {
    [self removeBanner];
    
    self.tappxMREC = [[TappxBannerView alloc] initWithDelegate:self andSize:TappxBannerSize300x250];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addTappxBannerViewToView:)]) {
        [self.delegate addTappxBannerViewToView:self.tappxMREC];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rootViewController)]) {
        [self.tappxMREC setRootViewController:[self.delegate rootViewController]];
    }
    
    [self.tappxMREC load];
}

- (void)loadBannerWithSize:(TappxBannerSize)size {
    [self removeBanner];
    
    self.tappxMREC = [[TappxBannerView alloc] initWithDelegate:self andSize:size];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addTappxBannerViewToView:)]) {
        [self.delegate addTappxBannerViewToView:self.tappxMREC];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rootViewController)]) {
        [self.tappxMREC setRootViewController:[self.delegate rootViewController]];
    }
    
    [self.tappxMREC load];
}

- (void)removeBanner {
    if (self.tappxMREC) {
        [self.tappxMREC removeBanner];
        [self.tappxMREC removeFromSuperview];
        self.tappxMREC = nil;
    }
}

#pragma mark - TappxBannerViewDelegate overrides

- (void)tappxBannerViewDidFinishLoad:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", @"MREC".localized, NSLocalizedString(@"status.loaded", nil)]];
    
    if ([self.delegate respondsToSelector:@selector(bannerDidLoad:)]) {
        [self.delegate bannerDidLoad:self];
    }
}

- (void)tappxBannerViewDidFail:(TappxBannerView *)bannerView withError:(TappxErrorAd *)error {
    NSString *errorMessage = [TappxErrorManager messageForErrorCode:error.code];
    [self updateLog:[NSString stringWithFormat:@"%@%@%@", @"MREC".localized, NSLocalizedString(@"status.failed", nil), errorMessage]];
    
    if ([self.delegate respondsToSelector:@selector(bannerDidFailToLoad:error:)]) {
        [self.delegate bannerDidFailToLoad:self error:error];
    }
}

- (void)tappxBannerViewDidPress:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", NSLocalizedString(@"MREC", nil), NSLocalizedString(@"status.pressed", nil)]];
    
    if ([self.delegate respondsToSelector:@selector(bannerDidClick:)]) {
        [self.delegate bannerDidClick:self];
    }
}

- (void)tappxBannerViewDidClose:(TappxBannerView *)bannerView {
    [self updateLog:[NSString stringWithFormat:@"%@%@", NSLocalizedString(@"MREC", nil), NSLocalizedString(@"status.closed", nil)]];
    
    if ([self.delegate respondsToSelector:@selector(bannerDidClose:)]) {
        [self.delegate bannerDidClose:self];
    }
}

@end
