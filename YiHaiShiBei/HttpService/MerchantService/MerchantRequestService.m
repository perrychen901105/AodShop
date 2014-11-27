//
//  MerchantRequestService.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantRequestService.h"

@implementation MerchantRequestService

static NSString *ActionMerchantList = @"getProductCatList";

- (void)getMerchantTypeListWithStartNum:(NSInteger)numStart Number:(NSInteger)numCount success:(GetMerchantTypeListSuccessBlock)successBlock error:(GetMerchantTypeListFailBlock)errorBlock
{
    NSMutableString *strRequest = [[NSMutableString alloc] initWithString:@""];
    if (numStart >= 0) {
        [strRequest appendFormat:@"/%d",numStart];
    }
    if (numCount >= 0) {
        [strRequest appendFormat:@"/%d",numCount];
    }
    [self getRequestToServer:ActionMerchantList requestPara:strRequest success:^(NSString *responseString) {
        successBlock(responseString);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        errorBlock(errorCode, errorMessage);
    }];
}

@end
