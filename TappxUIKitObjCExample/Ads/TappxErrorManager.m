//
//  TappxErrorManager.m
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import "TappxErrorManager.h"
#import "../Conf/NSStringExtensions.h"

@implementation TappxErrorManager

+ (NSString *)messageForErrorCode:(NSInteger)errorCode {
    switch ((TappxErrorCode)errorCode) {
        case NO_FILL:
            return @"error.noFill".localized;
        case SERVER_ERROR:
            return @"error.serverError".localized;
        case DEVELOPER_ERROR:
            return @"error.developerError".localized;
        case VIEW_INCONSISTENCY_ERROR:
            return @"error.viewInconsistency".localized;
        case CANCELLED:
            return @"error.cancelled".localized;
        case NO_CONNECTION:
            return @"error.noConnection".localized;
        default:
            return @"Unknown error";
    }
}

@end
