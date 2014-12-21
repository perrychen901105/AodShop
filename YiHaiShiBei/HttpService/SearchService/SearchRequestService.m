//
//  SearchRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SearchRequestService.h"

static NSString *ActionSearchList = @"search";

@implementation SearchRequestService

- (void)getAllSearchListWithParas:(NSMutableDictionary *)dicParas success:(GetAllSearchListSuccessBlock)successBlock error:(GetAllSearchListFailBlock)errorBlcok
{
    [self postRequestToServer:ActionSearchList dicParams:dicParas success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlcok(errorCode, errorMessage);
    }];
}

@end
