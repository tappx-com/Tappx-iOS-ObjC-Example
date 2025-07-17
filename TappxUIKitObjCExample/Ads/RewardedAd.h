//
//  RewardedAd.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RewardedAd;

@protocol RewardedAdDelegate <NSObject>

@required
- (void)rewardedAdDidFinishLoad:(RewardedAd *)rewardedAd;
- (void)rewardedAdDidFailToLoad:(RewardedAd *)rewardedAd withError:(NSError *)error;
- (void)rewardedAdDidClick:(RewardedAd *)rewardedAd;
- (void)rewardedAdDidClose:(RewardedAd *)rewardedAd;
- (void)rewardedAdDidRewardUser:(RewardedAd *)rewardedAd;
- (void)rewardedAdDidAppear:(RewardedAd *)rewardedAd;
- (void)rewardedAdVideoClosed:(RewardedAd *)rewardedAd;
- (void)rewardedAdPlaybackFailed:(RewardedAd *)rewardedAd;
- (void)updateRewarderLogWithMessage:(NSString *)message;

@end

@interface RewardedAd : NSObject

- (instancetype)initWithDelegate:(id<RewardedAdDelegate>)delegate;

- (void)load;
- (BOOL)isReady;
- (void)showFromViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
