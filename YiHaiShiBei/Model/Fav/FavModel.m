//
//  FavModel.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "FavModel.h"
#import "JSONKeyMapper.h"
@implementation FavModel

@end

@implementation ProductFavModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ProductCollection.id":@"favID",
                                                       @"ProductCollection.user_id":@"usreID",
                                                       @"ProductCollection.product_id":@"productID",
                                                       @"ProductCollection.time":@"strAddtime",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar",
                                                       @"User.realname":@"realname",
                                                       @"Product.name":@"productName",
                                                       @"Product.picture":@"productPic",
                                                       @"Product.price":@"price",
                                                       }];
}
@end

@implementation InfoFavModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"InformationCollection.id":@"favID",
                                                       @"InformationCollection.user_id":@"usreID",
                                                       @"InformationCollection.information_id":@"informationID",
                                                       @"InformationCollection.time":@"strAddtime",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar",
                                                       @"User.realname":@"realname",
                                                       @"Information.title":@"infoName",
                                                       @"Information.picture":@"infoPic",
                                                       @"Information.sort":@"sort"
                                                       }];
}
@end

@implementation GrouponFavModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"GrouppurchaseCollection.id":@"favID",
                                                       @"GrouppurchaseCollection.user_id":@"usreID",
                                                       @"GrouppurchaseCollection.grouppurchase_product_id":@"grouponID",
                                                       @"GrouppurchaseCollection.time":@"strAddtime",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar",
                                                       @"User.realname":@"realname",
                                                       @"GrouppurchaseProduct.name":@"grouponName",
                                                       @"GrouppurchaseProduct.picture":@"grouponPic",
                                                       @"GrouppurchaseProduct.price":@"oriPrice",
                                                       @"GrouppurchaseProduct.new_price":@"newPrice"
                                                       }];
}
@end

@implementation MerchantFavModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"ShopCollection.id":@"favID",
                                                       @"ShopCollection.user_id":@"usreID",
                                                       @"ShopCollection.shop_id":@"merchantID",
                                                       @"ShopCollection.time":@"strAddtime",
                                                       @"User.username":@"username",
                                                       @"User.avatar":@"avatar",
                                                       @"User.realname":@"realname",
                                                       @"Shop.username":@"merchantUserName",
                                                       @"Shop.avatar":@"merchantPic",
                                                       @"Shop.company_name":@"merchantName",
                                                       @"Shop.email":@"merchantEmail",
                                                       @"Shop.phone":@"merchantPhone",
                                                       @"Shop.company_addr":@"merchantAddr"
                                                       }];
}
@end