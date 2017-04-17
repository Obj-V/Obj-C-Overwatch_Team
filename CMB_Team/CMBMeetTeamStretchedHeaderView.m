//
//  CMBMeetTeamStretchedHeaderView.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamStretchedHeaderView.h"

@implementation CMBMeetTeamStretchedHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundImageView.image = [UIImage imageNamed:@"logo"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.backgroundImageView];
    
    self.mainLabel = [[UILabel alloc] init];
    self.mainLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainLabel.text = @"Meet The Team";
    self.mainLabel.textColor = [UIColor redColor];
    self.mainLabel.font = [UIFont fontWithName:@"Futura-Medium" size:30];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    self.mainLabel.adjustsFontSizeToFitWidth = YES;
    self.mainLabel.minimumScaleFactor = 0.5;
    self.mainLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.mainLabel];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    //mainLabel
    NSLayoutConstraint *mainLabelWidth = [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0];
    NSLayoutConstraint *mainLabelHeight = [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bounds.size.height/4];
    NSLayoutConstraint *mainLabelCenterX = [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *mainLabelBottom = [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[mainLabelWidth,mainLabelHeight,mainLabelCenterX,mainLabelBottom]];
    
    //backgroundImageView
    NSLayoutConstraint *backgroundImageViewWidth = [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *backgroundImageViewHeight = [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *backgroundImageViewCenterX = [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *backgroundImageViewCenterY = [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraints:@[backgroundImageViewWidth,backgroundImageViewHeight,backgroundImageViewCenterX,backgroundImageViewCenterY]];
}

@end
