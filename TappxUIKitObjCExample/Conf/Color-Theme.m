//
//  Color-Theme.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "Color-Theme.h"

@implementation ColorTheme

+ (UIColor *)primary {
    return [UIColor colorWithHexString:@"#ff0d58"]; // Pink
}

+ (UIColor *)primaryVariant {
    return [UIColor colorWithHexString:@"#330032"]; // Purple
}

+ (UIColor *)secondary {
    return [UIColor colorWithHexString:@"#f2f2f2"]; // Gray
}

+ (UIColor *)secondaryVariant {
    return [UIColor colorWithHexString:@"#ffffff"]; // White
}

+ (UIColor *)scrollBackground {
    return [UIColor colorWithHexString:@"#333333"]; // Dark grey
}

+ (UIColor *)darkGray {
    return [UIColor colorWithHexString:@"#e0e0e0"]; // Gray
}

+ (UIColor *)switchOn {
    return [UIColor colorWithHexString:@"#7ce080"]; // Green
}

+ (UIColor *)switchOff {
    return [UIColor colorWithHexString:@"#606060"]; // Gray
}

@end


@implementation UIColor(HEX)

+ (nullable UIColor *)colorWithHexString:(NSString *)hex {
    CGFloat r, g, b, a;

    if ([hex hasPrefix:@"#"]) {
        NSString *hexColor = [hex substringFromIndex:1];
        NSScanner *scanner = [NSScanner scannerWithString:hexColor];
        unsigned long long hexNumber = 0;

        if ([scanner scanHexLongLong:&hexNumber]) {
            if (hexColor.length == 8) {
                r = ((hexNumber & 0xff000000) >> 24) / 255.0;
                g = ((hexNumber & 0x00ff0000) >> 16) / 255.0;
                b = ((hexNumber & 0x0000ff00) >> 8) / 255.0;
                a = (hexNumber & 0x000000ff) / 255.0;
            } else if (hexColor.length == 6) {
                r = ((hexNumber & 0xff0000) >> 16) / 255.0;
                g = ((hexNumber & 0x00ff00) >> 8) / 255.0;
                b = (hexNumber & 0x0000ff) / 255.0;
                a = 1.0;
            } else {
                return nil;
            }

            return [UIColor colorWithRed:r green:g blue:b alpha:a];
        }
    }

    return nil;
}
@end
