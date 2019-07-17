//
//  MEObjectTool.h
//  moree
//
//  Created by moyi on 2019/7/10.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MEUser.h"
NS_ASSUME_NONNULL_BEGIN

@interface MEObjectTool : NSObject

#pragma mark -- 系统对象的封装
+ (UIAlertController *)alertControllerWithTitle:(NSString*)title message:(NSString *)message style:(UIAlertControllerStyle)style actionArr:(NSArray <UIAlertAction*>*)actionArr;
#pragma mark -- 自定义对象
+(void)saveUser:(MEUser *)user;
+(MEUser *)user;
+(void)removeUser;
@end

NS_ASSUME_NONNULL_END
