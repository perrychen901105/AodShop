//
//  AdvertiseModel.h
//  YiHaiShiBei
//
//  Created by qw on 14-11-26.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
@protocol AdvertiseModel

@end
@interface AdvertiseModel : JSONModel

@property (nonatomic, assign) NSInteger advertiseId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger is_system;
@property (nonatomic, assign) NSInteger user_id;

@end
