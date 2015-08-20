//
//  LFCollectionViewCell.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "LFCollectionViewCell.h"

@implementation LFCollectionViewCell

+ (LFCollectionViewCell *)cellWithType:(LFCollectionViewCellType)type {
	NSString *className = NSStringFromClass([self class]);
	LFCollectionViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] firstObject];
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

@end
