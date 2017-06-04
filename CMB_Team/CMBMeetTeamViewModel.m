//
//  CMBMeetTeamViewModel.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamMember.h"
#import "CMBMeetTeamViewModel.h"
#import "CMBMeetTeamTableViewCell.h"
#import "CMBMeetTeamNetworkManager.h"
#import "CMBMeetTeamDetailView.h"

@implementation CMBMeetTeamViewModel

-(instancetype)initWithTeamMember:(CMBMeetTeamMember*)teamMember {
    self = [self init];
    if (self) {
        _teamMember = teamMember;
        _isVisited = NO;
        _profileImage = nil;
        _profileDefaultImage = [UIImage imageNamed:@"user"];
        _nameWithJobTitleAttributedString = [self getNameJobTitleAttributedString];
        _mainOperation = nil;
        _detailViewOperation = nil;
    }
    return self;
}

+ (NSArray *)teamViewModelArrayFromTeamModelArray:(NSArray*)teamArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(CMBMeetTeamMember *teamMember in teamArray) {
        CMBMeetTeamViewModel *teamViewModel = [[CMBMeetTeamViewModel alloc] initWithTeamMember:teamMember];
        [array addObject:teamViewModel];
    }
    
    return [array copy];
}

#pragma mark - Tableview methods
- (CMBMeetTeamTableViewCell*)cellInstance:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CMBMeetTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMeetTeamCellID];
    [cell setupWithTeamViewModel:self];
    
    if (self.profileImage == nil) {
        NSLog(@"Start %@'s mainOperation", self.teamMember.firstname);
        
        [CMBMeetTeamNetworkManager imageForTeamMember:self completionBlock:^(UIImage *profileImage) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                CMBMeetTeamTableViewCell *currentCell = (CMBMeetTeamTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
                if (currentCell && profileImage) {
                    currentCell.profileImageView.image = profileImage;
                }
            }];
        }];
    }
    
    return cell;
}

- (void)resetCellInstanceAfterShown {
    self.isVisited = YES;
    if (self.mainOperation) {
        NSLog(@"Cencel %@'s mainOperation", self.teamMember.firstname);
        [CMBMeetTeamNetworkManager cancelImageOperationForTeamMember:self];
    }
}

#pragma mark - DetailView 
- (CMBMeetTeamDetailView*)detailViewInstance {
    CMBMeetTeamDetailView *detailView = [[CMBMeetTeamDetailView alloc] initWithFrame:CGRectZero teamViewModel:self];

    if (self.profileImage == nil && self.mainOperation.isExecuting) {
        NSLog(@"MainImageOperation is executing. Add a detailView dependent operation");
        [CMBMeetTeamNetworkManager addDetailViewDependencyForExistingImageOperation:self completionBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (detailView) {
                    detailView.profileImageView.image = self.profileImage;
                }
            }];
        }];
    }
    
    return detailView;
}

- (void)resetDetailViewInstance {
    if (self.mainOperation && self.detailViewOperation) {
        NSLog(@"Cencel %@'s detailView Operation", self.teamMember.firstname);
        [CMBMeetTeamNetworkManager removeDependencyForTeamMember:self];
    }
}

#pragma mark - Private methods
-(NSAttributedString *)getNameJobTitleAttributedString {
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", self.teamMember.firstname, self.teamMember.lastname];
    NSMutableAttributedString *nameLabelAttributedString = [[NSMutableAttributedString alloc] initWithString:nameString attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20], NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSAttributedString *jobTitleAttributedString = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"\n%@",self.teamMember.jobTitle] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15], NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [nameLabelAttributedString appendAttributedString: jobTitleAttributedString];
    return [nameLabelAttributedString copy];
}

@end
