//
//  ViewController.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#import "LFCollectionView.h"
#import "LFCollectionViewCell.h"
#import "LFZoomTransition.h"

@interface ViewController () <LFCollectionViewDataSource, LFCollectionViewDelegate, LFZoomTransitionProtocol>

@property (nonatomic, weak) LFCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	LFCollectionView *collectionView = [[LFCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	collectionView.dataSource = self;
	collectionView.actionDelegate = self;
	[self.view addSubview:collectionView];
	self.collectionView = collectionView;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
//	UITableView
}

#pragma mark - LFCollectionViewDataSource

- (NSInteger)numberOfItemsInCollectionView:(LFCollectionView *)collectionView {
	return 50;
}

- (LFCollectionViewCell *)collectionView:(LFCollectionView *)collectionView cellForItemAtIndex:(NSUInteger)index {
	NSArray *cellIDs = @[@"ImageCell", @"MapCell"];
	LFCollectionViewCellType type = index % 5 == 0;
	NSString *cellID = cellIDs[type];
	LFCollectionViewCell *cell = [collectionView dequeueReusableCellWithIdentifier:cellID];
	if (!cell) {
		cell = [LFCollectionViewCell cellWithType:type];
		cell.identifier = cellID;
	}
	if (type == LFCollectionViewCellTypeImage) {
		cell.imageView.image = [UIImage imageNamed:@"kitten"];
	}
	cell.textLabel.text = @(index).stringValue;
	return cell;
}

- (CGFloat)collectionView:(LFCollectionView *)collectionView heightForItemAtIndex:(NSUInteger)index {
	if (index % 2 == 0) {
		return 66.f;
	} else {
		return 44.f;
	}
}

#pragma mark - LFCollectionViewDelegate

- (void)collectionView:(LFCollectionView *)collectionView didSelectItemAtIndex:(NSUInteger)index {
	NSLog(@"%lu", (unsigned long)index);
	
	//TODO: animate transition
}

#pragma mark - LFZoomTransitionProtocol

- (UIView *)zoomTransitionView {
	LFCollectionViewCell *cell = self.collectionView.selectedCell;
	UIView *viewToReturn = nil;
	switch (cell.type) {
		case LFCollectionViewCellTypeImage:
			viewToReturn = cell.imageView;
			break;
		case LFCollectionViewCellTypeMap:
			viewToReturn = cell.mapView;
			break;
		default:
			break;
	}
	UIView *view = [viewToReturn copy];
	view.frame = [viewToReturn convertRect:viewToReturn.frame toView:self.view];
	return view;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																  presentingController:(UIViewController *)presenting
																	  sourceController:(UIViewController *)source {
	return [LFZoomTransition zoomTransitionWithStart:source finish:presented];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	return [LFZoomTransition zoomTransitionWithStart:dismissed finish:self];
}

@end
