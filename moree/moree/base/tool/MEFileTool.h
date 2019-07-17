//
//  MEFileTool.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//
//文件管理类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MEFileTool : NSObject
+(NSString *)documentsPath;//documents路径
+(NSString *)cachesPath;//沙盒caches路径
+(NSString *)temporaryPath;//临时路径
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion error:(void(^)(NSString * errorStr))errorBlock;//获取一个文件夹的大小，必需传文件夹路径
+ (void)removeDirectoryPath:(NSString *)directoryPath;//删除一个文件夹
+ (BOOL)fileExistsAtPath:(NSString *)filePath;//判断路径下的文件是否存在
+ (void)removeItemAtPath:(NSString *)filePath;//删除文件
+ (void)moveItemAtOriginalPath:(NSString *)originalPath toTargetPath:(NSString *)targetPath;//移动文件
+(void)addOneFile:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
