//
//  LocationViewModel.m
//  YiHaiShiBei
//
//  Created by qw on 14-11-10.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "LocationViewModel.h"

@implementation LocationViewModel

- (void)getAllProvinceList{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    [self.homeService getAllLocationList:^(NSString *strResponse) {
        NSError *err = nil;
        LocationBaseModel *loca = [[LocationBaseModel alloc] initWithString:strResponse error:&err];
        self.locationModel = loca;
        if (loca.success == 0) {
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
