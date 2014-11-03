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

typedef void (^LoginSuccessBlock)(NSString *strToken);
typedef void (^LoginFailBlock)(NSString *strFail);

@interface ProfileRequestService : HttpRequestService

- (void)userRegisterWithUserName:(NSString *)userName password:(NSString *)pwd district:(NSInteger)disId success:(RegisterSuccessBlock)successBlock error:(RegisterFailBlock)errorBlock;
- (void)loginWithName:(NSString *)userName password:(NSString *)pwd success:(LoginSuccessBlock)successBlock error:(LoginFailBlock)errorBlock;

@end
