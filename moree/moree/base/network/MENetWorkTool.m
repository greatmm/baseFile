//
//  MENetWorkTool.m
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//
#warning 需要优化，请求接口数据的处理，错误码及错误信息的封装

#import "MENetWorkTool.h"
#import "MESessionTaskPool.h"

static AFHTTPSessionManager *manager;

@implementation MENetWorkTool
+ (AFNetworkReachabilityStatus)networkStatus
{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}
+ (void)getDataWithUrl:(NSString *)url parm:(NSDictionary*)parm completionBlock:(void (^)(BOOL isSucceeded, NSString *msg, NSError * _Nullable error,id _Nullable responseObjectData))completionBlock
{
    manager = [[self class] sessionManagerWithUrl:url];
    NSString * md5Str = url.md5String;
    NSURLSessionDataTask *sessionTask = [manager GET:url parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(true,@"",nil,responseObject);
        [[MESessionTaskPool shareSessionTaskPool] releaseOneTaskWithKey:md5Str];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(false,@"",error,nil);
        [[MESessionTaskPool shareSessionTaskPool] releaseOneTaskWithKey:md5Str];
    }];
    [[MESessionTaskPool shareSessionTaskPool] retainOneTask:@{md5Str:sessionTask}];
}

+ (void)postDataWithUrl:(NSString *)url parm:(NSDictionary*)parm completionBlock:(void (^)(BOOL isSucceeded, NSString *msg, NSError * _Nullable error,id _Nullable responseObjectData))completionBlock
{
    NSString * md5Str = url.md5String;
    manager = [[self class] sessionManagerWithUrl:url];
    NSURLSessionDataTask *sessionTask = [manager POST:url parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionBlock(true,@"",nil,responseObject);
        [[MESessionTaskPool shareSessionTaskPool] releaseOneTaskWithKey:md5Str];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(false,@"",error,nil);
        [[MESessionTaskPool shareSessionTaskPool] releaseOneTaskWithKey:md5Str];
    }];
    [[MESessionTaskPool shareSessionTaskPool] retainOneTask:@{md5Str:sessionTask}];
}


+ (AFHTTPSessionManager *)sessionManagerWithUrl:(NSString *)url
{
    static NSString *host;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        host = baseUrl;
    });
    if (url.length && ![url isEqualToString:host]) {
        NSURL *baseURL = [NSURL URLWithString:url];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        manager.requestSerializer.timeoutInterval = 15;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",@"application/xml", nil];
        return manager;
    }
    if (!manager) {
        NSURL *baseURL = [NSURL URLWithString:host];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        manager.requestSerializer.timeoutInterval = 15;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",@"application/xml", nil];
    }
    return manager;
}


@end
