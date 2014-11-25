//
//  LocationListViewController.m
//  YiHaiShiBei
//
//  Created by qw on 14-11-11.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "LocationListViewController.h"
#import "DatabaseOperator.h"
#import "LocationModel.h"

@interface LocationListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation LocationListViewController

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
    [self setTitle:self.strTitle];
//    self.arrayLocation = [@[] mutableCopy];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)HadSelectLocation:(SelectLocationIndexBlock)selectBlock
{
    self.blockSelectedIndex = selectBlock;
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locationCell"];
    }
    if (self.TypeLocationList == ENUM_LOCATIONLIST_PROVINCE) {
        ProvinceModel *model = self.arrayLocation[indexPath.row];
        cell.textLabel.text = model.name;
    } else if (self.TypeLocationList == ENUM_LOCATIONLIST_CITY) {
        CityModel *model = self.arrayLocation[indexPath.row];
        cell.textLabel.text = model.name;
    } else {
        DistrinctModel *model = self.arrayLocation[indexPath.row];
        cell.textLabel.text = model.name;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayLocation.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.blockSelectedIndex != nil) {
        if (self.TypeLocationList == ENUM_LOCATIONLIST_PROVINCE) {
            ProvinceModel *model = self.arrayLocation[indexPath.row];
            self.blockSelectedIndex(model.provinceID, model.name);
        } else if (self.TypeLocationList == ENUM_LOCATIONLIST_CITY) {
            CityModel *model = self.arrayLocation[indexPath.row];
            self.blockSelectedIndex(model.cityID, model.name);
        } else {
            DistrinctModel *model = self.arrayLocation[indexPath.row];
            self.blockSelectedIndex(model.districtID, model.name);
        }
    }
    [self backAction];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
