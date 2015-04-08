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
#import "RegisterViewController.h"
#import "AppConfig.h"

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
    
    [self addTapGestureOnEmptyView];
    
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

- (void)emptyViewTapped
{
    [self.tfUserName resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"registerSegue"]) {
        RegisterViewController *viewControllerRegister = (RegisterViewController *)segue.destinationViewController;
        [viewControllerRegister registerDidSuccess:^(BOOL success, NSString *userName, NSString *password) {
            if (success) {
                self.tfPassword.text = password;
                self.tfUserName.text = userName;
                [self actionLogin:nil];
            }
        }];
    }
}

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
    [self showOnlyLabelHud:@"登陆成功" withView:self.view];
    self.apps.modelUser = self.viewModleProfile.modelUser;
    self.apps.storedUserID = [self.viewModleProfile.modelUser.userId intValue];
    self.apps.stroedAppKey = self.viewModleProfile.modelUser.appkey;
    self.apps.storedUserName = self.viewModleProfile.modelUser.username;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",self.apps.storedUserID] forKey:K_USER_LOGIN_USERID];
    [[NSUserDefaults standardUserDefaults] setObject:self.apps.stroedAppKey forKey:K_USER_LOGIN_APPKEY];
    [[NSUserDefaults standardUserDefaults] setObject:self.apps.storedUserName forKey:K_USER_LOGIN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.HUD.delegate = self;
    self.HUD.tag = 1;
}

- (void)LoginFailed:(NSString *)strMessage
{
    [self showOnlyLabelHud:strMessage withView:self.view];

}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.blockSuccess) {
                self.blockSuccess(YES);
            }
        }];

    }
}

- (void)loginDidSuccess:(UserloginSuccessBlock)blockTemp
{
    self.blockSuccess = blockTemp;
}

#pragma mark - UITextField methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
