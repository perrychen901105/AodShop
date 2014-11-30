//
//  MerchantModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/30.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"
@protocol MerchantTypeModel <NSObject>

@end


@interface MerchantModel : BaseModel

@end

@interface MerchantTypeModel : JSONModel

@property (nonatomic, assign) NSInteger merchantTypeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger product_number;
@property (nonatomic, assign) NSInteger info_number;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString<Optional> *created;
@property (nonatomic, strong) NSString<Optional> *modified;

@end
