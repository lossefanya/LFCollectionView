//
//  LFCollectionViewCell.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "LFCollectionViewCell.h"

#define DELETE_BUTTON_WIDTH 75

@implementation LFCollectionViewCell

+ (LFCollectionViewCell *)cellWithType:(LFCollectionViewCellType)type {
	LFCollectionViewCell *cell = [LFCollectionViewCell new];
	
	NSString *className = NSStringFromClass([self class]);
	UIView *contentView = [[[NSBundle mainBundle] loadNibNamed:className owner:cell options:nil] firstObject];
	[cell addSubview:contentView];
	
	UIButton *deleteButton = [UIButton new];
	[deleteButton setTitle:@"DELETE" forState:UIControlStateNormal];
	[deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	deleteButton.backgroundColor = [UIColor redColor];
	[cell insertSubview:deleteButton belowSubview:cell.contentView];
	cell.deleteButton = deleteButton;
	
	UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:cell action:@selector(swipe:)];
	leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
	[cell addGestureRecognizer:leftSwipe];
	
	UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:cell action:@selector(swipe:)];
	rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
	[cell addGestureRecognizer:rightSwipe];

	cell.type = type;
	switch (type) {
		case LFCollectionViewCellTypeImage:
			cell.mapView.hidden = YES;
			break;
		case LFCollectionViewCellTypeMap:
			cell.imageView.hidden = YES;
			break;
		default:
			break;
	}
	return cell;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	self.contentView.frame = self.bounds;
	self.deleteButton.frame = CGRectMake(CGRectGetWidth(self.frame) - DELETE_BUTTON_WIDTH, 0, DELETE_BUTTON_WIDTH, CGRectGetHeight(self.frame));
	self.isDeleting = NO;
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe {
	switch (swipe.direction) {
		case UISwipeGestureRecognizerDirectionLeft:
			[self toggleDeleteButton:YES];
			break;
		case UISwipeGestureRecognizerDirectionRight:
			[self toggleDeleteButton:NO];
			break;
		default:
			break;
	}
}

- (void)toggleDeleteButton:(BOOL)show {
	if (self.isDeleting == show) {
		return;
	}
	self.isDeleting = show;
	[UIView animateWithDuration:.3 animations:^{
		if (show) {
			self.contentView.frame = CGRectOffset(self.contentView.frame, - DELETE_BUTTON_WIDTH, 0);
		} else {
			self.contentView.frame = CGRectOffset(self.contentView.frame, DELETE_BUTTON_WIDTH, 0);
		}
	}];
}

@end
