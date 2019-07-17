//
//  MEObjectTool.m
//  moree
//
//  Created by moyi on 2019/7/10.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEObjectTool.h"
#import "MEFileTool.h"
#define userPath [[MEFileTool documentsPath] stringByAppendingPathComponent:@"user"]

@implementation MEObjectTool
+ (UIAlertController *)alertControllerWithTitle:(NSString*)title message:(NSString *)message style:(UIAlertControllerStyle)style actionArr:(NSArray <UIAlertAction*>*)actionArr
{
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (UIAlertAction * action in actionArr) {
        [alertVc addAction:action];
    }
    return alertVc;
}

+(void)saveUser:(MEUser *)user
{
    if (user == nil) {
        return;
    }
    NSError * error;
    if (@available(iOS 11.0, *)) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:YES error:&error];
        if (error) {
            NSLog(@"保存用户数据错误--%@",error);
            return;
        }
        [data writeToFile:userPath atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:user toFile:userPath];
    }
}
+(MEUser *)user
{
    if (@available(iOS 11.0, *)) {
        NSError * error;
        MEUser * user = [NSKeyedUnarchiver unarchivedObjectOfClass:[MEUser class] fromData:[NSData dataWithContentsOfFile:userPath] error:&error];
        if (error) {
            NSLog(@"获取用户数据错误--%@",error);
        }
        return user;
    } else {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:userPath];
    }
}
+(void)removeUser
{
    [MEFileTool removeItemAtPath:userPath];
}
@end
