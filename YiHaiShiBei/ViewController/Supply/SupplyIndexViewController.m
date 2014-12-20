//
//  SupplyIndexViewController.m
//  YiHaiShiBei
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "SupplyIndexViewController.h"
#import "ProductViewModel.h"
#import "ProductModel.h"
#import "MJRefresh.h"
#import "AppConfig.h"

#import "SupplyListViewController.h"

@interface SupplyIndexViewController ()<UITableViewDataSource, UITableViewDelegate, ProductViewModelDelegate>

@property (nonatomic, strong) ProductViewModel *viewModelProduct;

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation SupplyIndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBarTitle:@"供应类别"];
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;
    
    __weak SupplyIndexViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelProduct) {
            [weakSelf.viewModelProduct getProductTypeListWithStart:-1 count:-1];
        }
    }];
    [self.viewModelProduct getCachedProductTypeList];
    if (self.viewModelProduct.arrAllProCatList.count > 0) {
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueSupplyList"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        SupplyListViewController *viewControllerList = (SupplyListViewController *)segue.destinationViewController;
        ProductCatModel *modelType = self.viewModelProduct.arrAllProCatList[indexPath.row];
        viewControllerList.intCatid = modelType.catID;
        viewControllerList.strCatName = modelType.name;
    }
}


#pragma mark - Product ViewModel delegate
- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest
{
    if (typeRequest == ProductRequestAllTypeList) {
        if (self.viewModelProduct.arrAllProCatList.count > 0) {
            [self.tbViewContent reloadData];
        }
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest
{
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupplyTypeCell"];
    ProductCatModel *modelType = self.viewModelProduct.arrAllProCatList[indexPath.row];
    cell.textLabel.text = modelType.name;
    cell.textLabel.textColor = COLOR_TITLE_DEFAULT;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelProduct.arrAllProCatList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
