//
//  BaseModel.h
//  YiHaiShiBei
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 perry. All rights reserved.
//  https://github.com/icanzilb/JSONModel
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface BaseModel : JSONModel

@property (nonatomic, strong) NSString *message;
//@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, assign) BOOL success;

@end
