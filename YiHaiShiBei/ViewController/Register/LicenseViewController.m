//
//  LicenseViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 4/19/15.
//  Copyright (c) 2015 perry. All rights reserved.
//

#import "LicenseViewController.h"

@interface LicenseViewController ()

- (IBAction)btnpressed_cancel:(id)sender;
- (IBAction)btnpressed_confirm:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

@end

@implementation LicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)btnpressed_cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnpressed_confirm:(id)sender {
    if (self.blockSuccess) {
        self.blockSuccess(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
