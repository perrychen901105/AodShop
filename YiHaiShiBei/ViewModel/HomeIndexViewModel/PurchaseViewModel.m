//
//  PurchaseViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "PurchaseViewModel.h"
#import "RequirePurchaseModel.h"

@implementation PurchaseViewModel

- (void)getAllPurchaseList:(NSInteger)userID districtID:(NSInteger)districtID productCateID:(NSInteger)productCatID start:(NSInteger)start num:(NSInteger)num
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    if (self.arrAllPurchaseList == nil) {
        self.arrAllPurchaseList = [@[] mutableCopy];
    }
    __weak PurchaseViewModel *weakSelf = self;
    [self.purchaseService getAllPurchaseListWithUserId:userID districtID:districtID productCatId:productCatID start:start num:num success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                if (weakSelf.arrAllPurchaseList.count > 0) {
                    [weakSelf.arrAllPurchaseList removeAllObjects];
                }
                for (NSDictionary *dicPur in dicRoot[@"data"][@"ProductPurchasesList"]) {
                    RequirePurchaseModel *model = [[RequirePurchaseModel alloc] initWithDictionary:dicPur error:nil];
                    [weakSelf.arrAllPurchaseList addObject:model];
                }
                if (weakSelf.arrAllPurchaseList.count > 0) {
                    
                }
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestAllPurchaseList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestAllPurchaseList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestAllPurchaseList];
        }
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
