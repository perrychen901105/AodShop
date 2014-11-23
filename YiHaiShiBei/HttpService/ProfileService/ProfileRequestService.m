//
//  ProfileRequestService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProfileRequestService.h"

@implementation ProfileRequestService

static NSString *ActionRegister = @"register";
static NSString *ActionLogin = @"login";
static NSString *ActionGetUserInfo = @"getUserInfo";

- (void)userRegisterWithUserName:(NSString *)userName password:(NSString *)pwd district:(NSInteger)disId success:(RegisterSuccessBlock)successBlock error:(RegisterFailBlock)errorBlock
{
    NSMutableDictionary *dicPara = [@{@"username":userName
                                     ,@"password":pwd
                                     ,@"district_id":[NSNumber numberWithInt:disId]} mutableCopy];
    
    [self postRequestToServer:ActionRegister dicParams:dicPara success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
    
}

- (void)loginWithName:(NSString *)userName password:(NSString *)pwd success:(LoginSuccessBlock)successBlock error:(LoginFailBlock)errorBlock
{
    NSMutableDictionary *dicPara = [@{@"username":userName
                                      ,@"password":pwd} mutableCopy];
    [self postRequestToServer:ActionLogin dicParams:dicPara success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
}

- (void)getUserInfo:(NSString *)userId appKey:(NSString *)appKey success:(GetUserInfoSuccessBlock)successBlock error:(GetUserInfoFailBlock)errorBlock
{
    NSMutableDictionary *dicPara = [@{@"userid":userId
                                      ,@"appkey":appKey} mutableCopy];
    [self postRequestToServer:ActionGetUserInfo dicParams:dicPara success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
    
}

@end
