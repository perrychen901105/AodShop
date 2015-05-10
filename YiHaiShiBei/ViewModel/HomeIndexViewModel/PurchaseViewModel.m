//
//  PurchaseViewModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "PurchaseViewModel.h"
#import "RequirePurchaseModel.h"
#import "GrouponModel.h"
#import "PurchaseReplyModel.h"
#import "DatabaseOperator.h"

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
                    if (model == nil) {
                        continue;
                    }
                    [weakSelf.arrAllPurchaseList addObject:model];
                }
                if (weakSelf.arrAllPurchaseList.count > 0) {
                    [[DatabaseOperator getInstance] removeAllRequirePurchaseList];
                    [[DatabaseOperator getInstance] insertAllRequirePurchase:weakSelf.arrAllPurchaseList];
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
    if (self.arrAllGrouponList == nil) {
        self.arrAllGrouponList = [@[] mutableCopy];
    }
    __weak PurchaseViewModel *weakSelf = self;
    [self.purchaseService getAllGrouponList:districtID isPass:isPass isOnsale:isOnsale start:numStart num:num success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                if (weakSelf.arrAllGrouponList.count > 0) {
                    [weakSelf.arrAllGrouponList removeAllObjects];
                }
                for (NSDictionary *dicGroup in dicRoot[@"data"][@"grouppurchase"]) {
                    GrouponModel *model = [[GrouponModel alloc] initWithDictionary:dicGroup[@"GrouppurchaseProduct"] error:nil];
                    [weakSelf.arrAllGrouponList addObject:model];
                }
                if (weakSelf.arrAllGrouponList.count > 0) {
                    [[DatabaseOperator getInstance] removeAllGrouponList];
                    [[DatabaseOperator getInstance] insertAllGrouponList:weakSelf.arrAllGrouponList];
                }
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestAllGrouponList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestAllGrouponList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestAllGrouponList];
        }
    }];
}

- (void)getGrouponDetail:(NSInteger)groupID
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    __weak PurchaseViewModel *weakSelf = self;
    [self.purchaseService getGrouponDetail:groupID success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                self.modelGroupon = [[GrouponModel alloc] initWithDictionary:dicRoot[@"data"][@"GrouppurchaseProduct"] error:nil];
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestGrouponDetail];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestGrouponDetail];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestGrouponDetail];
        }
    }];
}

- (void)getAllReplyPurchaseList:(NSInteger)userID appKey:(NSString *)appKey ppid:(NSInteger)ppid typeID:(NSInteger)typeID
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    if (self.arrAllReplyPurchaseList == nil) {
        self.arrAllReplyPurchaseList = [@[] mutableCopy];
    }
    __weak PurchaseViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userID] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",ppid] forKey:@"ppid"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",typeID] forKey:@"typeid"];
    [self.purchaseService getAllReplyPurchaseListWithParas:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                if (weakSelf.arrAllReplyPurchaseList.count > 0) {
                    [weakSelf.arrAllReplyPurchaseList removeAllObjects];
                }
                for (NSDictionary *dic in dicRoot[@"data"][@"ProductPurchasesReplies"]) {
                    PurchaseReplyModel *model = [[PurchaseReplyModel alloc] initWithDictionary:dic error:nil];
                    [weakSelf.arrAllReplyPurchaseList addObject:model];
                }
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestAllReplyList];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestAllReplyList];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestAllReplyList];
        }
    }];
}

- (void)postReplyPurchase:(NSInteger)userID appKey:(NSString *)appKey ppid:(NSInteger)ppid content:(NSString *)content
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    __weak PurchaseViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",userID] forKey:@"userid"];
    [dicParas setObject:appKey forKey:@"appkey"];
    [dicParas setObject:[NSString stringWithFormat:@"%ld",ppid] forKey:@"ppid"];
    [dicParas setObject:content forKey:@"content"];
    [self.purchaseService postReplyWithParas:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestAddReplyPurchase];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestAddReplyPurchase];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestAddReplyPurchase];
        }
    }];
}

- (void)JoinGroupOn:(NSInteger)userID grouponID:(NSInteger)groupID
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    __weak PurchaseViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%d",userID] forKey:@"user_id"];
    [dicParas setObject:[NSString stringWithFormat:@"%d",groupID] forKey:@"group_id"];
    [self.purchaseService joinGroupPurchase:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestJoinGroupon];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestJoinGroupon];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestJoinGroupon];
        }
    }];
}

- (void)getJoinedGrouponNum:(NSInteger)grouponID
{
    if (self.purchaseService == nil) {
        self.purchaseService = [[PurchaseRequestService alloc] init];
    }
    __weak PurchaseViewModel *weakSelf = self;
    NSMutableDictionary *dicParas = [@{} mutableCopy];
    [dicParas setObject:[NSString stringWithFormat:@"%d",grouponID] forKey:@"group_id"];
    [self.purchaseService getJoinGroupNum:dicParas success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(purchaseRequestSuccessWithTag:)]) {
                if (![dicRoot[@"data"] isKindOfClass:[NSNull class]]) {
                    NSInteger numAdded = [dicRoot[@"data"] intValue];
                    self.joinedGrouponNum = numAdded;
                }
                
                [weakSelf.delegate purchaseRequestSuccessWithTag:TypeRequestGetGrouponNum];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
                [weakSelf.delegate purchaseRequestError:intResponseCode message:strResponseMsg type:TypeRequestGetGrouponNum];
            }
        }
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(purchaseRequestError:message:type:)]) {
            [weakSelf.delegate purchaseRequestError:errorCode message:errorMsg type:TypeRequestGetGrouponNum];
        }
    }];
}

- (void)getCachedRequirePurchaseList
{
    if (self.arrAllPurchaseList == nil) {
        self.arrAllPurchaseList = [@[] mutableCopy];
    }
    self.arrAllPurchaseList = [[DatabaseOperator getInstance] getALlRequirePuchaseList];
}

- (void)getCachedGrouponList
{
    if (self.arrAllGrouponList == nil) {
        self.arrAllGrouponList = [@[] mutableCopy];
    }
    self.arrAllGrouponList = [[DatabaseOperator getInstance] getAllGrouponList];
}

@end
