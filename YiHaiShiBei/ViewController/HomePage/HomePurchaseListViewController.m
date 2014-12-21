//
//  HomePurchaseListViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/11/19.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "HomePurchaseListViewController.h"
#import "RequirePurchaseModel.h"
#import "PurchaseViewModel.h"
#import "HomePurchaseTableViewCell.h"
#import "MJRefresh.h"
#import "AppConfig.h"
#import "AddPurchaseViewController.h"
#import "RequirePurchaseDetailViewController.h"

@interface HomePurchaseListViewController ()<UITableViewDataSource, UITableViewDelegate, PurchaseViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) PurchaseViewModel *viewModelPurchase;

@end

@implementation HomePurchaseListViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPuchaseAction:(id)sender
{
    [self performSegueWithIdentifier:@"segueAddPurchase" sender:sender];
    
}

- (void)addPuchaseBtnFunc
{
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(0, 0, 60, 30);
    [btnAdd setTitle:@"添加求购" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addPuchaseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewModelPurchase.delegate = self;
    NSIndexPath *indexPath = [self.tbViewContent indexPathForSelectedRow];
    if(indexPath) {
        [self.tbViewContent deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.viewModelPurchase.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModelPurchase = [[PurchaseViewModel alloc]  init];
    
    [self setNaviBarTitle:@"求购列表"];
    [self setBackButton];
    [self addPuchaseBtnFunc];
    __weak HomePurchaseListViewController *weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        if (weakSelf.viewModelPurchase) {
            [weakSelf.viewModelPurchase getAllPurchaseList:-1 districtID:-1 productCateID:0 start:-1 num:-1];
        }
    }];
    [self.viewModelPurchase getCachedRequirePurchaseList];
    if (self.viewModelPurchase.arrAllPurchaseList.count > 0) {
        [self.tbViewContent reloadData];
    } else {
        [self.tbViewContent headerBeginRefreshing];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueAddPurchase"]) {
        AddPurchaseViewController *viewController = segue.destinationViewController;
        __weak HomePurchaseListViewController *weakSelf = self;
        viewController.AddPurchaseBlock = ^(BOOL success){
//            [weakSelf.tbViewContent headerBeginRefreshing];
        };
    } else if ([segue.identifier isEqualToString:@"seguePurchaseDetail"]) {
        UITableViewCell *cellSelect = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tbViewContent indexPathForCell:cellSelect];
        RequirePurchaseDetailViewController *viewController = segue.destinationViewController;
        viewController.model = self.viewModelPurchase.arrAllPurchaseList[indexPath.row];
    }
}


#pragma mark - PurchaseViewModel methods
- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllPurchaseList) {
        [self.tbViewContent reloadData];
    }
    [self.tbViewContent headerEndRefreshing];
}

- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllPurchaseList) {
        
    }
    [self.tbViewContent headerEndRefreshing];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePurchaseTableViewCell"];
    RequirePurchaseModel *model = self.viewModelPurchase.arrAllPurchaseList[indexPath.row];
    cell.lblTitle.text = [NSString stringWithFormat:@"标题: %@",model.purchaseTitle];
    cell.lblContent.text = [NSString stringWithFormat:@"内容: %@",model.purchaseInfo];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelPurchase.arrAllPurchaseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
}

@end
