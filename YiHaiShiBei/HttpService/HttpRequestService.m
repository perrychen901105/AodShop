//
//  HttpRequestService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"
#import "ASIHTTPRequest.h"
#import "AppConfig.h"

@implementation HttpRequestService

- (void)getRequestToServer:(NSString *)actionName requestPara:(NSString *)requestData success:(RequestSuccessBlock)successBlock error:(RequestErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:[[APIHost stringByAppendingString:actionName] stringByAppendingString:requestData]];
#ifdef DEBUG
    NSLog(@"url is %@",url);
#endif
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:10.0];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSDictionary *dicSucc = [dicRoot objectForKey:@"success"];
//        NSDictionary *dicData = [dicRoot objectForKey:@"data"];
        
//        NSArray *arrRoot = [NSJSONSerialization js ]
        NSLog(@"dic root is %@",dicRoot);
#ifdef DEBUG
        NSLog(@"success string %@",responseString);
#endif
        successBlock(responseString);
    }];
    
    
    
    [request setFailedBlock:^{
        NSError *error = [request error];
#ifdef DEBUG
        NSLog(@"error is %@",[error localizedDescription]);
#endif
        errorBlock(request.responseStatusCode, [error localizedDescription]);
    }];
    
}

@end
