//
//  MENetWorkTool.h
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface MENetWorkTool : NSObject
+ (AFNetworkReachabilityStatus)networkStatus;//当前是什么网络
//普通的get网络请求
+ (void)getDataWithUrl:(NSString *)url parm:(NSDictionary*)parm completionBlock:(void (^)(BOOL isSucceeded, NSString *msg, NSError * _Nullable error,id _Nullable responseObjectData))completionBlock;
//普通的post网络请求，不包含图片，视频的上传...
+ (void)postDataWithUrl:(NSString *)url parm:(NSDictionary*)parm completionBlock:(void (^)(BOOL isSucceeded, NSString *msg, NSError * _Nullable error,id _Nullable responseObjectData))completionBlock;

@end

NS_ASSUME_NONNULL_END
