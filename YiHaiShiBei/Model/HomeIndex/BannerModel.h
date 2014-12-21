//
//  BannerModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
#import "AdvertiseModel.h"

@interface BannerModel : BaseModel

@property (nonatomic, strong) NSArray<AdvertiseModel> *advertisings;

@end

