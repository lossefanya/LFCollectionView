//
//  LFZoomTransition.m
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015 young1park. All rights reserved.
//

#import "LFZoomTransition.h"

@implementation LFZoomTransition

+ (LFZoomTransition *)zoomTransitionWithStart:(id)start finish:(id)finish {
	if ([start conformsToProtocol:@protocol(LFZoomTransitionProtocol)] && [finish conformsToProtocol:@protocol(LFZoomTransitionProtocol)]) {
		LFZoomTransition *zoom = [LFZoomTransition new];
		zoom.startingTransition = start;
		zoom.finishingTransition = finish;
		return zoom;
	}
	return nil;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return .6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	containerView.backgroundColor = self.backgroundColor;
	[containerView addSubview:fromVC.view];
	[containerView addSubview:toVC.view];
	toVC.view.alpha = 0;

	UIView *transitioningView = self.startingTransition.zoomTransitionView;
	[containerView addSubview:transitioningView];
	
	[UIView animateWithDuration:.4 animations:^{
		fromVC.view.alpha = 0;
		transitioningView.frame = self.finishingTransition.zoomTransitionView.frame;
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:.2 animations:^{
			toVC.view.alpha = 1;
			transitioningView.alpha = 0;
		} completion:^(BOOL finished) {
			[transitioningView removeFromSuperview];
			[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
		}];
	}];
}

@end
