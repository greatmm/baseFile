//
//  MEFileTool.m
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEFileTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation MEFileTool

#pragma mark -- 路径
+(NSString *)documentsPath
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return docDir;
}
+(NSString *)cachesPath
{
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cachesDir;
}
+(NSString *)temporaryPath
{
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}
#pragma mark -- 文件夹
//判断是否是文件夹，是否存在
+ (BOOL)isDirectoryAtPath:(NSString *)filePath
{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:filePath isDirectory:&isDir];
    NSLog(@"是否存在%d--是否是文件夹%d--",isExist,isDir);
    return isExist && isDir;
}
//删除文件夹
+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    BOOL isDir = [[self class] isDirectoryAtPath:directoryPath];
    if (!isDir) {
        return;
    }
    [[self class] removeItemAtPath:directoryPath];
}
//获取文件夹的大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion error:(void(^)(NSString * errorStr))errorBlock
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSString * errStr = @"传入的路径不是文件夹";
        if (!isExist) {
            errStr = @"文件不存在";
        }
        errorBlock(errStr);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            totalSize += fileSize;
        }
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}
#pragma mark -- 文件
//判断文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)filePath
{
    NSFileManager* manager =[NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}
//获取一个文件的大小
+(long long)fileSizeAtPath:(NSString*)filePath{
    if ([[self class] isDirectoryAtPath:filePath]) {
        NSLog(@"需要传的是文件路径不是文件夹路径");
        return 0;
    }
    NSFileManager* manager = [NSFileManager defaultManager];
    return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
}

+ (void)moveItemAtOriginalPath:(NSString *)originalPath toTargetPath:(NSString *)targetPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:originalPath]) {
        NSError * error;
        [fileManager moveItemAtPath:originalPath toPath:targetPath error:&error];
        if (error) {
            NSLog(@"移动文件失败--%@",error);
        }
    } else {
        NSLog(@"原文件不存在");
    }
}
#pragma mark -- 删除路径下的文件或文件夹
+ (void)removeItemAtPath:(NSString *)filePath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:filePath]) {
        NSError * error;
        [mgr removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"删除文件错误%@",error);
        }
    }
}

#pragma mark -- 添加路径的方法
+(void)addOneDirectory:(NSString *)directoryPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:directoryPath]){
        //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
+(void)addOneFile:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
}
@end
