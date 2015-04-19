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

typedef void (^GetUserInfoSuccessBlock)(NSString *strResponse);
typedef void (^GetUserInfoFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^UpdateUserInfoSuccessBlock)(NSString *strResponse);
typedef void (^UpdateUserInfoFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^UpdatePwdSuccessBlock)(NSString *strResponse);
typedef void (^UpdatePwdFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^GetUserIntroSuccessBlock)(NSString *strResponse);
typedef void (^GetUserIntroFailBlock)(NSInteger errorCode, NSString *strError);

@interface ProfileRequestService : HttpRequestService

- (void)userRegisterWithUserName:(NSString *)userName password:(NSString *)pwd district:(NSInteger)disId success:(RegisterSuccessBlock)successBlock error:(RegisterFailBlock)errorBlock;
- (void)loginWithName:(NSString *)userName password:(NSString *)pwd success:(LoginSuccessBlock)successBlock error:(LoginFailBlock)errorBlock;
- (void)getUserInfo:(NSString *)userId appKey:(NSString *)appKey success:(GetUserInfoSuccessBlock)successBlock error:(GetUserInfoFailBlock)errorBlock;
- (void)updateUserInfo:(NSMutableDictionary *)dicParas success:(UpdateUserInfoSuccessBlock)successBlock error:(UpdateUserInfoFailBlock)errorBlock;
- (void)updatePwd:(NSMutableDictionary *)dicParas success:(UpdatePwdSuccessBlock)successBlock error:(UpdatePwdFailBlock)errorBlock;
- (void)getUserIntro:(NSString *)userId success:(GetUserIntroSuccessBlock)successBlock error:(GetUserIntroFailBlock)errorBlock;

@end
