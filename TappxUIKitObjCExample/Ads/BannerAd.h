//
//  BannerAd.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TappxFramework/TappxAds.h>

@class BannerAd;

NS_ASSUME_NONNULL_BEGIN

@protocol BannerAdDelegate <NSObject>

- (void)addTappxBannerViewToView:(UIView *)bannerView;
- (UIViewController *)rootViewController;
- (void)updateLogWithMessage:(NSString *)message;

- (void)bannerDidLoad:(BannerAd *)bannerAd;
- (void)bannerDidFailToLoad:(BannerAd *)bannerAd error:(NSError *)error;
- (void)bannerDidClick:(BannerAd *)bannerAd;
- (void)bannerDidClose:(BannerAd *)bannerAd;

@end

@interface BannerAd : NSObject <TappxBannerViewDelegate>

@property (nonatomic, weak, readonly) id<BannerAdDelegate> delegate;

- (instancetype)initWithDelegate:(id<BannerAdDelegate>)delegate;

- (void)loadBanner;

- (void)loadBannerWithSize:(TappxBannerSize)size position:(TappxBannerPosition)position;
- (void)removeBanner;

- (void)updateLog:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
