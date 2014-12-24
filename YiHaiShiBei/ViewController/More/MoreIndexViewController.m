//
//  MoreIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MoreIndexViewController.h"
#import "RegisterRootViewController.h"
#import "MoreCell.h"
#import "AppConfig.h"
#import "LogoutCell.h"
#import "ChangeUserInfoViewController.h"
#import "ChangePwdViewController.h"
#import "SearchRootViewController.h"
#import "ContactUsViewController.h"
#import "ChooseLocationViewController.h"
#import "ChooseCityProtocol.h"
@interface MoreIndexViewController ()<ChooseCityProtocol, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;


@end

@implementation MoreIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)searchBtnClick
{
    UIStoryboard *sbSearch = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    SearchRootViewController *viewControllerRoot = [sbSearch instantiateInitialViewController];
    [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBarTitle:nil];
    [self setSearchBtn];
    // Do any additional setup after loading the view.
}

//#pragma mark - Location methods
//- (void)didChooseCity
//{
//    ChooseLocationViewController *viewControllerCity = [[UIStoryboard storyboardWithName:@"ChooseLocation" bundle:nil] instantiateInitialViewController];
//    viewControllerCity.delegate = self;
//    [self presentViewController:viewControllerCity animated:YES completion:^{
//    }];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tbViewContent reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UITableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
    cell.viewBack.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
    cell.viewBack.layer.borderWidth = 0.5f;
    
    LogoutCell *cellLogout = [tableView dequeueReusableCellWithIdentifier:@"LogoutCell"];
    cellLogout.viewLogout.layer.cornerRadius = 5.0f;
    cellLogout.viewLogout.layer.masksToBounds = YES;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.apps.storedUserID > 0) {
                cell.lblTitle.text = [NSString stringWithFormat:@"%@/注册",self.apps.storedUserName];
            } else {
                cell.lblTitle.text = @"登陆/注册";
            }
        } else if (indexPath.row == 1) {
            cell.lblTitle.text = @"更新用户信息";
        } else if (indexPath.row == 2) {
            cell.lblTitle.text = @"更新用户密码";
        }
    } else if(indexPath.section == 1) {
        cell.lblTitle.text = @"联系我们";
    } else {
        [cellLogout.btnLogout addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        return cellLogout;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 40.0f;
    } else {
        return 40.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
            [viewControllerRegister loginDidSuccess:^(BOOL success) {
                [self showOnlyLabelHud:[NSString stringWithFormat:@"%@欢迎回来",self.apps.storedUserName] withView:self.view];
                [self.tbViewContent reloadData];
            }];
            [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
            }];
        } else if (indexPath.row == 1) {
            if (self.apps.storedUserID <= 0) {
                [self showOnlyLabelHud:@"请先登录..." withView:self.view];
                return;
            }
            UIStoryboard *sbMore = [UIStoryboard storyboardWithName:@"MorePage" bundle:nil];
            ChangeUserInfoViewController *viewController = [sbMore instantiateViewControllerWithIdentifier:@"ChangeUserInfoViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        } else {
            if (self.apps.storedUserID <= 0) {
                [self showOnlyLabelHud:@"请先登录..." withView:self.view];
                return;
            }
            UIStoryboard *sbMore = [UIStoryboard storyboardWithName:@"MorePage" bundle:nil];
            ChangePwdViewController *viewController = [sbMore instantiateViewControllerWithIdentifier:@"ChangePwdViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    } else if (indexPath.section == 1) {
        UIStoryboard *sbMore = [UIStoryboard storyboardWithName:@"MorePage" bundle:nil];
        ContactUsViewController *viewController = [sbMore instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        [self logoutAction];
    }
}

- (void)logoutAction
{
    self.apps.storedUserID = 0;
    self.apps.storedUserName = @"";
    self.apps.stroedAppKey = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:K_USER_LOGIN_APPKEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:K_USER_LOGIN_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:K_USER_LOGIN_USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tbViewContent reloadData];
}

@end
