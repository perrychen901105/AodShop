//
//  HomeIndexService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexService.h"


@implementation HomeIndexService

static NSString *ActionAllLocation = @"getProvinces";

- (void)getAllLocationList:(GetLocationListSuccessBlock)successBlock error:(GetLocationListFailBlock)errorBlock
{
    NSString *strGetAllLocation = @"/2";
    [self getRequestToServer:ActionAllLocation requestPara:strGetAllLocation success:^(NSString *responseString) {
        successBlock(responseString);
 
    } error:^(NSInteger errorCode, NSString *errorMessage) {
#ifdef DEBUG_X
        NSLog(@"error is %@",errorMessage);
#endif
        errorBlock(errorMessage);
    }];
}

// 获取所有广告的列表
- (void)getAllBannerList:(NSInteger)distrinctID start:(NSInteger)start num:(NSInteger)num success:(GetAllBannerListSuccessBlock)successBlock error:(GetAllBannerListFailBlock)errorBlock
{
    NSMutableString *strGetBannerList = [[NSMutableString alloc] initWithFormat:[NSString stringWithFormat:@"/%d",distrinctID]];
    if (start >= 0) {
        [strGetBannerList appendFormat:@"/%d",start];
    }
    if (num >= 0) {
        [strGetBannerList appendFormat:@"/%d",num];
    }
    
}

@end
