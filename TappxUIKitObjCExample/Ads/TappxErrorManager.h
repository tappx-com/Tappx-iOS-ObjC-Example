//
//  TappxErrorManager.h
//  TappxUIKitObjCExample
//
//  Created by Antonio Lai on 15/05/25.
//

#import <Foundation/Foundation.h>
#import <TappxFramework/TappxAds.h>

@interface TappxErrorManager : NSObject

+ (NSString *)messageForErrorCode:(NSInteger)errorCode;

@end
