//
//  CMBMeetTeamTableViewCell.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMBMeetTeamViewModel;

static NSString *kMeetTeamCellID = @"CMBMeetTeamCell";

@interface CMBMeetTeamTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *profileImageView;
- (void)setupWithTeamViewModel:(CMBMeetTeamViewModel*)teamViewModel;
@end
