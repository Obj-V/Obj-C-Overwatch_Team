//
//  CMBPopupPresentationController.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBPopupPresentationController.h"

@implementation CMBPopupPresentationController

-(CGRect)frameOfPresentedViewInContainerView {
    CGSize viewSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:self.containerView.bounds.size];
    CGRect frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(viewSize.height/10, viewSize.width/10, viewSize.height/10, viewSize.width/10));
    return frame;
}

-(void)presentationTransitionWillBegin {
    UIView *shadowView = [[UIView alloc] initWithFrame:self.containerView.frame];
    shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    shadowView.alpha = 0;
    [self.containerView insertSubview:shadowView atIndex:0];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        shadowView.alpha = 1;
    } completion:nil];
}

-(void)dismissalTransitionWillBegin {
    UIView *shadowView = self.containerView.subviews[0];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        shadowView.alpha = 0;
    } completion:nil];
}

@end
