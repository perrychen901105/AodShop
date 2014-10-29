//
//  HomeIndexViewModel.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexViewModel.h"

@implementation HomeIndexViewModel

- (void)getAllProvinceList{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    [self.homeService getAllLocationList:^(NSString *strResponse) {
        NSError *err = nil;
        LocationBaseModel *loca = [[LocationBaseModel alloc] initWithString:strResponse error:&err];
        self.locationModel = loca;
        if (loca.success) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpSuccess)]) {
                [self.delegate httpSuccess];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:)]) {
                [self.delegate httpError:loca.success message:loca.message];
            }
        }
    } error:^(NSString *strFail) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:)]) {
            [self.delegate httpError:1 message:strFail];
        }
    }];
}

@end
