//
//  GrouponModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/13.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>

@interface GrouponModel : JSONModel

@property (nonatomic, assign) NSInteger grouponID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat new_price;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger isPass;
@property (nonatomic, assign) NSInteger isOnSale;

@end
