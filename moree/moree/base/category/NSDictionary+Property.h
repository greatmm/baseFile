//
//  NSDictionary+Property.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Property)
//生成属性代码，直接粘贴即可
- (void)createPropertyCode;

@end

NS_ASSUME_NONNULL_END
