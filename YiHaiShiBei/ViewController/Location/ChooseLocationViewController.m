//
//  ChooseLocationViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/9.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "ChooseLocationViewController.h"


@interface ChooseLocationViewController ()
- (IBAction)btnpressed_ConfirmCity:(id)sender;
- (IBAction)btnpressed_CancelCity:(id)sender;

@end

@implementation ChooseLocationViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)btnpressed_ConfirmCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)btnpressed_CancelCity:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
