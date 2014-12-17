//
//  SupplyListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/17.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SupplyListViewController.h"
#import "ProductViewModel.h"

@interface SupplyListViewController ()

@property (nonatomic, strong) ProductViewModel *viewModelProduct;

@end

@implementation SupplyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelProduct = [[ProductViewModel alloc] init];
    [self.viewModelProduct getProductListWithCatid:self.intCatid start:-1 count:-1];
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
