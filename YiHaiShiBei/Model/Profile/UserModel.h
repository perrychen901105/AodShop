//
//  UserModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/5.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *userId;
@property (nonatomic, strong) NSString<Optional> *username;
@property (nonatomic, strong) NSString<Optional> *appkey;
@property (nonatomic, strong) NSString<Optional> *is_pass;

@end
