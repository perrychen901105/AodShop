//
//  ChangePwdViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "ProfileViewModel.h"

@interface ChangePwdViewController ()<UITextFieldDelegate, UserProfileProtocol, MBProgressHUDDelegate>

@property (nonatomic, strong) ProfileViewModel *viewModelProfile;

@property (weak, nonatomic) IBOutlet UITextField *tfOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirm;
- (IBAction)btnpressed_modify:(id)sender;
- (IBAction)btnpressed_cancel:(id)sender;

@end

@implementation ChangePwdViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyViewTapped
{
    [self.tfOldPwd resignFirstResponder];
    [self.tfNewPwd resignFirstResponder];
    [self.tfConfirm resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"修改密码"];
    [self setBackButton];
    
    self.viewModelProfile = [[ProfileViewModel alloc] init];
    self.viewModelProfile.delegate = self;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfOldPwd.leftView = paddingViewOne;
    self.tfOldPwd.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfNewPwd.leftView = paddingViewTwo;
    self.tfNewPwd.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfConfirm.leftView = paddingViewThree;
    self.tfConfirm.leftViewMode = UITextFieldViewModeAlways;
    
    [self addTapGestureOnEmptyView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Profile methods

- (void)updateUserPwdSuccess
{
    [self showOnlyLabelHud:@"修改成功" withView:self.view];
    self.HUD.delegate = self;
    self.HUD.tag = 1;
}

- (void)updateUserPwdFail:(NSInteger)errorCode errorMsg:(NSString *)errorMsg
{
    [self showOnlyLabelHud:errorMsg withView:self.view];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.tag == 1) {
        [self backAction];
    }
}

#pragma mark - UITextField methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setBackground:[UIImage imageNamed:@"editLineSelectBg"]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setBackground:[UIImage imageNamed:@"editLineBg"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnpressed_modify:(id)sender {
    NSString *strOldPwd = [self.tfOldPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strNewPwd = [self.tfNewPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strConfirm = [self.tfConfirm.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (strOldPwd.length <= 0) {
        [self showOnlyLabelHud:@"原密码不能为空!" withView:self.view];
        return;
    }
    if (strNewPwd.length <= 0) {
        [self showOnlyLabelHud:@"新密码不能为空!" withView:self.view];
        return;
    }
    if (strConfirm.length <= 0) {
        [self showOnlyLabelHud:@"确认密码不能为空!" withView:self.view];
        return;
    }
    if (![strNewPwd isEqualToString:strConfirm]) {
        [self showOnlyLabelHud:@"两次输入密码不一致0!" withView:self.view];
        return;
    }
    [self showProgressLabelHud:@"正在提交..." withView:self.view];
    [self.viewModelProfile updatePwd:self.apps.storedUserID appKey:self.apps.stroedAppKey oldpassword:strOldPwd newpassword:strNewPwd repassword:strConfirm];
}

- (IBAction)btnpressed_cancel:(id)sender {
    [self backAction];
}
@end
