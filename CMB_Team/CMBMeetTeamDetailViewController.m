//
//  CMBMeetTeamDetailViewController.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamDetailViewController.h"
#import "CMBPopupAnimatedController.h"
#import "CMBPopupPresentationController.h"
#import "CMBMeetTeamDetailView.h"
#import "CMBMeetTeamViewModel.h"

@interface CMBMeetTeamDetailViewController ()
@property (nonatomic,strong) CMBMeetTeamDetailView *detailView;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) CMBMeetTeamViewModel *teamViewModel;
@end

@implementation CMBMeetTeamDetailViewController

-(instancetype)initWithTeamViewModel:(CMBMeetTeamViewModel*)teamViewModel;{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _teamViewModel = teamViewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    self.detailView = [self.teamViewModel detailViewInstance];
    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.detailView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.closeButton.backgroundColor = [UIColor whiteColor];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    //detailView
    NSLayoutConstraint *detailViewWidth = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0];
    NSLayoutConstraint *detailViewHeight = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0];
    NSLayoutConstraint *detailViewCenterX = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *detailViewCenterY = [NSLayoutConstraint constraintWithItem:self.detailView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraints:@[detailViewWidth,detailViewHeight,detailViewCenterX,detailViewCenterY]];
    
    //closeButton
    NSLayoutConstraint *closeButtonWidth = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0];
    NSLayoutConstraint *closeButtonHeight = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.05 constant:0];
    NSLayoutConstraint *closeButtonCenterX = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *closeButtonCenterY = [NSLayoutConstraint constraintWithItem:self.closeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraints:@[closeButtonWidth,closeButtonHeight,closeButtonCenterX,closeButtonCenterY]];
}

- (void)closeButtonPressed:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    CMBPopupAnimatedController *popupController = [[CMBPopupAnimatedController alloc] init];
    popupController.isPresenting = YES;
    return popupController;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CMBPopupAnimatedController *popupController = [[CMBPopupAnimatedController alloc] init];
    popupController.isPresenting = NO;
    return popupController;
}

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[CMBPopupPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
