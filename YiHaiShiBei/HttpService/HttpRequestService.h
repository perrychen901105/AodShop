//
//  HttpRequestService.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestErrorBlock)(NSInteger errorCode, NSString *errorMessage);
typedef void (^RequestSuccessBlock)(NSString *responseString);

@interface HttpRequestService : NSObject

- (void)getRequestToServer:(NSString *)actionName requestPara:(NSString *)requestData success:(RequestSuccessBlock)successBlock error:(RequestErrorBlock)errorBlock;

@end
