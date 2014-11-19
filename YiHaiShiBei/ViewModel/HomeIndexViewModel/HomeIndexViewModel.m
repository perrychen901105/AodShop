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
    [self.homeService getAllBannerList:distrinctID start:numStart num:numStart success:^(NSString *strResponse) {
        BannerModel *modelBanner = [[BannerModel alloc] initWithString:strResponse error:nil];
        if (modelBanner.success == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpSuccessWithTag:)]) {
                NSLog(@"%d",modelBanner.advertisings.count);
                [self.delegate httpSuccessWithTag:TypeRequestAllBanner];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:type:)]) {
                [self.delegate httpError:1 message:modelBanner.message type:TypeRequestAllBanner];
            }
        }

    } error:^(NSString *strFail) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:type:)]) {
            [self.delegate httpError:1 message:strFail type:TypeRequestAllBanner];
        }
    }];
}

- (void)getAllInfoList:(NSInteger)distrinctID startNum:(NSInteger)numStart num:(NSInteger)num
{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    
    [self.homeService getAllInforList:distrinctID start:numStart num:num success:^(NSString *strResponse) {
        
    } error:^(NSString *strFail) {
        
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
