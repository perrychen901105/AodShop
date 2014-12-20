//
//  MoreIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MoreIndexViewController.h"
#import "MoreCell.h"
#import "LogoutCell.h"

@interface MoreIndexViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellQuit;
@property (weak, nonatomic) IBOutlet UIView *viewQuitOut;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBarTitle:nil];
    [self setSearchAndCityButton];
    // Do any additional setup after loading the view.
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
    cell.viewBack.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.viewBack.layer.borderWidth = 1.0f;
    
    LogoutCell *cellLogout = [tableView dequeueReusableCellWithIdentifier:@"LogoutCell"];
    cellLogout.viewLogout.layer.cornerRadius = 5.0f;
    cellLogout.viewLogout.layer.masksToBounds = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.apps.modelUser) {
                cell.lblTitle.text = [NSString stringWithFormat:@"%@/注册",self.apps.modelUser.username];
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
            if (self.apps.modelUser) {
            } else {
                // 未登录
                UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
                [self presentViewController:viewControllerRoot animated:YES completion:^{
                }];
            }
        } else if (indexPath.row == 1) {
            
        } else {
            
        }
    } else if (indexPath.section == 1) {
        
    } else {
        
    }
}

@end
