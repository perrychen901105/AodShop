//
//  ProfileViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProfileViewModel.h"
#import "AppConfig.h"
#import "BaseModel.h"

@implementation ProfileViewModel

- (void)loginWithName:(NSString *)strUserName pwd:(NSString *)strPwd
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    
    [self.profileRequest loginWithName:strUserName password:strPwd success:^(NSString *strToken) {
#ifdef DEBUG_X
        NSLog(@"%s, %@",__func__,strToken);
#endif
        UserModel *user = [[UserModel alloc] initWithString:strToken error:nil];
        
        if (user.success == 0) {
            self.modelUser = user;
            if ([self.delegate respondsToSelector:@selector(LoginSuccess)]) {
                [self.delegate LoginSuccess];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(LoginFailed:)]) {
                [self.delegate LoginFailed:user.message];
            }
        }
        
    } error:^(NSString *strFail) {
        if ([self.delegate respondsToSelector:@selector(LoginFailed:)]) {
            [self.delegate LoginFailed:strFail];
        }
    }];
}

- (void)RegisterWithName:(NSString *)strUserName pwd:(NSString *)strPwd districtId:(NSInteger)districtId
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    [self.profileRequest userRegisterWithUserName:strUserName password:strPwd district:districtId success:^(NSString *modelLocation) {
#ifdef DEBUG_X
        NSLog(@"%s, %@",__func__,modelLocation);
#endif
        BaseModel *modelBase = [[BaseModel alloc] initWithString:modelLocation error:nil];
        if ([self.delegate respondsToSelector:@selector(RegisterSuccess)]) {
            if (modelBase.success == 0) {
                [self.delegate RegisterSuccess];
            } else {
                [self.delegate RegisterFailed:modelBase.message];
            }
            
        }
    } error:^(NSString *strFail) {
        if ([self.delegate respondsToSelector:@selector(RegisterFailed:)]) {
            [self.delegate RegisterFailed:strFail];
        }
    }];
}

- (void)getUserInfo:(NSString *)userId appKey:(NSString *)appKey
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    [self.profileRequest getUserInfo:userId appKey:appKey success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *strError) {
        
    }];
}

- (void)updateUserInfo:(NSInteger)userId appKey:(NSString *)appKey realname:(NSString *)realname email:(NSString *)email phone:(NSString *)phone
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",(long)userId] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    if (realname.length > 0) {
        [dicParas setObject:realname forKey:@"realname"];
    }
    if (email.length > 0) {
        [dicParas setObject:email forKey:@"email"];
    }
    if ([phone length] > 0) {
        [dicParas setObject:phone forKey:@"phone"];
    }
    [self.profileRequest updateUserInfo:dicParas success:^(NSString *strResponse) {
        BaseModel *modelBase = [[BaseModel alloc] initWithString:strResponse error:nil];
        if (modelBase.success == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(UpdateUserInfoSuccess)]) {
                [self.delegate UpdateUserInfoSuccess];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(UpdateUserInfoFail:errorMsg:)]) {
                [self.delegate UpdateUserInfoFail:modelBase.success errorMsg:modelBase.message];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(UpdateUserInfoFail:errorMsg:)]) {
            [self.delegate UpdateUserInfoFail:errorCode errorMsg:strError];
        }
    }];
}

- (void)updatePwd:(NSInteger)userId appKey:(NSString *)appKey oldpassword:(NSString *)oldpassword newpassword:(NSString *)newpassword repassword:(NSString *)repassword
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userId] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:oldpassword forKey:@"oldpassword"];
    [dicParas setObject:newpassword forKey:@"newpassword"];
    [dicParas setObject:repassword forKey:@"repassword"];
    
    [self.profileRequest updatePwd:dicParas success:^(NSString *strResponse) {
        BaseModel *modelBase = [[BaseModel alloc] initWithString:strResponse error:nil];
        if (modelBase.success == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUserPwdSuccess)]) {
                [self.delegate updateUserPwdSuccess];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateUserPwdFail:errorMsg:)]) {
                [self.delegate updateUserPwdFail:modelBase.success errorMsg:modelBase.message];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateUserPwdFail:errorMsg:)]) {
            [self.delegate updateUserPwdFail:errorCode errorMsg:strError];
        }
    }];
}

- (void)getUserIntro:(NSString *)userId
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    [self.profileRequest getUserIntro:userId success:^(NSString *strResponse) {
        BaseModel *modelBase = [[BaseModel alloc] initWithString:strResponse error:nil];
        
        if (modelBase.success == 0) {
            NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getUserIntroSuccess:)]) {
                [self.delegate getUserIntroSuccess:dicRoot[@"data"][@"User"][@"introduction"]];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getUserIntroFail:errorMsg:)]) {
                [self.delegate getUserIntroFail:modelBase.success errorMsg:modelBase.message];
            }
        }

    } error:^(NSInteger errorCode, NSString *strError) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(getUserIntroFail:errorMsg:)]) {
            [self.delegate getUserIntroFail:errorCode errorMsg:strError];
        }
    }];
}

@end
