//
//  MsgDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/5.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "MsgDetailViewController.h"

@interface MsgDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewDes;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@end

@implementation MsgDetailViewController

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

@end
