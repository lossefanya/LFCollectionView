//
//  DetailViewController.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DetailViewController.h"

#import "LFZoomTransition.h"

@interface DetailViewController () <LFZoomTransitionProtocol>

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) MKMapView *mapView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	CGRect screen = [UIScreen mainScreen].bounds;
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.width)];
	imageView.center = CGPointMake(CGRectGetMidX(screen), CGRectGetMidY(screen));
	[self.view addSubview:imageView];
	self.imageView = imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)zoomTransitionView {
	if (self.isImageView) {
		return self.imageView;
	} else {
		return self.mapView;
	}
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
