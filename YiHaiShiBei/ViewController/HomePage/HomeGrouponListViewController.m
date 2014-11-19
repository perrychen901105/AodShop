//
//  HomeGrouponListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomeGrouponListViewController.h"

@interface HomeGrouponListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation HomeGrouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"寻求团购"];
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

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHomeGroupon"];
    cell.textLabel.text = @"a";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
