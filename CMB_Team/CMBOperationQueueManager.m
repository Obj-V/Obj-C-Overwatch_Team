//
//  CMBOperationQueueManager.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/4/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBOperationQueueManager.h"

@interface CMBOperationQueueManager ()
@property (nonatomic,strong) NSOperationQueue *queue;
@end

@implementation CMBOperationQueueManager

#pragma mark - Init methods
+ (instancetype)sharedInstance {
    static CMBOperationQueueManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CMBOperationQueueManager alloc] initSingleton];
    });
    return instance;
}

-(instancetype)initSingleton {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

-(instancetype)init {
    NSLog(@"Please use sharedInstance for CMBOperationQueueManager");
    return nil;
}

#pragma Public methods 
- (void)addOperation:(NSOperation*)operation {
    [self.queue addOperation:operation];
}

- (void)cancelOperation:(NSOperation*)operation {
    [operation cancel];
}

- (void)addDependentOperation:(NSOperation*)dependentOperation toMainOperation:(NSOperation*)mainOperation {
    [dependentOperation addDependency:mainOperation];
}

- (void)removeDependentOperation:(NSOperation*)dependentOperation fromMainOperation:(NSOperation*)mainOperation {
    [mainOperation removeDependency:dependentOperation];
}
@end
