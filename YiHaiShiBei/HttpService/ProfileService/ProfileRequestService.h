//
//  ProfileRequestService.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

typedef void (^RegisterSuccessBlock)(NSString *modelLocation);
typedef void (^RegisterFailBlock)(NSString *strFail);

@interface ProfileRequestService : HttpRequestService

- (void)userRegisterWithUserName:(NSString *)userName password:(NSString *)pwd district:(NSInteger)disId success:(RegisterSuccessBlock)successBlock error:(RegisterFailBlock)errorBlock;

@end
