//
//  CMBMeetTeamDetailViewController.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMBMeetTeamDetailView;
@class CMBMeetTeamViewModel;

@interface CMBMeetTeamDetailViewController : UIViewController <UIViewControllerTransitioningDelegate>
-(instancetype)initWithTeamViewModel:(CMBMeetTeamViewModel*)teamViewModel;
@end
