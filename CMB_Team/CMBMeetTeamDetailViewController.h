//
//  CMBMeetTeamDetailViewController.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBMeetTeamDetailView.h"
#import "CMBMeetTeamModel.h"

@interface CMBMeetTeamDetailViewController : UIViewController <UIViewControllerTransitioningDelegate>
-(instancetype)initWithTeamMember:(CMBMeetTeamMember*)teamMember;
@end
