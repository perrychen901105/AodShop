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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
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
    
//    [self setBackButton];
//    [[UITabBar appearance] setTintColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5]];
    
    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_homeSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home"]];
    [[[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_supplySelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_supply"]];
    [[[self.tabBarController.viewControllers objectAtIndex:2] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_merchantSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_merchant"]];
    [[[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_favSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_fav"]];
    [[[self.tabBarController.viewControllers objectAtIndex:4] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_moreSelected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_more"]];
    
    [[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem].title = @"主页";
    [[self.tabBarController.viewControllers objectAtIndex:1] tabBarItem].title = @"主页";
    [[self.tabBarController.viewControllers objectAtIndex:2] tabBarItem].title = @"主页";
    [[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem].title = @"主页";
    [[self.tabBarController.viewControllers objectAtIndex:4] tabBarItem].title = @"主页";
    
    
    // Do any additional setup after loading the view.
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
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    cityLabel.font = [UIFont fontWithName:cityLabel.font.fontName size:11];
    cityLabel.text = @"苏州";
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 10, 10)];
    imgView.image = [UIImage imageNamed:@"img_arrowDown"];
    
    UIButton *btnChooseCity = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChooseCity.frame = CGRectMake(0, 0, 40, 30);

    [btnChooseCity addTarget:self action:@selector(didChooseCity) forControlEvents:UIControlEventTouchUpInside];
    
    [viewCity addSubview:cityLabel];
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
