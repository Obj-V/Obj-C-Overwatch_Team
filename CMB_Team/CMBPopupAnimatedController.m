//
//  CMBPopupAnimatedController.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBPopupAnimatedController.h"
#import "CMBMeetTeamDetailViewController.h"
#import "CMBMeetTeamDetailView.h"

static const float kPresentingAnimationDuration = 0.4;
static const float kDismissingAnimationDuration = 0.2;

@implementation CMBPopupAnimatedController

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  self.isPresenting ? kPresentingAnimationDuration : kDismissingAnimationDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *animatedView;
    CGFloat animationDuration;
    CGAffineTransform initialTransform;
    CGAffineTransform finalTransform;
    CGFloat initialAlpha;
    CGFloat finalAlpha;
    CGFloat springDamp;
    
    if (self.isPresenting) {
        animatedView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:animatedView];
        animatedView.frame = [transitionContext finalFrameForViewController:toViewController];
        initialTransform = CGAffineTransformMakeScale(0.01, 0.01);
        finalTransform = CGAffineTransformIdentity;
        initialAlpha = 0;
        finalAlpha = 1;
        springDamp = 0.5;
        animationDuration = kPresentingAnimationDuration;
    } else {
        animatedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        initialTransform = CGAffineTransformIdentity;
        finalTransform = CGAffineTransformMakeScale(0.01, 0.01);
        initialAlpha = 1;
        finalAlpha = 0;
        springDamp = 1.0;
        animationDuration = kDismissingAnimationDuration;
    }
    
    animatedView.transform = initialTransform;
    animatedView.alpha = initialAlpha;
    [UIView animateWithDuration:animationDuration delay:0.0 usingSpringWithDamping:springDamp initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animatedView.transform = finalTransform;
        animatedView.alpha = finalAlpha;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
