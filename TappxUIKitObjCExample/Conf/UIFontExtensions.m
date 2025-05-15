//
//  UIFontExtensions.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "UIFontExtensions.h"

@implementation UIFont (CustomFonts)

+ (UIFont *)titleFont {
    UIFont *font = [UIFont fontWithName:@"IBMPlexSans-SemiBold" size:22];
    return font ?: [UIFont systemFontOfSize:22];
}

+ (UIFont *)bodyFont {
    UIFont *font = [UIFont fontWithName:@"IBMPlexSans-Mediumk" size:18];
    return font ?: [UIFont systemFontOfSize:18];
}

+ (UIFont *)headerFont {
    UIFont *font = [UIFont fontWithName:@"ReneBieder-FaktumSemiBold" size:26];
    return font ?: [UIFont systemFontOfSize:26 weight:UIFontWeightBold];
}

+ (UIFont *)secondFont {
    UIFont *font = [UIFont fontWithName:@"IBMPlexSans-Mediumk" size:16];
    return font ?: [UIFont systemFontOfSize:16];
}

@end
