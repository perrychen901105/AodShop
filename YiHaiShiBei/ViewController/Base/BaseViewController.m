//
//  BaseViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "BaseViewController.h"
#import "AppConfig.h"


@interface BaseViewController ()

@property (nonatomic, strong) UIView *viewNaviTitle;



@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.HUD.delegate = nil;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.apps = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.automaticallyAdjustsScrollViewInsets =NO;
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:244/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    else {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    if (IsIOS7) {
        [self.navigationController.navigationBar setTranslucent:YES];
    }else
    {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    
    // Do any additional setup after loading the view.
}

// 添加空白页面点击事件响应方法
- (void)addTapGestureOnEmptyView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyViewTapped)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)emptyViewTapped
{
    
}

- (void)didChooseCity
{
    
}

- (void)showProgressLabelHud:(NSString *)str withView:(UIView *)withView
{
    if (self.HUD) {
//        [self.HUD hide:YES];
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:withView];
//    self.HUD = [[MBProgressHUD alloc] initWithView:withView];
    [withView addSubview:self.HUD];
    self.HUD.labelText = str;
    self.HUD.removeFromSuperViewOnHide = YES;
	[self.HUD show:YES];
}

- (void)showOnlyLabelHud:(NSString *)str withView:(UIView *)withView
{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:withView];
    
    [withView addSubview:self.HUD];
    [self.HUD show:YES];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.labelText = str;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD hide:YES afterDelay:1];
//	[self.HUD show:YES];
}

- (void)hideHudWithDelay:(NSInteger)delay
{
    [self.HUD hide:YES afterDelay:delay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setSearchAndCityButton
{
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0, 0, 30, 30);
    [btnSearch setImage:[UIImage imageNamed:@"img_search"] forState:UIControlStateNormal];
    UIBarButtonItem *searchBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnSearch];
    
    UIView *viewCity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    self.lblCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
    self.lblCity.textAlignment = NSTextAlignmentCenter;
    self.lblCity.font = [UIFont fontWithName:self.lblCity.font.fontName size:10];
//    self.lblCity.text = @"苏州";
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 12, 5, 8)];
    imgView.image = [UIImage imageNamed:@"img_arrowDown"];
    
    UIButton *btnChooseCity = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChooseCity.frame = CGRectMake(0, 0, 40, 30);

    [btnChooseCity addTarget:self action:@selector(didChooseCity) forControlEvents:UIControlEventTouchUpInside];
    
    [viewCity addSubview:self.lblCity];
    [viewCity addSubview:imgView];
    [viewCity addSubview:btnChooseCity];
    UIBarButtonItem *cityBtnItem = [[UIBarButtonItem alloc] initWithCustomView:viewCity];
    
    self.navigationItem.rightBarButtonItems = @[searchBtnItem, cityBtnItem];
    
}

- (void)setUserIconButton
{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30, 30);
    [btnBack setImage:[UIImage imageNamed:@"img_huiyuan"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(userLoginAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

- (void)userLoginAction
{
    
}

- (void)setBackButton
{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30, 30);
    [btnBack setImage:[UIImage imageNamed:@"img_return"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNaviBarTitle:(NSString *)navTitle
{
    if (navTitle == nil) {
        if (self.viewNaviTitle == nil) {
            NSArray *arrTitle = [[NSBundle mainBundle] loadNibNamed:@"naviTitle" owner:self options:nil];
            self.viewNaviTitle = arrTitle[0];
        } else {
        }
        self.navigationItem.titleView = self.viewNaviTitle;
    } else {
        self.navigationItem.title = navTitle;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
