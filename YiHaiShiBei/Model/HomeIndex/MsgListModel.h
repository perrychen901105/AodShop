//
//  MsgListModel.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/4.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseModel.h"

@interface MsgModel : JSONModel
@property (nonatomic, assign) NSInteger msgId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger district_id;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString *release_date;
@property (nonatomic, assign) NSInteger information_category_id;

@property (nonatomic, strong) NSString<Optional> *userName;
@end

@interface MsgListModel : BaseModel

@end
