//
//  AppDeviceCheck.m
//  iOS11-Example
//
//  Created by Leon on 2017/9/27.
//  Copyright © 2017年 leon. All rights reserved.
//

#import "AppDeviceCheck.h"
#import <DeviceCheck/DeviceCheck.h>
@implementation AppDeviceCheck

+ (NSString *)getNewDeviceId {
    if ([DCDevice.currentDevice isSupported]) {
        [DCDevice.currentDevice generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error.description);
            } else {
                // upload token to APP server
                
                NSString *deviceToken = [token base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                NSLog(@"%lu %@", token.length, deviceToken);
            }
        }];
    }
    return @"";
}
@end
