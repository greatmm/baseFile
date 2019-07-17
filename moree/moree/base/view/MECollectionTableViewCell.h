//
//  MECollectionTableViewCell.h
//  moree
//
//  Created by moyi on 2019/7/11.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MECollectionTableViewCell : MEBaseTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
