//
//  CMBMeetTeamTableViewCell.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamTableViewCell.h"
#import "CMBMeetTeamViewModel.h"

@interface CMBMeetTeamTableViewCell()
@property (nonatomic,strong) UIView *basedView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *jobTitleLabel;
@property (nonatomic,strong) UILabel *bioLabel;
@property (nonatomic,strong) UIImage *defaultImage;
@end

@implementation CMBMeetTeamTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.basedView.backgroundColor = [UIColor grayColor];
        self.bioLabel.textColor = [UIColor whiteColor];
    } else {
        self.basedView.backgroundColor = [UIColor whiteColor];
        self.bioLabel.textColor = [UIColor grayColor];
    }
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [self setToDefaultCell];
}

- (void)setToDefaultCell {
    self.profileImageView.image = self.defaultImage;
    self.nameLabel.text = @"";
    self.jobTitleLabel.text = @"";
    self.bioLabel.text = @"";
}

- (void)setupWithTeamViewModel:(CMBMeetTeamViewModel*)teamViewModel {
    self.nameLabel.attributedText = teamViewModel.nameWithJobTitleAttributedString;
    self.jobTitleLabel.text = teamViewModel.teamMember.jobTitle;
    self.bioLabel.text = teamViewModel.teamMember.bio;
    self.profileImageView.image = teamViewModel.profileImage ? teamViewModel.profileImage : teamViewModel.profileDefaultImage;
    if (self.defaultImage == nil) {
        self.defaultImage = teamViewModel.profileDefaultImage;
    }
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.basedView = [[UIView alloc] init];
    self.basedView.backgroundColor = [UIColor whiteColor];
    self.basedView.translatesAutoresizingMaskIntoConstraints = NO;
    self.basedView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.basedView.layer.shadowOffset = CGSizeMake(5, 5);
    self.basedView.layer.shadowRadius = 3;
    self.basedView.layer.shadowOpacity = 0.3;
    [self.contentView addSubview:self.basedView];
    
    self.profileImageView = [[UIImageView alloc] init];
    self.profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.basedView addSubview:self.profileImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.minimumScaleFactor = 0.5;
    self.nameLabel.backgroundColor = [UIColor clearColor];
    [self.basedView addSubview:self.nameLabel];
    
    self.bioLabel = [[UILabel alloc] init];
    self.bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bioLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    self.bioLabel.textAlignment = NSTextAlignmentNatural;
    self.bioLabel.numberOfLines = 0;
    self.bioLabel.textColor = [UIColor grayColor];
    self.bioLabel.backgroundColor = [UIColor clearColor];
    [self.basedView addSubview:self.bioLabel];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    //basedView
    NSLayoutConstraint *basedViewWidth = [NSLayoutConstraint constraintWithItem:self.basedView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0];
    NSLayoutConstraint *basedViewHeight = [NSLayoutConstraint constraintWithItem:self.basedView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:0.9 constant:0];
    NSLayoutConstraint *basedViewCenterX = [NSLayoutConstraint constraintWithItem:self.basedView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *basedViewCenterY = [NSLayoutConstraint constraintWithItem:self.basedView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.contentView addConstraints:@[basedViewWidth,basedViewHeight,basedViewCenterX,basedViewCenterY]];
    
    //profileImageView
    NSLayoutConstraint *profileimageViewWidth = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0];
    NSLayoutConstraint *profileimageViewHeight = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeHeight multiplier:0.9 constant:0];
    NSLayoutConstraint *profileimageViewCenterX = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeCenterX multiplier:0.5 constant:0];
    NSLayoutConstraint *profileimageViewCenterY = [NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.basedView addConstraints:@[profileimageViewWidth,profileimageViewHeight,profileimageViewCenterX,profileimageViewCenterY]];
    
    //nameLabel
    NSLayoutConstraint *nameLabelWidth = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeWidth multiplier:0.45 constant:0];
    NSLayoutConstraint *nameLabelHeight = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeHeight multiplier:0.25 constant:0];
    NSLayoutConstraint *nameLabelLeading = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.basedView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *nameLabelTop = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.basedView addConstraints:@[nameLabelWidth,nameLabelHeight,nameLabelLeading,nameLabelTop]];

    //bioLabel
    NSLayoutConstraint *bioLabelWidth = [NSLayoutConstraint constraintWithItem:self.bioLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *bioLabelLeading = [NSLayoutConstraint constraintWithItem:self.bioLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *bioLabelTop = [NSLayoutConstraint constraintWithItem:self.bioLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *bioLabelBottom = [NSLayoutConstraint constraintWithItem:self.bioLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.profileImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.basedView addConstraints:@[bioLabelWidth,bioLabelLeading,bioLabelTop,bioLabelBottom]];
}

@end
