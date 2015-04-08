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
#import "ChooseLocationViewController.h"
#import "ChooseCityProtocol.h"
#import "LocationModel.h"

@interface RegisterViewController ()<UITextFieldDelegate, UserProfileProtocol, MBProgressHUDDelegate, ChooseCityProtocol>

@property (weak, nonatomic) IBOutlet UITextField *tfChooseDistrict;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPwd;

@property (nonatomic, assign) NSInteger intDistrinctID;

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
    [self setNaviBarTitle:nil];
    
    [self addTapGestureOnEmptyView];
    
    self.viewModelRegister = [[ProfileViewModel alloc] init];
    self.viewModelRegister.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyViewTapped
{
    [self.tfUserName resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    [self.tfConfirmPwd resignFirstResponder];
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
    if ([self checkAllFields]) {
        [self showProgressLabelHud:@"注册中..." withView:self.view];
#ifdef DEBUG
        NSLog(@"the select district id is %ld",self.intDistrinctID);
#endif
        [self.viewModelRegister RegisterWithName:self.tfUserName.text pwd:self.tfPassword.text districtId:self.intDistrinctID];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.tag == 1) {
        if (self.blockSuccess) {
            self.blockSuccess(YES, self.tfUserName.text, self.tfPassword.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
    }
}

- (void)registerDidSuccess:(UserRegisterSuccessBlock)blockTemp
{
    self.blockSuccess = blockTemp;
}

#pragma mark - UITextField methods
-  (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.tfChooseDistrict) {
        ChooseLocationViewController *viewControllerCity = [[UIStoryboard storyboardWithName:@"ChooseLocation" bundle:nil] instantiateInitialViewController];
        viewControllerCity.delegate = self;
        viewControllerCity.needSynacApp = NO;
        [self presentViewController:viewControllerCity animated:YES completion:^{
        }];
        return NO;
    }
    return YES;
}

#pragma mark - Location delegate methods
- (void)didSelectCity:(CurrentLocationModel *)modelCurrent
{
    self.tfChooseDistrict.text = modelCurrent.strDistrinct;
    self.intDistrinctID = modelCurrent.intDistrinctId;
}

@end
