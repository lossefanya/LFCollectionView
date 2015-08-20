//
//  LFZoomTransition.h
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFZoomTransitionProtocol <NSObject>

@required

- (UIView *)zoomTransitionView;

@end

@interface LFZoomTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id <LFZoomTransitionProtocol> startingTransition;
@property (nonatomic, weak) id <LFZoomTransitionProtocol> finishingTransition;
@property (nonatomic, strong) UIColor *backgroundColor;//background color while transition

/**
 Implement UIViewControllerTransitioningDelegate.
 Then, return an instance of this class in each of delegate method.
 Set view controllers as start and finish.
 Each view controllers should implement LFZoomTransitionProtocol.
 */
+ (LFZoomTransition *)zoomTransitionWithStart:(id)start finish:(id)finish;

@end
