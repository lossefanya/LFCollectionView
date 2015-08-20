//
//  DetailViewController.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
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
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 50, 44)];
	[button setTitle:@"Back" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	
	CGRect screen = [UIScreen mainScreen].bounds;
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.width)];
	imageView.center = CGPointMake(CGRectGetMidX(screen), CGRectGetMidY(screen));
	[self.view addSubview:imageView];
	self.imageView = imageView;
	
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:imageView.frame];
	mapView.center = imageView.center;
	[self.view addSubview:mapView];
	self.mapView = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIsMapView:(BOOL)isMapView {
	_isMapView = isMapView;
	if (isMapView) {
		[self.imageView removeFromSuperview];
	} else {
		[self.mapView removeFromSuperview];
	}
}

- (void)close {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)zoomTransitionView {
	if (!self.isMapView) {
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
