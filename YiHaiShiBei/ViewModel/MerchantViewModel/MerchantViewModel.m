//
//  MerchantViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantViewModel.h"
#import "MerchantListModel.h"
#import "DatabaseOperator.h"

@implementation MerchantViewModel

- (void)getMerchantTypeListWithStart:(NSInteger)numStart count:(NSInteger)numCount
{
    if (self.merchantService == nil) {
        self.merchantService = [[MerchantRequestService alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantTypeListWithStartNum:numStart Number:numCount success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
//        MerchantTypeListModel *listModel = [[MerchantTypeListModel alloc] initWithString:strResponse error:nil];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                if (weakSelf.arrMerchantType.count > 0) {
                    [weakSelf.arrMerchantType removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"usercatlist"]) {
                    MerchantTypeModel *model = [[MerchantTypeModel alloc] initWithDictionary:dic[@"UserCat"] error:nil];
                    [weakSelf.arrMerchantType addObject:model];
                }
                if (weakSelf.arrMerchantType.count > 0) {
                    [[DatabaseOperator getInstance] insertAllMerchantTypes:weakSelf.arrMerchantType];
                }
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllMTypeList];
            }
        } else {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
                [weakSelf.delegate httpError:intResponseCode errMsg:strResponseMsg withType:TypeRequestAllMTypeList];
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
    if (self.arrMerchantList == nil) {
        self.arrMerchantList = [[NSMutableArray alloc] init];
    }
    __weak MerchantViewModel *weakSelf = self;
    [self.merchantService getMerchantListWithCatId:catID startNum:numStart Number:numCount success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                if (weakSelf.arrMerchantList.count > 0) {
                    [weakSelf.arrMerchantList removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"businessList"]) {
                    MerchantModel *model = [[MerchantModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrMerchantList addObject:model];
                }
                if (weakSelf.arrMerchantList.count > 0) {
                    [[DatabaseOperator getInstance] insertAllMerchantList:weakSelf.arrMerchantList withCateId:catID];
                }
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllMerchantList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
                [weakSelf.delegate httpError:intResponseCode errMsg:strResponseMsg withType:TypeRequestAllMerchantList];
            }
        }
    } error:^(NSInteger errorCode, NSString *strError) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:errMsg:withType:)]) {
            [weakSelf.delegate httpError:errorCode errMsg:strError withType:TypeRequestAllMerchantList];
        }
    }];
}

#pragma mark - get cached methods
- (void)getCachedMerchantType
{
    self.arrMerchantType = [[DatabaseOperator getInstance] getAllMerchantTypes];
}
- (void)getCachedMerchantListWithCatId:(NSInteger)catId
{
    self.arrMerchantList = [[DatabaseOperator getInstance] getAllMerchantListWithCatId:catId];
}
@end
