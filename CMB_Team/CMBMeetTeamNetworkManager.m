//
//  CMBMeetTeamNetworkManager.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamNetworkManager.h"
#import "CMBMeetTeamViewModel.h"
#import "CMBOperationQueueManager.h"

@implementation CMBMeetTeamNetworkManager
#pragma mark - Public methods
+ (void)loadTeamDataWithPath:(NSString*)filePath completion:(void(^)(NSArray *dataArray))completionblock {
    if (filePath == nil) {
        return;
    }
    
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:&error];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //TODO: Optimize if data > 10000000+
    
    if (dataDict && !error) {
        for (NSDictionary *dict in dataDict) {
            CMBMeetTeamMember *teamMember = [[CMBMeetTeamMember alloc] init];
            teamMember.avatarURLString = dict[@"avatar"];
            teamMember.bio = dict[@"bio"];
            teamMember.firstname = dict[@"firstName"];
            teamMember.lastname = dict[@"lastName"];
            teamMember.jobTitle = dict[@"title"];
            teamMember.numID = dict[@"id"] ? [dict[@"avatar"] intValue] : -1;
            [array addObject:teamMember];
        }
    }
    
    completionblock([array copy]);
}

+ (void)imageForTeamMember:(CMBMeetTeamViewModel*)teamViewModel completionBlock:(void(^)(UIImage *profileImage))completionBlock {
    CMBOperation *operation = [[CMBOperation alloc] initWithViewModel:teamViewModel imageCompletionBlock:completionBlock];
    teamViewModel.mainOperation = operation;
    [[CMBOperationQueueManager sharedInstance] addOperation:operation];
}

+ (void)cancelImageOperationForTeamMember:(CMBMeetTeamViewModel*)teamViewModel {
    CMBOperation *operation = teamViewModel.mainOperation;
    [[CMBOperationQueueManager sharedInstance] cancelOperation:operation];
}

+ (void)addDetailViewDependencyForExistingImageOperation:(CMBMeetTeamViewModel*)teamViewModel completionBlock:(void(^)())completionBlock {
    CMBOperation *mainImageOperation = teamViewModel.mainOperation;
    NSBlockOperation *detailViewOperation = [NSBlockOperation blockOperationWithBlock:completionBlock];
    teamViewModel.detailViewOperation = detailViewOperation;
    
    [[CMBOperationQueueManager sharedInstance] addDependentOperation:detailViewOperation toMainOperation:mainImageOperation];
    [[CMBOperationQueueManager sharedInstance] addOperation:detailViewOperation];
}

+ (void)removeDependencyForTeamMember:(CMBMeetTeamViewModel*)teamViewModel {
    CMBOperation *mainImageOperation = teamViewModel.mainOperation;
    NSBlockOperation *detailViewOperation = teamViewModel.detailViewOperation;
    
    [[CMBOperationQueueManager sharedInstance] removeDependentOperation:detailViewOperation fromMainOperation:mainImageOperation];
    [[CMBOperationQueueManager sharedInstance] cancelOperation:detailViewOperation];
}

#pragma mark - Private methods
+ (NSString*)getDocumentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count>0) {
        return paths[0];
    }
    return nil;
}

+ (NSString*)checkExistingImageDataPathWithTeamMember:(CMBMeetTeamViewModel*)teamViewModel {
    NSString *documentDir = [self getDocumentDirectory];
    if (documentDir) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", documentDir,teamViewModel.teamMember.avatarURLString];
        NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:escapedPath]) {
            return escapedPath;
        }
    }
    return nil;
}

@end
