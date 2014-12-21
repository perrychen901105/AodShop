//
//  GrouponDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "GrouponDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AppConfig.h"
#import "FavViewModel.h"
#import "RegisterRootViewController.h"
@interface GrouponDetailViewController ()<FavViewModelDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgViewContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblGrouponPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblRemainCount;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@property (nonatomic, strong) FavViewModel *viewModelFav;

@end

@implementation GrouponDetailViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setViewContent
{
    self.lblTitle.text = [NSString stringWithFormat:@"商品名: %@",self.model.name];
    self.lblGrouponPrice.text = [NSString stringWithFormat:@"团购价: %.2f",self.model.new_price];
    self.lblRemainCount.text = [NSString stringWithFormat:@"剩余数量: %ld",self.model.number];
    [self.imgViewContent sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGHost,self.model.picture]] placeholderImage:[UIImage imageNamed:@"img_banner_default"]];
//    self.tvContent.text = [NSString stringWithFormat:<#(NSString *), ...#>]
    
}

- (void)addFavFunc:(id)sender
{
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        return;
    }
    [self showProgressLabelHud:@"正在添加收藏..." withView:self.view];
    [self.viewModelFav changeUserFavWithType:1 userID:self.apps.storedUserID appKey:self.apps.stroedAppKey typeid:TYPE_FAV_GROUPON detailID:self.model.grouponID];
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
    [self setNaviBarTitle:@"团购详情"];
    [self setBackButton];
    [self setViewContent];
    [self setFavButtonItem];
    
    self.viewModelFav = [[FavViewModel alloc] init];
    self.viewModelFav.delegate = self;
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
        __weak GrouponDetailViewController *weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf addFavFunc:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    }
}


@end
