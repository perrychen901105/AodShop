//
//  BaseModel.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, assign) BOOL httpSuccess;

@end
