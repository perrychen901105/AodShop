//
//  favListCell.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewFav;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

@end
