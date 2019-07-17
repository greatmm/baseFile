//
//  MEDataTool.m
//  moree
//
//  Created by moyi on 2019/7/8.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEDataTool.h"

@implementation MEDataTool

+(NSString *)errorStringWithErrorCode:(NSInteger)errorCode
{
    NSString * errorString;
    switch (errorCode) {
        case 0:
            errorString = @"";
            break;
            
        default:
            break;
    }
    return errorString;
}
+(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
@end
