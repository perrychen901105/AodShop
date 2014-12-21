//
//  PurchaseReplyModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"

@interface PurchaseReplyModel : BaseModel

@property (nonatomic, assign) NSInteger replyID;
@property (nonatomic, assign) NSInteger replyUserID;
@property (nonatomic, assign) NSInteger replyPurchaseID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *replyUserName;
@property (nonatomic, strong) NSString *replyUserAvatar;
@property (nonatomic, strong) NSString *replyUserEmail;
@property (nonatomic, strong) NSString *replyUserRealName;
@property (nonatomic, strong) NSString *replyPurchaseTitle;
@property (nonatomic, strong) NSString *replyPurchaseInfo;

@end
