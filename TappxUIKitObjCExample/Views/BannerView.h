//
//  BannerView.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <UIKit/UIKit.h>
#import "../Ads/AdType.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerView : UIViewController

@property (nonatomic, assign) AdType viewType;
@property (nonatomic, assign) AdSubType adSubType;

@end

NS_ASSUME_NONNULL_END
