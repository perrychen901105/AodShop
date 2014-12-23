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
#import "FavViewModel.h"
#import "UIImageView+WebCache.h"
#import "ASStarRatingView.h"
#import "RegisterRootViewController.h"

@interface MerchantDetailViewController ()<FavViewModelDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet ASStarRatingView *viewStar;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UIView *viewPhone;
@property (weak, nonatomic) IBOutlet UIView *viewMail;
@property (weak, nonatomic) IBOutlet UIView *viewAddr;

@property (nonatomic, strong) FavViewModel *viewModelFav;

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

- (void)addFavFunc:(id)sender
{
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    [self showProgressLabelHud:@"正在添加收藏..." withView:self.view];
    [self.viewModelFav changeUserFavWithType:1 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_MERCHANT detailID:self.model.merchantUserId];
}

- (void)setFavButtonItem
{
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, 60, 30);
    [btnAdd setTitle:@"添加收藏" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addFavFunc:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
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
    [self setFavButtonItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fav model methods
- (void)favHttpSuccessWithTag:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:@"收藏成功" withView:self.view];
    }
}

- (void)favHttpErrorWithCode:(NSInteger)errorCode errMessage:(NSString *)errorStr type:(EnumFavRequestType)type
{
    if (type == FavRequestAddFav) {
        [self showOnlyLabelHud:errorStr withView:self.view];
    }
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

#pragma mark - UIAlertview methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
        __weak ProductDetailViewController *weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf addFavFunc:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    } else {
        if (buttonIndex == 1) {
            UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
            __weak ProductDetailViewController *weakSelf = self;
            [viewControllerRegister loginDidSuccess:^(BOOL success) {
                [weakSelf btnpressed_comment:nil];
            }];
            [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
            }];
        }
    }
}
@end
