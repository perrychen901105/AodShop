//
//  InforDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/4.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "InforDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"
#import "FavViewModel.h"
#import "RegisterRootViewController.h"

@interface InforDetailViewController ()<FavViewModelDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgViewDes;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@property (nonatomic, strong) FavViewModel *viewModelFav;

@end

@implementation InforDetailViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"资讯详情"];
    [self setBackButton];
    [self setupDetailView];
    [self setFavButtonItem];
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)addFavFunc:(id)sender
{
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        return;
    }
    [self showProgressLabelHud:@"正在添加收藏..." withView:self.view];
    [self.viewModelFav changeUserFavWithType:1 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_INFORMATION detailID:self.modelInfo.infoId];
}

- (void)setFavButtonItem
{
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, 30, 30);
    [btnAdd setTitle:@"收藏" forState:UIControlStateNormal];
    [btnAdd setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    //    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addFavFunc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemFav = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 30, 30);
    [btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [btnShare setTitleColor:COLOR_TITLE_DEFAULT forState:UIControlStateNormal];
    [btnShare.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnShare addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemShare = [[UIBarButtonItem alloc] initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItems = @[itemFav, itemShare];
}
- (void)shareBtnClick:(id)sender
{
    [self shareContent:self.modelInfo.title img:[UIImage imageNamed:@"img_banner_default"] url:nil];
}
- (void)setupDetailView
{
    [self.imgViewDes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.modelInfo.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
    if (self.modelInfo.realname.length <= 0) {
        self.lblUserName.text = [NSString stringWithFormat:@"发布人: %@",self.modelInfo.userName];
    } else {
        self.lblUserName.text = [NSString stringWithFormat:@"发布人: %@",self.modelInfo.realname];
    }
    self.lblReleaseTime.text = [NSString stringWithFormat:@"时间: %@",self.modelInfo.release_date];
    self.lblTitle.text = [NSString stringWithFormat:@"%@",self.modelInfo.title];
    self.tvContent.text = [NSString stringWithFormat:@"%@",self.modelInfo.content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FavViewmodel methods
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

#pragma mark - UIAlertview methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (buttonIndex == 1) {
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
        __weak InforDetailViewController *weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf addFavFunc:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
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

@end
