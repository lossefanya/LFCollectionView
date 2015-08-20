//
//  ViewController.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "SampleData.h"

#import "LFCollectionView.h"
#import "LFCollectionViewCell.h"
#import "LFZoomTransition.h"

@interface ViewController () <LFCollectionViewDataSource, LFCollectionViewDelegate, LFZoomTransitionProtocol, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) LFCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self prepareData];
	LFCollectionView *collectionView = [[LFCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	collectionView.dataSource = self;
	collectionView.actionDelegate = self;
	[self.view addSubview:collectionView];
	self.collectionView = collectionView;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)prepareData {
	NSMutableArray *datas = [NSMutableArray array];
	for (int i = 0; i < 50; i++) {
		SampleData *data = [SampleData new];
		data.text = @(i).stringValue;
		data.type = i % 5 == 0;
		if (i % 2 == 0) {
			data.height = 66.f;
		} else {
			data.height = 44.f;
		}
		[datas addObject:data];
	}
	self.datas = datas;
}

#pragma mark - LFCollectionViewDataSource

- (NSInteger)numberOfItemsInCollectionView:(LFCollectionView *)collectionView {
	return self.datas.count;
}

- (LFCollectionViewCell *)collectionView:(LFCollectionView *)collectionView cellForItemAtIndex:(NSUInteger)index {
	SampleData *data = self.datas[index];
	NSArray *cellIDs = @[@"ImageCell", @"MapCell"];
	NSString *cellID = cellIDs[data.type];
	LFCollectionViewCell *cell = [collectionView dequeueReusableCellWithIdentifier:cellID];
	if (!cell) {
		cell = [LFCollectionViewCell cellWithType:(NSUInteger)data.type];
		cell.identifier = cellID;
	}
	if (cell.type == LFCollectionViewCellTypeImage) {
		cell.imageView.image = [UIImage imageNamed:@"kitten"];
	}
	cell.textLabel.text = data.text;
	return cell;
}

- (CGFloat)collectionView:(LFCollectionView *)collectionView heightForItemAtIndex:(NSUInteger)index {
	SampleData *data = self.datas[index];
	return data.height;
}

#pragma mark - LFCollectionViewDelegate

- (void)collectionView:(LFCollectionView *)collectionView didSelectItemAtIndex:(NSUInteger)index {
	SampleData *data = self.datas[index];
	DetailViewController *detailViewController = [DetailViewController new];
	detailViewController.isMapView = data.type == SampleDataTypeMap;
	detailViewController.transitioningDelegate = self;
	[self presentViewController:detailViewController animated:YES completion:nil];
}

- (void)collectionView:(LFCollectionView *)collectionView didDeleteItemAtIndex:(NSUInteger)index {
	[self.datas removeObjectAtIndex:index];
}

#pragma mark - LFZoomTransitionProtocol

- (UIView *)zoomTransitionView {
	LFCollectionViewCell *cell = self.collectionView.selectedCell;
	switch (cell.type) {
		case LFCollectionViewCellTypeImage:{
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self convertedFrameOfView:cell.imageView]];
			imageView.image = cell.imageView.image;
			return imageView;
			break;
		}
		case LFCollectionViewCellTypeMap:{
			UIImageView *mapView = [[UIImageView alloc] initWithFrame:[self convertedFrameOfView:cell.mapView]];
			mapView.image = [self imageWithView:cell.mapView];
			return mapView;
			break;
		}
		default:
			return nil;
			break;
	}
}

#pragma mark - Transition helper

- (CGRect)convertedFrameOfView:(UIView *)view {
	return [view convertRect:view.frame toView:self.view];
}

- (UIImage *)imageWithView:(UIView *)view {
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																  presentingController:(UIViewController *)presenting
																	  sourceController:(UIViewController *)source {
	LFZoomTransition *zoom = [LFZoomTransition zoomTransitionWithStart:source finish:presented];
	zoom.backgroundColor = [UIColor whiteColor];
	return zoom;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	LFZoomTransition *zoom = [LFZoomTransition zoomTransitionWithStart:dismissed finish:self];
	zoom.backgroundColor = [UIColor whiteColor];
	return zoom;
}

@end
