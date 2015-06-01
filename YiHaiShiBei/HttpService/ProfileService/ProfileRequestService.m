//
//  ProfileRequestService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-29.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProfileRequestService.h"

@implementation ProfileRequestService

static NSString *ActionRegister = @"register/";
static NSString *ActionLogin = @"login/";
static NSString *ActionGetUserInfo = @"getUserInfo/";
static NSString *ActionUpdateUserInfo = @"editUserInfo/";
static NSString *ActionUpdatePwd = @"editUserPassword/";
static NSString *ActionGetUserIntro = @"getUserIntro";

- (void)userRegisterWithUserName:(NSString *)userName password:(NSString *)pwd district:(NSInteger)disId phoneNum:(NSString *)phoneNum success:(RegisterSuccessBlock)successBlock error:(RegisterFailBlock)errorBlock
{
    NSMutableDictionary *dicPara = [@{@"username":userName
                                     ,@"password":pwd
                                     ,@"district_id":[NSNumber numberWithInt:disId]
                                     ,@"phone":phoneNum} mutableCopy];
    
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

- (void)getUserIntro:(NSString *)userId success:(GetUserIntroSuccessBlock)successBlock error:(GetUserIntroFailBlock)errorBlock
{

    NSString *strPara = [NSString stringWithFormat:@"/%@",userId];
    [self getRequestToServer:ActionGetUserIntro requestPara:strPara success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

- (void)updateUserInfo:(NSMutableDictionary *)dicParas success:(UpdateUserInfoSuccessBlock)successBlock error:(UpdateUserInfoFailBlock)errorBlock
{
    [self postRequestToServer:ActionUpdateUserInfo dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}
- (void)updatePwd:(NSMutableDictionary *)dicParas success:(UpdatePwdSuccessBlock)successBlock error:(UpdatePwdFailBlock)errorBlock
{
    [self postRequestToServer:ActionUpdatePwd dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
