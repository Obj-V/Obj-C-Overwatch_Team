//
//  CMBOperation.h
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 6/3/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CMBMeetTeamViewModel;

@interface CMBOperation : NSOperation {
    BOOL isReady;
    BOOL executing;
    BOOL finished;
}
-(instancetype)initWithViewModel:(CMBMeetTeamViewModel*)teamViewModel imageCompletionBlock:(void(^)(UIImage*image))imageCompletionBlock;
@end
