//
//  ProfileViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProfileViewModel.h"


@implementation ProfileViewModel

- (void)loginWithName:(NSString *)strUserName pwd:(NSString *)strPwd
{
    if (self.profileRequest == nil) {
        self.profileRequest = [[ProfileRequestService alloc] init];
    }
    
    __weak ProfileViewModel *weakSelf = self;
    [weakSelf.profileRequest loginWithName:strUserName password:strPwd success:^(NSString *strToken) {
        if ([self.delegate respondsToSelector:@selector(LoginSuccess)]) {
            [self.delegate LoginSuccess];
        }
    } error:^(NSString *strFail) {
        if ([self.delegate respondsToSelector:@selector(LoginFailed:)]) {
            [self.delegate LoginFailed:strFail];
        }
    }];
}

- (void)RegisterWithName:(NSString *)strUserName pwd:(NSString *)strPwd districtId:(NSInteger)districtId
{
    
}

@end
