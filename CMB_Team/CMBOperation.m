//
//  CMBOperation.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBOperation.h"
#import "CMBMeetTeamNetworkManager.h"
#import "CMBMeetTeamViewModel.h"

@interface CMBOperation ()
@property (nonatomic,weak) CMBMeetTeamViewModel* teamViewModel;
@property (nonatomic,copy) void(^imageCompletionBlock)(UIImage*image);
@end

@implementation CMBOperation

-(instancetype)initWithViewModel:(CMBMeetTeamViewModel*)teamViewModel imageCompletionBlock:(void(^)(UIImage*image))imageCompletionBlock {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
        _teamViewModel = teamViewModel;
        _imageCompletionBlock = imageCompletionBlock;
    }
    return self;
}

#pragma mark - State
-(BOOL)isConcurrent {
    return YES;
}
-(BOOL)isAsynchronous {
    return YES;
}

-(BOOL)isExecuting {
    return executing;
}

-(BOOL)isFinished {
    return finished;
}

#pragma mark - Control
-(void)start {
    if ([self isCancelled]) {
        return [self cancelOperation];
    }
    
    if ([self isExecuting] == NO) {
        [self willChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        executing = YES;
        finished = NO;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        
        [self fetchingImage];
    }
}

- (void)fetchingImage {
    //If image exists in teamMember object.
    if (self.teamViewModel.profileImage) {
        self.imageCompletionBlock(self.teamViewModel.profileImage);
        return [self completeOperation];
    }
    
    //If it's stored in the disk.
    NSString *imagePath = [CMBMeetTeamNetworkManager checkExistingImageDataPathWithTeamMember:self.teamViewModel];
    if (imagePath) {
        NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:imagePath];
        self.teamViewModel.profileImage = [UIImage imageWithData:imageData];
        self.imageCompletionBlock(self.teamViewModel.profileImage);
        return [self completeOperation];
    }
    
    //Cancel operation before downloading.
    if ([self isCancelled]) {
        return [self cancelOperation];
    }
    
    //If can't find image data, download it.
    NSString *imageURLString = self.teamViewModel.teamMember.avatarURLString;
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            self.imageCompletionBlock(nil);
            return [self completeOperation];
        }
        
        //If the current operation is cancelled, stop downloading image.
        if ([self isCancelled]) {
            NSLog(@"%@'s mainOperation is cancelled during the downloading process", self.teamViewModel.teamMember.firstname);
            self.imageCompletionBlock(nil);
            return [self cancelOperation];
        }
        
        if (data) {
            NSString *documentDir = [CMBMeetTeamNetworkManager getDocumentDirectory];
            NSString *path = [NSString stringWithFormat:@"%@/%@", documentDir, imageURLString];
            NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[NSFileManager defaultManager] createFileAtPath:escapedPath contents:data attributes:nil];
            self.teamViewModel.profileImage = [UIImage imageWithData:data];
            
            if ([self isCancelled]) {
                self.imageCompletionBlock(nil);
            } else {
                self.imageCompletionBlock(self.teamViewModel.profileImage);
            }
        }
        
        [self completeOperation];
    }] resume];
}

#pragma mark - Helper methods

- (void)cancelOperation {
    [self willChangeValueForKey:@"isFinished"];
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
