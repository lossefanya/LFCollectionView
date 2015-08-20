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

#pragma mark - Initializers

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

#pragma mark - Populate cells

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
	//find out index
	NSUInteger first = [self indexOfPosition:CGRectGetMinY(self.bounds)];
	NSUInteger last = [self indexOfPosition:CGRectGetMaxY(self.bounds) - 1];
	for (NSUInteger i = first; i < last; ++i) {
		LFCollectionViewCell *cell = [self cellOfPosition:[self positionOfIndex:i]];
		if (!cell) {
			LFCollectionViewCell *newCell = [self.dataSource collectionView:self cellForItemAtIndex:i];
			newCell.frame = CGRectMake(0, [self positionOfIndex:i], self.frame.size.width, [self.dataSource collectionView:self heightForItemAtIndex:i]);
			[self addSubview:newCell];
			[self.usingCells addObject:newCell];
		}
	}
	
}

- (LFCollectionViewCell *)cellOfPosition:(CGFloat)y {
	__block LFCollectionViewCell *cell = nil;
	[self.usingCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *aCell, BOOL *stop) {
		if (aCell.frame.origin.y == y) {
			cell = aCell;
			*stop = YES;
		}
	}];
	return cell;
}

- (CGFloat)positionOfIndex:(NSUInteger)index {
	CGFloat height = 0;
	for (NSUInteger i = 0; i < index; i++) {
		height += [self.dataSource collectionView:self heightForItemAtIndex:i];
	}
	return height;
}

- (NSUInteger)indexOfPosition:(CGFloat)y {
	NSInteger number = [self.dataSource numberOfItemsInCollectionView:self];
	CGFloat height = 0;
	for (NSUInteger i = 0; i < number; i++) {
		height += [self.dataSource collectionView:self heightForItemAtIndex:i];
		if (height > y) {
			return i;
		}
	}
	return 0;
}

- (void)queueReusableCell:(LFCollectionViewCell *)cell {
	[self.reusableCells addObject:cell];
}

- (LFCollectionViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
	__block LFCollectionViewCell *cell = nil;
	[self.reusableCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *aCell, BOOL *stop) {
		if ([aCell.identifier isEqualToString:identifier]) {
			cell = aCell;
			*stop = YES;
		}
	}];

	if (cell) {
		[self.reusableCells removeObject:cell];
	}
	return cell;
}

#pragma mark - Handling selection

@end
