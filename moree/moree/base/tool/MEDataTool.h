//
//  MEDataTool.h
//  moree
//
//  Created by moyi on 2019/7/8.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEDataTool : NSObject
+(NSString *)errorStringWithErrorCode:(NSInteger)errorCode;
+(NSString *)appVersion;//当前app的版本号
@end

NS_ASSUME_NONNULL_END
