//
//  GrouponTableViewCell.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/15.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPicture;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;

@end
