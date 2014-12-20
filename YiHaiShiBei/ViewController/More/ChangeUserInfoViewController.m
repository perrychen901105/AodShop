//
//  ChangeUserInfoViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/20.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "ProfileViewModel.h"

@interface ChangeUserInfoViewController ()<UITextFieldDelegate, UserProfileProtocol, MBProgressHUDDelegate>

@property (nonatomic, strong) ProfileViewModel *viewModelProfile;

@property (weak, nonatomic) IBOutlet UITextField *tfChangeUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfChangeEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfChangePhone;

- (IBAction)btnpressed_confirm:(id)sender;
- (IBAction)btnpressed_cancel:(id)sender;

@end

@implementation ChangeUserInfoViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyViewTapped
{
    [self.tfChangeUserName resignFirstResponder];
    [self.tfChangeEmail resignFirstResponder];
    [self.tfChangePhone resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"修改用户信息"];
    [self setBackButton];
    
    self.viewModelProfile = [[ProfileViewModel alloc] init];
    self.viewModelProfile.delegate = self;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfChangeUserName.leftView = paddingViewOne;
    self.tfChangeUserName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfChangeEmail.leftView = paddingViewTwo;
    self.tfChangeEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfChangePhone.leftView = paddingViewThree;
    self.tfChangePhone.leftViewMode = UITextFieldViewModeAlways;
    
    [self addTapGestureOnEmptyView];
    
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

#pragma mark - Profile methods
- (void)UpdateUserInfoSuccess
{
    
    [self showOnlyLabelHud:@"修改成功" withView:self.view];
    self.HUD.delegate = self;
    self.HUD.tag = 1;
}

- (void)UpdateUserInfoFail:(NSInteger)errorCode errorMsg:(NSString *)errorMsg
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

- (IBAction)btnpressed_confirm:(id)sender {
    NSString *strName = [self.tfChangeUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strPhone = [self.tfChangePhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strEmail = [self.tfChangeEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self showProgressLabelHud:@"正在提交中..." withView:self.view];
    [self.viewModelProfile updateUserInfo:self.apps.storedUserID appKey:self.apps.stroedAppKey realname:strName email:strEmail phone:strPhone];
}

- (IBAction)btnpressed_cancel:(id)sender {
    [self backAction];
}
@end
