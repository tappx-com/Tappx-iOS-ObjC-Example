//
//  NSStringExtensions.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "NSStringExtensions.h"

@implementation NSString (Localized)

- (NSString *) localized {
    return NSLocalizedString(self, nil);
}

@end
