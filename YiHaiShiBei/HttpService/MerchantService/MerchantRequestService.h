//
//  MerchantRequestService.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"
typedef void (^GetMerchantTypeListSuccessBlock)(NSString *strResponse);
typedef void (^GetMerchantTypeListFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^GetMerchantListSuccessBlock)(NSString *strResponse);
typedef void (^GetMerchantListFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^GetMerchantDetailSuccessBlock)(NSString *strResponse);
typedef void (^GetMerchantDetailFailBlock)(NSInteger errorCode, NSString *strError);

typedef void (^GetMerchantProductSuccessBlock)(NSString *strResponse);
typedef void (^GetMerchantProductFailBlock)(NSInteger errorCode, NSString *strError);

@interface MerchantRequestService : HttpRequestService

- (void)getMerchantTypeListWithStartNum:(NSInteger)numStart Number:(NSInteger)numCount success:(GetMerchantTypeListSuccessBlock)successBlock error:(GetMerchantTypeListFailBlock)errorBlock;

- (void)getMerchantListWithCatId:(NSInteger)catId districtID:(NSInteger)districtID startNum:(NSInteger)numStart Number:(NSInteger)numCount success:(GetMerchantListSuccessBlock)successBlock error:(GetMerchantListFailBlock)errorBlock;

- (void)getMerchantProductsWithParameter:(NSMutableDictionary *)dicPara success:(GetMerchantProductSuccessBlock)successBlock error:(GetMerchantProductFailBlock)errorBlock;

- (void)getMerchantDetail:(NSMutableDictionary *)dicPara success:(GetMerchantDetailSuccessBlock)successBlock error:(GetMerchantDetailFailBlock)errorBlock;

@end
