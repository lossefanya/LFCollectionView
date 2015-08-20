//
//  LFCollectionView.h
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFCollectionView;
@class LFCollectionViewCell;

@protocol LFCollectionViewDelegate <UIScrollViewDelegate>
@optional

- (void)collectionView:(LFCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LFCollectionViewDataSource <NSObject>
@required

- (NSInteger)numberOfItemsInCollectionView:(LFCollectionView *)collectionView;
- (LFCollectionViewCell *)collectionView:(LFCollectionView *)collectionView cellForItemAtIndex:(NSUInteger)index;
//- (CGSize)sizeForItemsInCollectionView:(LFCollectionView *)collectionView;
- (CGFloat)collectionView:(LFCollectionView *)collectionView heightForItemAtIndex:(NSUInteger)index;

@end

@interface LFCollectionView : UIScrollView

@property (nonatomic, assign) id <LFCollectionViewDelegate> delegate;
@property (nonatomic, assign) id <LFCollectionViewDataSource> dataSource;

- (void)reloadData;

@end
