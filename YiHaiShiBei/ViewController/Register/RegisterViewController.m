//
//  RegisterViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/2.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionRegisterComplete:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"aa");
    }];
}
@end
