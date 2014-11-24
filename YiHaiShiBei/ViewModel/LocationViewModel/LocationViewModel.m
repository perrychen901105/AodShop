//
//  LocationViewModel.m
//  YiHaiShiBei
//
//  Created by qw on 14-11-10.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "LocationViewModel.h"
#import "DatabaseOperator.h"
@implementation LocationViewModel

- (void)getAllProvinceList{
    if (self.homeService == nil) {
        self.homeService = [[HomeIndexService alloc] init];
    }
    [self.homeService getAllLocationList:^(NSString *strResponse) {
        NSError *err = nil;
        NSDictionary *dicReturn = [NSJSONSerialization JSONObjectWithData:[strResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&err];
    
        if ([dicReturn[@"success"] intValue] == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpSuccess)]) {
                [[DatabaseOperator getInstance] insertAllLocations:dicReturn[@"data"]];
                [self.delegate httpSuccess];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:)]) {
                [self.delegate httpError:[dicReturn[@"success"] intValue] message:dicReturn[@"message"]];
            }
        }
    } error:^(NSString *strFail) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpError:message:)]) {
            [self.delegate httpError:1 message:strFail];
        }
    }];
}

//- (NSMutableArray *)getAllProvince
//{
//    NSMutableArray *arrProvince = [@[] mutableCopy];
//    
//    return self.locationModel.arrLocation;
//}
//
//- (NSMutableArray *)getCityWithProvinceID:(NSInteger)provinceID
//{
//    
//}
//
//- (NSMutableArray *)getAllDistrinctWithCityID:(NSInteger)cityID
//{
//    
//}

@end
