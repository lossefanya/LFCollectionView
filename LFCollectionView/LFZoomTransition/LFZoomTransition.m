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
	return .4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	//TODO: animate transition
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	[containerView addSubview:fromVC.view];
	[containerView addSubview:toVC.view];
	toVC.view.alpha = 0;

	UIView *transitioningView = self.startingTransition.zoomTransitionView;
	[containerView addSubview:transitioningView];
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
		fromVC.view.alpha = 0;
		toVC.view.alpha = 1;
		transitioningView.frame = self.finishingTransition.zoomTransitionView.frame;
	} completion:^(BOOL finished) {
		[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
	}];
}

@end
