//
//  RegisterRootViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-31.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RegisterRootViewController.h"

@interface RegisterRootViewController ()

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction
{
    NSLog(@"back");
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss success");
    }];
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

@end
