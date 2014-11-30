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
static NSString *ActionAllBanners  = @"getAdvertisings";
static NSString *ActionAllInfos    = @"getInfomations";

- (void)getAllLocationList:(GetLocationListSuccessBlock)successBlock error:(GetLocationListFailBlock)errorBlock
{
    NSString *strGetAllLocation = @"/2";
    [self getRequestToServer:ActionAllLocation requestPara:strGetAllLocation success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
}

// 获取所有广告的列表
- (void)getAllBannerList:(NSInteger)distrinctID start:(NSInteger)start num:(NSInteger)num success:(GetAllBannerListSuccessBlock)successBlock error:(GetAllBannerListFailBlock)errorBlock
{
    NSMutableString *strGetBannerList = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"/%d",distrinctID]];
    if (start >= 0) {
        [strGetBannerList appendFormat:@"/%d",start];
    }
    if (num >= 0) {
        [strGetBannerList appendFormat:@"/%d",num];
    }
    [self getRequestToServer:ActionAllBanners requestPara:strGetBannerList success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
}

// 获取所有资讯列表
- (void)getAllInforList:(NSInteger)distrinctID start:(NSInteger)start num:(NSInteger)num success:(GetAllBannerListSuccessBlock)successBlock error:(GetAllBannerListFailBlock)errorBlock
{
    NSMutableDictionary *dicParas = [@{@"typeid":@1,
                                       @"district_id":[NSString stringWithFormat:@"%d",distrinctID]} mutableCopy];
    
    if (start >= 0) {
        dicParas[@"start"] = [NSString stringWithFormat:@"%d",start];
    }
    if (num >= 0) {
        dicParas[@"number"] = [NSString stringWithFormat:@"%d",num];
    }
    [self postRequestToServer:ActionAllInfos dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
}

// 获取所有消息列表
- (void)getAllMessageList:(NSInteger)districtID start:(NSInteger)start num:(NSInteger)num success:(GetAllMessageListSuccessBlock)successBlock error:(GetAllMessageListFailBlock)errorBlock
{
    NSMutableDictionary *dicParas = [@{@"typeid":@2,
                                       @"district_id":[NSString stringWithFormat:@"%d",districtID]} mutableCopy];
    
    if (start >= 0) {
        dicParas[@"start"] = [NSString stringWithFormat:@"%d",start];
    }
    if (num >= 0) {
        dicParas[@"number"] = [NSString stringWithFormat:@"%d",num];
    }
    [self postRequestToServer:ActionAllInfos dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorMessage);
    }];
}

// 获取所有团购列表
- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass isOnsale:(NSInteger)isOnsale start:(NSInteger)start num:(NSInteger)num success:(GetAllGrouponListSuccessBlock)successBlock error:(GetAllGrouponListFailBlock)errorBlock
{
//    NSString *strGetAllLocation = @"/2";
//    [self getRequestToServer:ActionAllLocation requestPara:strGetAllLocation success:^(NSString *responseString) {
//        successBlock(responseString);
//    } error:^(NSInteger errorCode, NSString *errorMessage) {
//        errorBlock(errorMessage);
//    }];
}

@end
