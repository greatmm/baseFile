//
//  MESessionTaskPool.h
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MESessionTaskPool : NSObject

+ (instancetype)shareSessionTaskPool;

- (void)retainOneTask:(NSDictionary *)taskDic;

- (void)releaseOneTaskWithKey:(NSString *)taskKey;

@end

NS_ASSUME_NONNULL_END
