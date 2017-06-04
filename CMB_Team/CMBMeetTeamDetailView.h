//
//  CMBMeetTeamDetailView.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMBMeetTeamViewModel;

@interface CMBMeetTeamDetailView : UIView
-(instancetype)initWithFrame:(CGRect)frame teamViewModel:(CMBMeetTeamViewModel*)teamViewModel;
@property (nonatomic,strong) UIImageView *profileImageView;
@end
