//
//  CMBTeamMember.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBMeetTeamMember : NSObject
@property (nonatomic,strong) NSString *avatarURLString;
@property (nonatomic,strong) NSString *bio;
@property (nonatomic,strong) NSString *firstname;
@property (nonatomic,strong) NSString *lastname;
@property (nonatomic,strong) NSString *jobTitle;
@property (nonatomic,assign) int numID;
@end
