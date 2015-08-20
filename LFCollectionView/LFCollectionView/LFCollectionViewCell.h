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
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailTextLabel;

+ (LFCollectionViewCell *)cellWithType:(LFCollectionViewCellType)type;

@end
