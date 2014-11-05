//
//  RegisterViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/2.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProfileViewModel.h"
#import "UserProfileProtocol.h"

@interface RegisterViewController ()<UITextFieldDelegate, UserProfileProtocol, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfChooseDistrict;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPwd;

@property (strong, nonatomic) ProfileViewModel *viewModelRegister;

- (IBAction)actionRegisterComplete:(id)sender;
@end

@implementation RegisterViewController

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
    
    [self setBackButton];
    
    self.viewModelRegister = [[ProfileViewModel alloc] init];
    self.viewModelRegister.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RegisterSuccess
{
    [self hideHudWithDelay:0];
    self.HUD.delegate = self;
    self.HUD.tag = 1;
    [self showOnlyLabelHud:@"注册成功" withView:self.view];
}

- (void)RegisterFailed:(NSString *)strMessage
{
    [self hideHudWithDelay:0];
    [self showOnlyLabelHud:strMessage withView:self.view];
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

// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.

#pragma mark - Login Request

- (BOOL)checkAllFields
{
    BOOL boolAllComplete = YES;
    if ([self.tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        boolAllComplete = NO;
        [self showOnlyLabelHud:@"密码不能为空" withView:self.view];
        return boolAllComplete;
    }
    if ([self.tfUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        boolAllComplete = NO;
        [self showOnlyLabelHud:@"用户名不能为空" withView:self.view];
        return boolAllComplete;
    }
    if ([self.tfChooseDistrict.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        boolAllComplete = NO;
        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
        return boolAllComplete;
    }
    if (![self.tfPassword.text isEqualToString:self.tfConfirmPwd.text]) {
        boolAllComplete = NO;
        [self showOnlyLabelHud:@"两次输入的密码不一致" withView:self.view];
        return boolAllComplete;
    }
    return boolAllComplete;
}

- (IBAction)actionRegisterComplete:(id)sender {
    
//    if (<#condition#>) {
//        <#statements#>
//    }
    if ([self checkAllFields]) {
        [self showProgressLabelHud:@"注册中..." withView:self.view];
        [self.viewModelRegister RegisterWithName:self.tfUserName.text pwd:self.tfPassword.text districtId:1];
    }
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
-  (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
