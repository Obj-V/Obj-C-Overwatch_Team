//
//  CMBMeetTeamViewModel.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMBMeetTeamMember.h"
#import "CMBOperation.h"
@class CMBMeetTeamTableViewCell;
@class CMBMeetTeamDetailView;

@interface CMBMeetTeamViewModel : NSObject
@property (nonatomic,strong) CMBMeetTeamMember *teamMember;
@property (nonatomic,strong) UIImage *profileImage;
@property (nonatomic,strong) UIImage *profileDefaultImage;
@property (nonatomic,assign) BOOL isVisited;
@property (nonatomic,strong) NSAttributedString *nameWithJobTitleAttributedString;

@property (nonatomic,weak) CMBOperation *mainOperation;
@property (nonatomic,weak) NSBlockOperation *detailViewOperation;

-(instancetype)initWithTeamMember:(CMBMeetTeamMember*)teamMember;
+ (NSArray *)teamViewModelArrayFromTeamModelArray:(NSArray*)teamArray;

- (CMBMeetTeamTableViewCell*)cellInstance:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
- (void)resetCellInstanceAfterShown;

- (CMBMeetTeamDetailView*)detailViewInstance;
- (void)resetDetailViewInstance;

@end
