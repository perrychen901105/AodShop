//
//  HomeIndexService.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"


typedef void (^GetLocationListSuccessBlock)(NSString *strResponse);
typedef void (^GetLocationListFailBlock)(NSString *strFail);

typedef void (^GetAllBannerListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllBannerListFailBlock)(NSString *strFail);

typedef void (^GetAllInfoListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllInfoListFailBlock)(NSString *strFail);

typedef void (^GetAllMessageListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllMessageListFailBlock)(NSString *strFail);



@interface HomeIndexService : HttpRequestService

// 获取所有地址列表
- (void)getAllLocationList:(GetLocationListSuccessBlock)successBlock error:(GetLocationListFailBlock)errorBlock;


// 获取所有广告的列表
- (void)getAllBannerList:(NSInteger)distrinctID start:(NSInteger)start num:(NSInteger)num success:(GetAllBannerListSuccessBlock)successBlock error:(GetAllBannerListFailBlock)errorBlock;

// 获取所有资讯列表
- (void)getAllInforList:(NSInteger)distrinctID start:(NSInteger)start num:(NSInteger)num success:(GetAllBannerListSuccessBlock)successBlock error:(GetAllBannerListFailBlock)errorBlock;

// 获取所有消息列表
- (void)getAllMessageList:(NSInteger)districtID start:(NSInteger)start num:(NSInteger)num success:(GetAllMessageListSuccessBlock)successBlock error:(GetAllMessageListFailBlock)errorBlock;

@end
