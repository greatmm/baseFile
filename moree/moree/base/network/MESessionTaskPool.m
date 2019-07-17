//
//  MESessionTaskPool.m
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MESessionTaskPool.h"


@interface MESessionTaskPool ()
@property(nonatomic,strong) NSMutableDictionary * sessionTaskDic;//存储请求中的任务，以url的md5位key，sessionTask为value
@end

@implementation MESessionTaskPool
+(instancetype)shareSessionTaskPool
{
    static MESessionTaskPool * taskPool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        taskPool = [[MESessionTaskPool alloc] init];
    });
    return taskPool;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionTaskDic = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelNetworkTask:) name:MECancelNetWorkNotification object:nil];
    }
    return self;
}
//缓存一个请求任务
- (void)retainOneTask:(NSDictionary *)taskDic
{
    if ([self.sessionTaskDic.allKeys containsObject:taskDic.allKeys.firstObject]) {
        return;
    }
    [self.sessionTaskDic setValuesForKeysWithDictionary:taskDic];
}
//清除一个缓存任务
- (void)releaseOneTaskWithKey:(NSString *)taskKey
{
    NSURLSessionDataTask * dataTask = self.sessionTaskDic[taskKey];
    if (dataTask == nil) {
        return;
    }
    if (NSURLSessionTaskStateRunning == dataTask.state
        || NSURLSessionTaskStateSuspended == dataTask.state) {
        [dataTask cancel];
    }
    self.sessionTaskDic[taskKey] = nil;
}
- (void)cancelNetworkTask:(NSNotification *)noti
{
    NSArray * arr = noti.userInfo[MECancelNetWorkKey];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self releaseOneTaskWithKey:(NSString *)obj];
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
