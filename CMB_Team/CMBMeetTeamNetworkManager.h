//
//  CMBMeetTeamNetworkManager.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CMBMeetTeamViewModel;

@interface CMBMeetTeamNetworkManager : NSObject
+ (NSString*)getDocumentDirectory;
+ (NSString*)checkExistingImageDataPathWithTeamMember:(CMBMeetTeamViewModel*)teamViewModel;

+ (void)loadTeamDataWithPath:(NSString*)filePath completion:(void(^)(NSArray *dataArray))completionblock;
+ (void)imageForTeamMember:(CMBMeetTeamViewModel*)teamViewModel completionBlock:(void(^)(UIImage *profileImage))completionBlock;
+ (void)cancelImageOperationForTeamMember:(CMBMeetTeamViewModel*)teamViewModel;
+ (void)addDetailViewDependencyForExistingImageOperation:(CMBMeetTeamViewModel*)teamViewModel completionBlock:(void(^)())completionBlock;
+ (void)removeDependencyForTeamMember:(CMBMeetTeamViewModel*)teamViewModel;
@end
