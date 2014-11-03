//
//  ProfileViewModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileProtocol.h"

@interface ProfileViewModel : NSObject

@property (nonatomic, weak) id<UserProfileProtocol> delegate;

- (void)loginWithName:(NSString *)strUserName pwd:(NSString *)strPwd;

- (void)RegisterWithName:(NSString *)strUserName pwd:(NSString *)strPwd districtId:(NSInteger)districtId;


@end
