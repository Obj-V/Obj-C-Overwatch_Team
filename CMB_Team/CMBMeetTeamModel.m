//
//  CMBMeetTeamModel.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamModel.h"

#pragma mark - CMBMeetTeamMember
@interface CMBMeetTeamMember()
@end
@implementation CMBMeetTeamMember
-(NSAttributedString *)getNameJobTitleAttributedString {
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname];
    NSMutableAttributedString *nameLabelAttributedString = [[NSMutableAttributedString alloc] initWithString:nameString attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20], NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSAttributedString *jobTitleAttributedString = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"\n%@",self.jobTitle] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15], NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [nameLabelAttributedString appendAttributedString: jobTitleAttributedString];
    return [nameLabelAttributedString copy];
}
@end

#pragma mark - CMBMeetTeamModel
@interface CMBMeetTeamModel ()
@property (nonatomic,strong) NSDictionary *teamInfoDictionary;
@property (nonatomic,strong) NSArray *teamMemberArray;
@end

@implementation CMBMeetTeamModel

+(instancetype)sharedInstance {
    static CMBMeetTeamModel *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    
    return sharedModel;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self loadJSON];
    }
    return self;
}

- (NSArray*)allTeamMembers {
    return self.teamMemberArray;
}

- (void)getImageForUIImageView:(UIImageView*)imageView teamMember:(CMBMeetTeamMember*)teamMember {
    
    //If image exists in teamMember object
    if (teamMember.profileImage) {
        imageView.image = teamMember.profileImage;
        [imageView setNeedsLayout];
        return;
    }
    
    //If it's stored in the disk
    NSString *imagePath = [self checkExistingImageDataPathWithTeamMember:teamMember];
    if (imagePath) { //Image already downloaded
        NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:imagePath];
        teamMember.profileImage = [UIImage imageWithData:imageData];
        imageView.image = teamMember.profileImage;
        [imageView setNeedsLayout];
        return;
    }
    
    //If can't find image data, download it
    imageView.image = [UIImage imageNamed:@"user"]; //Assign temp profile pic
    NSString *imageURLString = teamMember.avatarURLString;
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        if (data) {
            NSString *documentDir = [self getDocumentDirectory];
            NSString *path = [NSString stringWithFormat:@"%@/%@", documentDir, imageURLString];
            NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[NSFileManager defaultManager] createFileAtPath:escapedPath contents:data attributes:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                teamMember.profileImage = [UIImage imageWithData:data];
                imageView.image = teamMember.profileImage;
                [imageView setNeedsLayout];
            });
        } else {
            NSLog(@"Error : No Image Data from %@", imageURLString);
        }
    });
}

#pragma mark - Private methods
- (void)loadJSON {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"json"];
    if (filePath) {
        NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
        NSError *error;
        self.teamInfoDictionary = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:&error];
        if (!error) {
            [self setupTeamMembers];
        }
    }
}

- (void)setupTeamMembers {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.teamInfoDictionary) {
        CMBMeetTeamMember *teamMember = [[CMBMeetTeamMember alloc] init];
        teamMember.avatarURLString = dict[@"avatar"];
        teamMember.bio = dict[@"bio"];
        teamMember.firstname = dict[@"firstName"];
        teamMember.lastname = dict[@"lastName"];
        teamMember.jobTitle = dict[@"title"];
        teamMember.numID = dict[@"id"] ? [dict[@"avatar"] intValue] : -1;
        teamMember.isVisited = NO;
        [array addObject:teamMember];
    }
    self.teamMemberArray = [array copy];
}

- (NSString*)getDocumentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (paths.count>0) {
        return paths[0];
    }
    return nil;
}

- (NSString*)checkExistingImageDataPathWithTeamMember:(CMBMeetTeamMember*)teamMember {
    NSString *documentDir = [self getDocumentDirectory];
    if (documentDir) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", documentDir,teamMember.avatarURLString];
        NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:escapedPath]) {
            return escapedPath;
        }
    }
    return nil;
}

@end




