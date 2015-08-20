//
//  ViewController.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "ViewController.h"
#import "LFCollectionView.h"
#import "LFCollectionViewCell.h"

@interface ViewController () <LFCollectionViewDataSource, LFCollectionViewDelegate>

@property (nonatomic, weak) LFCollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	LFCollectionView *collectionView = [[LFCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	collectionView.dataSource = self;
	collectionView.actionDelegate = self;
	[collectionView reloadData];
	[self.view addSubview:collectionView];
	self.collectionView = collectionView;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - LFCollectionViewDataSource

- (NSInteger)numberOfItemsInCollectionView:(LFCollectionView *)collectionView {
	return 50;
}

- (LFCollectionViewCell *)collectionView:(LFCollectionView *)collectionView cellForItemAtIndex:(NSUInteger)index {
	LFCollectionViewCell *cell = [collectionView dequeueReusableCellWithIdentifier:@"MapCell"];
	if (!cell) {
		cell = [LFCollectionViewCell new];
		cell.identifier = @"MapCell";
		cell.backgroundColor = [UIColor redColor];
		
		UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
		line.backgroundColor = [UIColor lightGrayColor];
		[cell addSubview:line];
	}
	return cell;
}

- (CGFloat)collectionView:(LFCollectionView *)collectionView heightForItemAtIndex:(NSUInteger)index {
	return 44.f;
}

@end
