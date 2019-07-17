//
//  UITextView+MECategory.m
//  moree
//
//  Created by moyi on 2019/7/4.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "UITextView+MECategory.h"

@implementation UITextView (MECategory)
- (void)addPlaceholder:(NSString *)placeholder
{
    if (placeholder == nil || placeholder.length == 0 || ![placeholder isKindOfClass:[NSString class]]) {
        return;
    }
    if (@available(iOS 9.0, *)) {
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = placeholder;
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor colorWithWhite:112/255.0 alpha:1];
        placeHolderLabel.font = self.font;
        [placeHolderLabel sizeToFit];
        [self addSubview:placeHolderLabel];
        [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
}
@end
