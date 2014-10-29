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
@end
