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

@end
