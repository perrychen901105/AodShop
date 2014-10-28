//
//  HomeIndexService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeIndexService.h"
#import "LocationModel.h"

@implementation HomeIndexService

static NSString *ActionAllLocation = @"getProvinces";

- (void)getAllLocationList:(GetLocationListSuccessBlock)successBlock error:(GetLocationListFailBlock)errorBlock
{
    NSString *strGetAllLocation = @"/2";
    [self getRequestToServer:ActionAllLocation requestPara:strGetAllLocation success:^(NSString *responseString) {
        NSLog(@"response string is %@",responseString);
        NSError *err = nil;
        LocationBaseModel *loca = [[LocationBaseModel alloc] initWithString:responseString error:&err];
        
        NSLog(@"success is %d",loca.success);
//        NSLog(@"location is %@",loca.arrProvince);
//        for (ProvinceModel *model in loca.arrProvince) {
//            NSLog(@"name is %@",model.name);
//        }
//        
        NSLog(@"model is %@",loca);
    } error:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"error is %@",errorMessage);
    }];
}

@end
