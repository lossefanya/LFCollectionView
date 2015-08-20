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
	self.contentSize = CGSizeZero;
	self.usingCells = [NSMutableSet set];
	self.reusableCells = [NSMutableSet set];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCell:)];
	[self addGestureRecognizer:tap];
}

#pragma mark - Populate cells

- (void)reloadData {
	[self refreshContentSize];

	//Q
	[self.usingCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *cell, BOOL *stop) {
		[self queueReusableCell:cell];
		[cell removeFromSuperview];
	}];
	[self.usingCells removeAllObjects];

	[self setNeedsLayout];
}

- (void)refreshContentSize {
	NSInteger number = [self.dataSource numberOfItemsInCollectionView:self];
	CGFloat height = 0;
	for (NSUInteger i = 0; i < number; i++) {
		height += [self.dataSource collectionView:self heightForItemAtIndex:i];
	}
	self.contentSize = CGSizeMake(self.frame.size.width, height);
}

- (void)layoutSubviews {
	NSLog(@"layoutSubviews");
	
	if (self.contentSize.height == 0) {
		[self refreshContentSize];
	}
	
	//Q
	[self.usingCells enumerateObjectsUsingBlock:^(LFCollectionViewCell *cell, BOOL *stop) {
		CGRect area = CGRectMake(0, CGRectGetMinY(self.bounds) - CGRectGetHeight(self.bounds) * .5f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 1.6f);
		if (!CGRectIntersectsRect(cell.frame, area)) {
			[self queueReusableCell:cell];
			[cell removeFromSuperview];
		}
	}];
	[self.usingCells minusSet:self.reusableCells];
	
	//DQ
	//find out index
	NSUInteger first = [self indexOfPosition:CGRectGetMinY(self.bounds)];
	NSUInteger last = [self indexOfPosition:CGRectGetMaxY(self.bounds) + CGRectGetHeight(self.bounds) * .1f];
	if (last == NSUIntegerMax) {
		last = [self.dataSource numberOfItemsInCollectionView:self];
	}
	for (NSUInteger i = first; i < last; i++) {
		LFCollectionViewCell *cell = [self cellOfIndex:i];
		if (!cell) {
			cell = [self.dataSource collectionView:self cellForItemAtIndex:i];
			[self insertSubview:cell atIndex:self.usingCells.count];
			[self.usingCells addObject:cell];
		}
		cell.frame = CGRectMake(0, [self positionOfIndex:i], self.frame.size.width, [self.dataSource collectionView:self heightForItemAtIndex:i]);
	}
	
}

- (LFCollectionViewCell *)cellOfIndex:(NSUInteger)index {
	return [self cellOfPosition:[self positionOfIndex:index]];
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
	return NSUIntegerMax;
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

#pragma mark - Action handlers

- (void)didSelectCell:(UITapGestureRecognizer *)tap {
	CGPoint location = [tap locationInView:self];
	NSInteger index = [self indexOfPosition:location.y];
	if (index != NSUIntegerMax && [self.actionDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndex:)]) {
		self.selectedCell = [self cellOfIndex:index];
		[self.actionDelegate collectionView:self didSelectItemAtIndex:index];
	}
}

- (void)deleteCell:(LFCollectionViewCell *)cell {
	if (self.selectedCell == cell) {
		self.selectedCell = nil;
	}
	
	NSUInteger index = [self indexOfPosition:CGRectGetMidY(cell.frame)];
	if (index != NSUIntegerMax && [self.actionDelegate respondsToSelector:@selector(collectionView:didDeleteItemAtIndex:)]) {
		[self.actionDelegate collectionView:self didDeleteItemAtIndex:index];
		[self reloadData];
		//TODO: animate
	}
}

@end
