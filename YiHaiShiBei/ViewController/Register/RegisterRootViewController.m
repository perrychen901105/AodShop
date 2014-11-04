//
//  RegisterRootViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-31.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RegisterRootViewController.h"
#import "ProfileViewModel.h"

#import "UserProfileProtocol.h"

//#import "MBProgressHUD.h"
@interface RegisterRootViewController ()<UITextFieldDelegate, UserProfileProtocol>

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;


@property (strong, nonatomic) ProfileViewModel *viewModleProfile;

- (IBAction)actionLogin:(id)sender;
- (IBAction)actionRegister:(id)sender;
@end

@implementation RegisterRootViewController

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
    [self setBackButton];
    
    self.viewModleProfile = [[ProfileViewModel alloc] init];
    self.viewModleProfile.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss success");
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Login Request

- (BOOL)checkAllFields
{
    BOOL boolAllComplete = YES;
    if ([self.tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        boolAllComplete = NO;
    }
    if ([self.tfUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        boolAllComplete = NO;
    }
    return boolAllComplete;
}

- (IBAction)actionLogin:(id)sender {
    if ([self checkAllFields]) {
        [self showProgressLabelHud:@"登录中..." withView:self.view];

        [self.viewModleProfile loginWithName:self.tfUserName.text pwd:self.tfPassword.text];
    }

}

- (IBAction)actionRegister:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:sender];
}

#pragma mark - Http methods
- (void)LoginSuccess
{
    [self hideHudWithDelay:0];
    self.HUD.delegate = self;
    self.HUD.tag = 1;
    [self showOnlyLabelHud:@"登陆成功" withView:self.view];
//    //初始化进度框，置于当前的View当中
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    
//    //如果设置此属性则当前的view置于后台
//    HUD.dimBackground = YES;
//    
//    //设置对话框文字
//    HUD.labelText = @"登录成功";
//    
//    //显示对话框
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        //对话框显示时需要执行的操作
//        sleep(3);
//    } completionBlock:^{
//        //操作执行完后取消对话框
//        [HUD removeFromSuperview];
//    }];
//
    
}

- (void)LoginFailed:(NSString *)strMessage
{
//    //初始化进度框，置于当前的View当中
//    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    
//    //如果设置此属性则当前的view置于后台
//    HUD.dimBackground = YES;
//    
//    //设置对话框文字
//    HUD.labelText = @"请稍等";
//    
//    //显示对话框
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        //对话框显示时需要执行的操作
//        sleep(3);
//    } completionBlock:^{
//        //操作执行完后取消对话框
//        [HUD removeFromSuperview];
//    }];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"success");
        }];

    }
}

#pragma mark - UITextField methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
