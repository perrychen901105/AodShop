//
//  HttpRequestService.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HttpRequestService.h"

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
#ifdef DEBUG_X
        NSLog(@"success string %@",responseString);
#endif
        successBlock(responseString);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
#ifdef DEBUG_X
        NSLog(@"error is %@",[error localizedDescription]);
#endif
        errorBlock(request.responseStatusCode, [error localizedDescription]);
    }];
    
}

- (void)postFileToServer:(NSString *)actionName Datas:(NSMutableDictionary *)datas dicParams:(NSMutableDictionary *)dicParams success:(RequestSuccessBlock)successBlock error:(RequestErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:[APIHost stringByAppendingString:actionName]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    for (NSString *fileKey in [datas allKeys]) {
        [request addData:datas[fileKey] withFileName:@"temp.jpg" andContentType:@"image/jpeg" forKey:fileKey];
    }
    for (NSString *key in [dicParams allKeys]) {
        [request addPostValue:dicParams[key] forKey:key];
    }
    
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:30];
   
    [request startAsynchronous];
    [request setCompletionBlock:^{
#ifdef DEBUG_X
        NSLog(@"message is %@",request.responseString);
#endif
        successBlock(request.responseString);
    }];
    [request setFailedBlock:^{
#ifdef DEBUG_X
        NSLog(@"delete");
#endif
        NSError *error = [request error];
        errorBlock(request.responseStatusCode, [error localizedDescription]);
    }];
}

- (void)postRequestToServer:(NSString *)actionName dicParams:(NSMutableDictionary *)dicParams success:(RequestSuccessBlock)successBlock error:(RequestErrorBlock)errorBlock
{
    NSURL *url = [NSURL URLWithString:[APIHost stringByAppendingString:actionName]];
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

#ifdef DEBUG_X
    NSLog(@"url is %@, dic is %@",url, dicParams);
#endif
    for (NSString *key in [dicParams allKeys]) {
        [request addPostValue:dicParams[key] forKey:key];
    }
    
    
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:30];
    
    [request startAsynchronous];
    [request setCompletionBlock:^{
#ifdef DEBUG_X
        NSLog(@"message is %@",request.responseString);
        NSLog(@"add");
#endif
        successBlock(request.responseString);
    }];
    [request setFailedBlock:^{
#ifdef DEBUG_X
        NSLog(@"delete");
#endif
        NSError *error = [request error];
        errorBlock(request.responseStatusCode, [error localizedDescription]);
    }];

}

@end
