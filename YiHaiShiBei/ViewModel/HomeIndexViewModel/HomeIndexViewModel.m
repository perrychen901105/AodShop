//
//  HomeIndexViewModel.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexViewModel.h"
#import "BannerModel.h"
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
                NSLog(@"%d",modelBanner.advertisings.count);
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

- (void)getAllGrouponList:(NSInteger)districtID isPass:(NSInteger)isPass IsOnsale:(NSInteger)isOnsale start:(NSInteger)numStart num:(NSInteger)num
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    [self.homeService getAllGrouponList:districtID isPass:isPass isOnsale:isOnsale start:numStart num:numStart success:^(NSString *strResponse) {
        
    } error:^(NSInteger errorCode, NSString *errorMsg) {
        
    }];
}

@end
