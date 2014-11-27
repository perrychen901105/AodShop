//
//  MerchantViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantViewModel.h"


@implementation MerchantViewModel

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    [self.merchantService getMerchantTypeListWithStartNum:numStart Number:numCount success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *strError) {
        
    }];
}

@end
