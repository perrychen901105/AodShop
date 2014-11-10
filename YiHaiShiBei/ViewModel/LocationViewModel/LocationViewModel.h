//
//  LocationViewModel.h
//  YiHaiShiBei
//
//  Created by qw on 14-11-10.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
#import "HomeIndexService.h"

@protocol LocationIndexViewModelDelegate <NSObject>

- (void)httpSuccess;
- (void)httpError:(NSInteger)errorCode message:(NSString *)errorMessage;

@end

@interface LocationViewModel : NSObject

@end
