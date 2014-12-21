//
//  SearchRequestService.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"
typedef void (^GetAllSearchListSuccessBlock)(NSString *strResponse);
typedef void (^GetAllSearchListFailBlock)(NSInteger errorCode, NSString *errorMsg);

@interface SearchRequestService : HttpRequestService

- (void)getAllSearchListWithParas:(NSMutableDictionary *)dicParas success:(GetAllSearchListSuccessBlock)successBlock error:(GetAllSearchListFailBlock)errorBlcok;

@end
