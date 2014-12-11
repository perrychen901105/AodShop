//
//  MerchantInfoCell.h
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/11.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface MerchantInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantName;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantPhone;
@property (weak, nonatomic) IBOutlet ASStarRatingView *viewRating;

@end
