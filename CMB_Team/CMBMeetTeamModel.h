//
//  CMBMeetTeamModel.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMBMeetTeamMember : NSObject
@property (nonatomic,strong) NSString *avatarURLString;
@property (nonatomic,strong) UIImage *profileImage;
@property (nonatomic,strong) NSString *bio;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *lastname;
@property (nonatomic,strong) NSString *jobTitle;
@property (nonatomic,assign) int numID;
@property (nonatomic,assign) BOOL isVisited;
- (NSAttributedString*) getNameJobTitleAttributedString;
@end

@interface CMBMeetTeamModel : NSObject
+ (instancetype)sharedInstance;
- (NSArray *)allTeamMembers;
- (void)getImageForUIImageView:(UIImageView*)imageView teamMember:(CMBMeetTeamMember*)teamMember;
@end
