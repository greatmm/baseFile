//
//  MEBaseCollectionViewController.h
//  moree
//
//  Created by moyi on 2019/7/3.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MEBaseCollectionViewController : MEBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView * collectionView;
- (void)setupCollectionView;
@end

NS_ASSUME_NONNULL_END
