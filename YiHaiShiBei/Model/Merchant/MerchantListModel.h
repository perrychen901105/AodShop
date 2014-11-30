//
//  MerchantListModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/30.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
#import "MerchantModel.h"

@interface MerchantListModel : BaseModel

@end

@interface MerchantTypeListModel : BaseModel

@property (nonatomic, strong) NSArray<MerchantTypeModel> *arrMerchantType;
@property (nonatomic, assign) NSInteger count;

@end
