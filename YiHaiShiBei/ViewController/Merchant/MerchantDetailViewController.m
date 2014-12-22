//
//  MerchantDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "ASStarRatingView.h"
#import "AppConfig.h"
#import "UIImageView+WebCache.h"
#import "ASStarRatingView.h"

@interface MerchantDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet ASStarRatingView *viewStar;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UIView *viewPhone;
@property (weak, nonatomic) IBOutlet UIView *viewMail;
@property (weak, nonatomic) IBOutlet UIView *viewAddr;

- (IBAction)btnpresed_phoneCall:(id)sender;
- (IBAction)btnpressed_email:(id)sender;

@end

@implementation MerchantDetailViewController

- (void)setDetailContent
{
    if (self.model.merchantLevelId <= 0) {
        self.viewStar.hidden = YES;
    } else {
        self.viewStar.canEdit = NO;
        self.viewStar.maxRating = 5;
        self.viewStar.rating = self.model.merchantLevelId;
    }
    
    self.lblName.text = self.model.merchantCompanyName;
    self.lblPhone.text = self.model.merchantPhone;
    self.lblAddress.text = self.model.merchantCompanyAddr;
    [self.imgViewAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.model.merchantAvatar]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"商家详情"];
    [self setBackButton];
    self.viewPhone.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewAddr.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewMail.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    self.viewPhone.layer.borderWidth = self.viewMail.layer.borderWidth = self.viewAddr.layer.borderWidth = 1.0f;
    [self setDetailContent];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnpresed_phoneCall:(id)sender {
    if (self.model.merchantPhone.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.merchantPhone]]];
    }
}

- (IBAction)btnpressed_email:(id)sender {
}
@end
