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
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"success");
        }];
    }

}

- (IBAction)actionRegister:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:sender];
}

#pragma mark - UITextField methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
