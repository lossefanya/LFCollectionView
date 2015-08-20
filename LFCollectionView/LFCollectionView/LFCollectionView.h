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

@protocol LFCollectionViewDelegate <NSObject>
@optional

// Called after the user tap a cell.
- (void)collectionView:(LFCollectionView *)collectionView didSelectItemAtIndex:(NSUInteger)index;

// Called after the user tap the delete button of cell. manipulate data according to this action
- (void)collectionView:(LFCollectionView *)collectionView didDeleteItemAtIndex:(NSUInteger)index;

@end

@protocol LFCollectionViewDataSource <NSObject>
@required

// Called to find out number of items.
- (NSInteger)numberOfItemsInCollectionView:(LFCollectionView *)collectionView;

// Called to display details of the cell. Should dequeue or generate a cell here.
- (LFCollectionViewCell *)collectionView:(LFCollectionView *)collectionView cellForItemAtIndex:(NSUInteger)index;\

// Called to find out height of each cell. You can set variable height for each cells.
- (CGFloat)collectionView:(LFCollectionView *)collectionView heightForItemAtIndex:(NSUInteger)index;

@end

@interface LFCollectionView : UIScrollView

@property (nonatomic, assign) id <LFCollectionViewDelegate> actionDelegate;
@property (nonatomic, assign) id <LFCollectionViewDataSource> dataSource;
@property (nonatomic, weak) LFCollectionViewCell *selectedCell;

// reloads everything from scratch. redisplays visible rows.
- (void)reloadData;

// Used by the delegate to acquire an already allocated cell.
- (LFCollectionViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

// Called when the user touches delete button.
- (void)deleteCell:(LFCollectionViewCell *)cell;

@end
