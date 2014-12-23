//
//  ContactUsViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/23.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()
- (IBAction)btnpressed_usPhone:(id)sender;
- (IBAction)btnpressed_usMobile:(id)sender;

@end

@implementation ContactUsViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"联系我们"];
    [self setBackButton];
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

- (IBAction)btnpressed_usPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://82126696"]]];
}

- (IBAction)btnpressed_usMobile:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://13962931999"]]];
}
@end
