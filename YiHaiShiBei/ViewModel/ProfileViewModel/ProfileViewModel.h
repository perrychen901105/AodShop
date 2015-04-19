//
//  ProfileViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileProtocol.h"
#import "UserModel.h"
#import "ProfileRequestService.h"

@interface ProfileViewModel : NSObject

@property (nonatomic, weak) id<UserProfileProtocol> delegate;

@property (nonatomic, strong) ProfileRequestService *profileRequest;
@property (nonatomic, strong) UserModel *modelUser;

- (void)loginWithName:(NSString *)strUserName pwd:(NSString *)strPwd;

- (void)RegisterWithName:(NSString *)strUserName pwd:(NSString *)strPwd districtId:(NSInteger)districtId;

- (void)getUserInfo:(NSString *)userId appKey:(NSString *)appKey;

- (void)updateUserInfo:(NSInteger)userId appKey:(NSString *)appKey realname:(NSString *)realname email:(NSString *)email phone:(NSString *)phone;

- (void)updatePwd:(NSInteger)userId appKey:(NSString *)appKey oldpassword:(NSString *)oldpassword newpassword:(NSString *)newpassword repassword:(NSString *)repassword;

- (void)getUserIntro:(NSString *)userId;

@end
