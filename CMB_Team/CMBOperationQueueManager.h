//
//  CMBOperationQueueManager.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/4/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBOperationQueueManager : NSObject
+ (instancetype)sharedInstance;
- (void)addOperation:(NSOperation*)operation;
- (void)cancelOperation:(NSOperation*)operation;
- (void)addDependentOperation:(NSOperation*)dependentOperation toMainOperation:(NSOperation*)mainOperation;
- (void)removeDependentOperation:(NSOperation*)dependentOperation fromMainOperation:(NSOperation*)mainOperation;
@end
