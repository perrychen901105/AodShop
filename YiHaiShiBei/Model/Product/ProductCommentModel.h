//
//  ProductCommentModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "JSONModel.h"

@interface ProductCommentModel : JSONModel
@property (nonatomic, assign) NSInteger commentID;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, strong) NSString *strContent;
@property (nonatomic, strong) NSString *strTime;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@end
