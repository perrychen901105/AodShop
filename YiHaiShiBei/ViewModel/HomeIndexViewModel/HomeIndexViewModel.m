//
//  HomeIndexViewModel.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexViewModel.h"
#import "BannerModel.h"
#import "DatabaseOperator.h"
@implementation HomeIndexViewModel

- (void)getAllBannersList:(NSInteger)distrinctID start:(NSInteger)numStart num:(NSInteger)num
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    __weak HomeIndexViewModel *weakSelf = self;
    [self.homeService getAllBannerList:distrinctID start:numStart num:numStart success:^(NSString *strResponse) {
        BannerModel *modelBanner = [[BannerModel alloc] initWithString:strResponse error:nil];
        if (modelBanner.success == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
#ifdef DEBUG
                NSLog(@"%d",modelBanner.advertisings.count);
#endif
                weakSelf.arrAllBanners = [modelBanner.advertisings mutableCopy];
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllBanner];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(httpError:message:type:)]) {
                [weakSelf.delegate httpError:1 message:modelBanner.message type:TypeRequestAllBanner];
            }
        }

    } error:^(NSString *strFail) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:message:type:)]) {
            [weakSelf.delegate httpError:1 message:strFail type:TypeRequestAllBanner];
        }
    }];
}

- (void)getAllInfoList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    if (self.arrAllInfos == nil) {
        self.arrAllInfos = [[NSMutableArray alloc] init];
    }
    __weak HomeIndexViewModel *weakSelf = self;
    [self.homeService getAllInforList:distrinctID start:numStart num:num success:^(NSString *strResponse) {
        
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                if (weakSelf.arrAllInfos.count > 0) {
                    [weakSelf.arrAllInfos removeAllObjects];
                }
                for (NSDictionary *dicInformation in dicRoot[@"data"][@"information"]) {
                    InformationModel *model = [[InformationModel alloc] initWithDictionary:dicInformation[@"Information"] error:nil];
                    model.userName = dicInformation[@"User"][@"username"];
                    [weakSelf.arrAllInfos addObject:model];
                }
                if (weakSelf.arrAllInfos.count > 0) {
                    [[DatabaseOperator getInstance] removeAllInforsWithDistrictId:distrinctID];
                    [[DatabaseOperator getInstance] insertAllInformations:weakSelf.arrAllInfos withDistrictId:distrinctID];
                }
                
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllInfo];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(httpError:message:type:)]) {
                [weakSelf.delegate httpError:intResponseCode message:strResponseMsg type:TypeRequestAllInfo];
            }
        }
    } error:^(NSString *strFail) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:message:type:)]) {
            [weakSelf.delegate httpError:1 message:strFail type:TypeRequestAllInfo];
        }
    }];
}

- (void)getAllMsgList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    if (self.arrAllMessages == nil) {
        self.arrAllMessages = [@[] mutableCopy];
    }
    __weak HomeIndexViewModel *weakSelf = self;
    [self.homeService getAllMessageList:distrinctID start:numStart num:num success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                if (weakSelf.arrAllMessages.count > 0) {
                    [weakSelf.arrAllMessages removeAllObjects];
                }
                for (NSDictionary *dicInformation in dicRoot[@"data"][@"information"]) {
                    MsgModel *model = [[MsgModel alloc] initWithDictionary:dicInformation[@"Information"] error:nil];
                    model.userName = dicInformation[@"User"][@"username"];
                    [weakSelf.arrAllMessages addObject:model];
                }
                if (weakSelf.arrAllMessages.count > 0) {
                    [[DatabaseOperator getInstance] removeAllMessagesWithDistrictId:distrinctID];
                    [[DatabaseOperator getInstance] insertAllMessages:weakSelf.arrAllMessages withDistrictId:distrinctID];
                }
                [weakSelf.delegate httpSuccessWithTag:TypeRequestAllMessage];
            }
        } else {
            if (weakSelf.delegate && [self.delegate respondsToSelector:@selector(httpError:message:type:)]) {
                [weakSelf.delegate httpError:intResponseCode message:strResponseMsg type:TypeRequestAllMessage];
            }
        }
    } error:^(NSString *strFail) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(httpError:message:type:)]) {
            [weakSelf.delegate httpError:1 message:strFail type:TypeRequestAllMessage];
        }
    }];
}

- (void)checkNewMsg:(NSInteger)districtID
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    __weak HomeIndexViewModel *weakSelf = self;
    [self.homeService getAllMessageList:districtID start:0 num:1 success:^(NSString *strResponse) {
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSInteger intResponseCode = [dicRoot[@"success"] intValue];
        NSString *strResponseMsg = dicRoot[@"message"];
        if (intResponseCode == 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(hasNewMessage:)]) {
                MsgModel *model = nil;
                for (NSDictionary *dicInformation in dicRoot[@"data"][@"information"]) {
                    model = [[MsgModel alloc] initWithDictionary:dicInformation[@"Information"] error:nil];
                    model.userName = dicInformation[@"User"][@"username"];
                }
                if (model != nil) {
                    BOOL boolNew = [[DatabaseOperator getInstance] hasNewMsg:model districtID:districtID];
                    [weakSelf.delegate hasNewMessage:boolNew];
                }
            }
        } else {
        }
    } error:^(NSString *strFail) {
    }];
}

#pragma mark - get cached methods
- (void)getCachedInfoList:(NSInteger)districtID
{
    self.arrAllInfos = [[DatabaseOperator getInstance] getAllInformationsWithDistrictId:districtID];
}

- (void)getCachedMsgList:(NSInteger)districtID
{
    self.arrAllMessages = [[DatabaseOperator getInstance] getAllMessagesWithDistrictId:districtID];
}
@end
