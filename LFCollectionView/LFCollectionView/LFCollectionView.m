//
//  LFCollectionView.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "LFCollectionView.h"
#import "LFCollectionViewCell.h"

@interface LFCollectionView ()

@property (nonatomic, strong) NSMutableSet *usingCells;
@property (nonatomic, strong) NSMutableSet *reusableCells;

@end

@implementation LFCollectionView

- (id)init {
	return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initialize];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
	self.usingCells = [NSMutableSet set];
	self.reusableCells = [NSMutableSet set];
}

- (void)reloadData {
	//calculate content size
	NSInteger number = [self.dataSource numberOfItemsInCollectionView:self];
	CGFloat height = 0;
	for (NSUInteger i = 0; i < number; i++) {
		//[self.dataSource sizeForItemsInCollectionView:self];
		height += [self.dataSource collectionView:self heightForItemAtIndex:i];
	}
	self.contentSize = CGSizeMake(self.frame.size.width, height);

	//Q
	[self.usingCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *cell, BOOL *stop) {
		[self queueReusableCell:cell];
		[cell removeFromSuperview];
	}];
	[self.usingCells removeAllObjects];

	[self setNeedsLayout];
}

- (void)layoutSubviews {
	//Q
	[self.usingCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *cell, BOOL *stop) {
		if (!CGRectIntersectsRect(cell.frame, self.bounds)) {
			[self queueReusableCell:cell];
			[cell removeFromSuperview];
		}
	}];
	[self.usingCells minusSet:self.reusableCells];
	
	//DQ
	
	
}

- (void)queueReusableCell:(LFCollectionViewCell *)cell {
	[self.reusableCells addObject:cell];
}

- (LFCollectionViewCell *)dequeueReusableCell {
	LFCollectionViewCell *cell = [self.reusableCells anyObject];
	if (cell) {
		[self.reusableCells removeObject:cell];
	}
	return cell;
}

@end
