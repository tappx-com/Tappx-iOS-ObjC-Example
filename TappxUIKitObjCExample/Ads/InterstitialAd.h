//
//  InterstitialAd.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class InterstitialAd;

NS_ASSUME_NONNULL_BEGIN

@protocol InterstitialAdDelegate <NSObject>

- (void)interstitialDidLoad:(InterstitialAd *)interstitialAd;
- (void)interstitialDidFailToLoad:(InterstitialAd *)interstitialAd error:(NSError *)error;
- (void)interstitialDidShow:(InterstitialAd *)interstitialAd;
- (void)interstitialDidClose:(InterstitialAd *)interstitialAd;
- (void)interstitialDidPress:(InterstitialAd *)interstitialAd;
- (void)interstitialDidDisappear:(InterstitialAd *)interstitialAd;
- (void)updateInterstitialLogWithMessage:(NSString *)message;

@end

@interface InterstitialAd : NSObject

- (instancetype)initWithDelegate:(id<InterstitialAdDelegate>)delegate;
- (void)loadWithTappxKey:(nullable NSString *)tappxKey;
- (BOOL)isReady;
- (void)showFromViewController:(UIViewController *)viewController;
- (void)setAutoShow:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
