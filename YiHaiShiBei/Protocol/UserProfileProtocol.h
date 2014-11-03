//
//  UserProfileProtocol.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserProfileProtocol <NSObject>

@optional
- (void)LoginSuccess;
- (void)LoginFailed:(NSString*)strMessage;

- (void)RegisterSuccess;
- (void)RegisterFailed:(NSString*)strMessage;

@end
