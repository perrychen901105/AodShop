//
//  HomeIndexService.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

typedef void (^GetLocationListSuccessBlock)(NSDictionary *dicData);
typedef void (^GetLocationListFailBlock)(NSDictionary *dicFail);

@interface HomeIndexService : HttpRequestService

- (void)getAllLocationList:(GetLocationListSuccessBlock)successBlock error:(GetLocationListFailBlock)errorBlock;


@end
