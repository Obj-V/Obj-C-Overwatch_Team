//
//  CMBMeetTeamDetailView.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamDetailView.h"
#import "CMBMeetTeamViewModel.h"

@interface CMBMeetTeamDetailView ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *jobTitleLabel;
@property (nonatomic,strong) UITextView *bioTextView;
@property (nonatomic,strong) CMBMeetTeamViewModel *teamViewModel;
@end

@implementation CMBMeetTeamDetailView

-(instancetype)initWithFrame:(CGRect)frame teamViewModel:(CMBMeetTeamViewModel*)teamViewModel {
    self = [super initWithFrame:frame];
    if (self) {
        _teamViewModel = teamViewModel;
        [self setupSubviews];
    }
    return self;
}

-(void)dealloc {
    [self.teamViewModel resetDetailViewInstance];
}

- (void)setupSubviews {
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor whiteColor];
    
    self.profileImageView = [[UIImageView alloc] init];
    self.profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.profileImageView.backgroundColor = [UIColor clearColor];
    self.profileImageView.image = self.teamViewModel.profileImage ? self.teamViewModel.profileImage : self.teamViewModel.profileDefaultImage;
    [self addSubview:self.profileImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.minimumScaleFactor = 0.5;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.attributedText = self.teamViewModel.nameWithJobTitleAttributedString;
    [self addSubview:self.nameLabel];
    
    self.bioTextView = [[UITextView alloc] init];
    self.bioTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bioTextView.text = self.teamViewModel.teamMember.bio;
    self.bioTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    self.bioTextView.textAlignment = NSTextAlignmentNatural;
    self.bioTextView.textColor = [UIColor grayColor];
    self.bioTextView.editable = NO;
    self.bioTextView.showsVerticalScrollIndicator = NO;
    self.bioTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bioTextView];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    //profileImageView
    NSLayoutConstraint *profileImageViewWidth = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeHeight multiplier:0.9 constant:0];
    NSLayoutConstraint *profileImageViewHeight = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0];
    NSLayoutConstraint *profileImageViewCenterX = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *profileImageViewTop = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.2 constant:0];
    [self addConstraints:@[profileImageViewWidth,profileImageViewHeight,profileImageViewCenterX,profileImageViewTop]];
    
    //nameLabel
    NSLayoutConstraint *nameLabelWidth = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0];
    NSLayoutConstraint *nameLabelHeight = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.1 constant:0];
    NSLayoutConstraint *nameLabelCenterX = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *nameLabelTop = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[nameLabelWidth,nameLabelHeight,nameLabelCenterX,nameLabelTop]];
    
    //bioView
    NSLayoutConstraint *bioViewWidth = [NSLayoutConstraint constraintWithItem:self.bioTextView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *bioViewCenterX = [NSLayoutConstraint constraintWithItem:self.bioTextView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *bioViewTop = [NSLayoutConstraint constraintWithItem:self.bioTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *bioViewBottom = [NSLayoutConstraint constraintWithItem:self.bioTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.95 constant:0];
    [self addConstraints:@[bioViewWidth,bioViewCenterX,bioViewTop,bioViewBottom]];
}

@end
