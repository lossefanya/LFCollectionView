//
//  LFCollectionViewCell.h
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSUInteger, LFCollectionViewCellType) {
	LFCollectionViewCellTypeImage = 0,
	LFCollectionViewCellTypeMap
};

@interface LFCollectionViewCell : UIView

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic) LFCollectionViewCellType type;
@property (nonatomic) BOOL isDeleting;

/**
 The cell should be initialized using this class method. This will get LFCollectionViewCellType as a parameter.
 LFCollectionViewCellTypeImage : This type of cell have a image view on left.
 LFCollectionViewCellTypeMap : This type of cell have a map view on left.
 */
+ (LFCollectionViewCell *)cellWithType:(LFCollectionViewCellType)type;
- (void)setFrame:(CGRect)frame;

@end
