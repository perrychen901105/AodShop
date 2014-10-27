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
    [self.homeService getAllLocationList:^(NSDictionary *dicData) {
        NSLog(@"dic data is %@",dicData);
    } error:^(NSDictionary *dicFail) {
        NSLog(@"dic error is %@",dicFail);
    }];
}

@end
