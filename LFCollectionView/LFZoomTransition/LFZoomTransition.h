//
//  LFZoomTransition.h
//  LFCollectionView
//
//  Created by Young One Park on 2015. 8. 20..
//  Copyright (c) 2015년 young1park. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFZoomTransitionProtocol <NSObject>

@required

- (UIView *)zoomTransitionView;

@end

@interface LFZoomTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id <LFZoomTransitionProtocol> startingTransition;
@property (nonatomic, weak) id <LFZoomTransitionProtocol> finishingTransition;

+ (LFZoomTransition *)zoomTransitionWithStart:(id)start finish:(id)finish;

@end
