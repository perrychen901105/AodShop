//
//  MsgTableViewCell.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/3.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPic;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateTime;
@end
