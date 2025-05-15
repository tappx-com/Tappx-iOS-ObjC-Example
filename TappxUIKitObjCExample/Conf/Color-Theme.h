//
//  Color-Theme.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorTheme : NSObject

+ (UIColor *)primary;
+ (UIColor *)primaryVariant;
+ (UIColor *)secondary;
+ (UIColor *)secondaryVariant;
+ (UIColor *)scrollBackground;
+ (UIColor *)darkGray;
+ (UIColor *)switchOn;
+ (UIColor *)switchOff;

@end

@interface UIColor (HEX)

+ (nullable UIColor *)colorWithHexString:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
