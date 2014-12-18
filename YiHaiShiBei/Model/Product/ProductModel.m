//
//  ProductModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ProductModel.h"
#import "JSONKeyMapper.h"
@implementation ProductModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Product.id":@"productID",
                                                       @"Product.name":@"productName",
                                                       @"Product.picture":@"productPicture",
                                                       @"Product.price":@"price",
                                                       @"Product.number":@"productNum",
                                                       @"Product.clicks":@"productClick",
                                                       @"Product.district_id":@"districtID",
                                                       @"Product.product_cat_id":@"productCatID",
                                                       @"Product.user_id":@"userID",
                                                       @"Product.release_date":@"releaseDate",
                                                       @"Product.is_pass":@"isPass",
                                                       @"Product.backup":@"backup",
                                                       @"Product.is_onsale":@"isOnSale",
                                                       @"District.name":@"DistrictName",
                                                       @"ProductCat.name":@"productCatName",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar",
                                                       @"User.email":@"userEmail",
                                                       @"User.phone":@"userPhone",
                                                       @"User.company_name":@"companyName",
                                                       @"User.company_addr":@"companyAddr"
                                                       }];
}
@end

@implementation ProductCatModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"catID"
                                                       }];
}
@end
