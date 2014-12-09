//
//  MerchantViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantViewModel.h"
#import "MerchantListModel.h"

@implementation MerchantViewModel

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantTypeListWithStartNum:numStart Number:numCount success:^(NSString *strResponse) {
        MerchantTypeListModel *listModel = [[MerchantTypeListModel alloc] initWithString:strResponse error:nil];
        if (listModel.success == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                weakSelf.arrMerchantType = [listModel.arrMerchantType mutableCopy];
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllMTypeList];
            }
        } else {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
                [weakSelf.delegate httpError:listModel.success errMsg:listModel.message withType:TypeRequestAllMTypeList];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
            [weakSelf.delegate httpError:errorCode errMsg:strError withType:TypeRequestAllMTypeList];
        }
    }];
}


- (void)getMerchantListWithCatId:(NSInteger)catID Start:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantListWithCatId:catID startNum:numStart Number:numCount success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
            [weakSelf.delegate httpError:errorCode errMsg:strError withType:TypeRequestAllMerchantList];
        }
    }];
}

@end
