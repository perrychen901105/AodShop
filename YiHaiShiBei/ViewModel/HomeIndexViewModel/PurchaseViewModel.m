//
//  PurchaseViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "PurchaseViewModel.h"

@implementation PurchaseViewModel

- (void)getAllPurchaseList:(NSInteger)userID districtID:(NSInteger)districtID productCateID:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    [self.purchaseService getAllPurchaseListWithUserId:userID districtID:districtID productCatId:productCatID start:start num:num success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass IsOnsale:(NSInteger)isOnsale start:(NSInteger)numStart num:(NSInteger)num
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    [self.purchaseService getAllGrouponList:districtID isPass:isPass isOnsale:isOnsale start:numStart num:num success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

@end
