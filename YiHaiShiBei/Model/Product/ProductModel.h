//
//  ProductModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "JSONModel.h"

@interface ProductModel : JSONModel

@end

@interface ProductCatModel : JSONModel

@property (nonatomic, assign) NSInteger catID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger product_number;
@property (nonatomic, assign) NSInteger info_number;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *modified;

@end
