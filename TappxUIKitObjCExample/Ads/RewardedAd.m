//
//  RewardedAd.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "RewardedAd.h"
#import <TappxFramework/TappxAds.h>
#import "TappxErrorManager.h"
#import "../Conf/NSStringExtensions.h"

@interface RewardedAd () <TappxRewardedAdDelegate>
@property (nonatomic, strong) TappxRewardedAd *rewardedAd;
@property (nonatomic, weak) id<RewardedAdDelegate> delegate;
@end

@implementation RewardedAd

- (instancetype)initWithDelegate:(id<RewardedAdDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)loadWithTappxKey:(NSString * _Nullable)tappxKey {
    self.rewardedAd = [[TappxRewardedAd alloc] initWithDelegate:self];
    [self.rewardedAd setAutoShowWhenReady:NO];

    if (tappxKey != nil) {
        TappxSettings *settings = [[TappxSettings alloc] init];
        [settings setKeywords:@[tappxKey]];
        [self.rewardedAd load:settings];
    } else {
        [self.rewardedAd load];
    }
}

- (BOOL)isReady {
    return [self.rewardedAd isReady];
}

- (void)showFromViewController:(UIViewController *)viewController {
    [self.rewardedAd showFrom:viewController];
}

- (void)updateLogWithMessage:(NSString *)message {
    [self.delegate updateRewarderLogWithMessage:message];
}

#pragma mark - TappxRewardedAdDelegate

- (void)tappxRewardedAdDidFinishLoad:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.loaded".localized]];
    [self.delegate rewardedAdDidFinishLoad:self];
}

- (void)tappxRewardedAdClicked:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.clicked".localized]];
    [self.delegate rewardedAdDidClick:self];
}

- (void)tappxRewardedAdDismissed:(TappxRewardedAd *)rewardedAd {
    self.rewardedAd = nil;
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.dismissed".localized]];
    [self.delegate rewardedAdDidClose:self];
}

- (void)tappxRewardedAdDidAppear:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.appeared".localized]];
    [self.delegate rewardedAdDidAppear:self];
}

- (void)tappxRewardedAdVideoClosed:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.closed".localized]];
    [self.delegate rewardedAdVideoClosed:self];
}

- (void)tappxRewardedAdPlaybackFailed:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.playbackfailed".localized]];
    [self.delegate rewardedAdPlaybackFailed:self];
}

- (void)tappxRewardedAdVideoCompleted:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@",
                                @"rewarded".localized,
                                @"status.completed".localized]];
}

- (void)tappxRewardedAdUserDidEarnReward:(TappxRewardedAd *)rewardedAd {
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@", @"rewarded".localized, @"reward".localized]];
    [self.delegate rewardedAdDidRewardUser:self];
}

- (void)tappxRewardedAdDidFail:(TappxRewardedAd *)rewardedAd withError:(TappxErrorAd *)error {
    self.rewardedAd = nil;
    NSString *errorMessage = [TappxErrorManager messageForErrorCode:error.code];
    [self updateLogWithMessage:[NSString stringWithFormat:@"%@%@%@",
                                @"rewarded".localized,
                                @"status.failed".localized,
                                errorMessage]];
    [self.delegate rewardedAdDidFailToLoad:self withError:error];
}

@end
