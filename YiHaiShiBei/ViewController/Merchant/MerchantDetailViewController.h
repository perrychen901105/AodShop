//
//  MerchantDetailViewController.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchantModel.h"
@interface MerchantDetailViewController : BaseViewController

@property (nonatomic, strong) MerchantModel *model;
@property (nonatomic, assign) NSInteger merchantUsrID;
@property (nonatomic, assign) BOOL loadFromWeb;

@end
