//
//  RequirePurchaseDetailViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/21.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "RequirePurchaseDetailViewController.h"
#import "RegisterRootViewController.h"
#import "PurchaseViewModel.h"
#import "PurchaseReplyModel.h"
#import "ReplyPurchaseCell.h"
@interface RequirePurchaseDetailViewController ()<UITextFieldDelegate, PurchaseViewModelDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *tfReply;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintInupBottom;
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseTime;
@property (weak, nonatomic) IBOutlet UILabel *lblUserPhone;
@property (weak, nonatomic) IBOutlet UITextView *tvPurchaseContent;
@property (weak, nonatomic) IBOutlet UITableView *tbViewReply;

@property (nonatomic, strong) PurchaseViewModel *viewModelPurchase;
- (IBAction)btnPressedCallPhone:(id)sender;

- (IBAction)btnpressed_reply:(id)sender;
@end

@implementation RequirePurchaseDetailViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyViewTapped
{
    [self.tfReply resignFirstResponder];
}

- (void)getReplyList
{
    if (self.apps.storedUserID <= 0) {
        return;
    }
    [self showProgressLabelHud:@"获取求购回复中..." withView:self.view];
    [self.viewModelPurchase getAllReplyPurchaseList:self.apps.storedUserID appKey:self.apps.stroedAppKey ppid:self.model.purchaseID typeID:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButton];
    [self setNaviBarTitle:@"求购详情"];
    [self addTapGestureOnEmptyView];
    
    self.viewModelPurchase = [[PurchaseViewModel alloc] init];
    self.viewModelPurchase.delegate = self;
    
    self.tvPurchaseContent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tvPurchaseContent.layer.borderWidth = 0.5;
    self.tvPurchaseContent.textContainer.lineFragmentPadding = 0;
    self.tvPurchaseContent.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self setupDetailView];
    
    [self getReplyList];
    // Do any additional setup after loading the view.
}

- (void)setupDetailView
{
    self.lblPurchaseTitle.text = self.model.purchaseTitle;
    self.lblPurchaseTime.text = self.model.purchaseTime;
    self.tvPurchaseContent.text = self.model.purchaseInfo;
    self.lblUserPhone.text = self.model.purchaseUsrPhone;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - PurchaseViewModel methods
- (void)purchaseRequestSuccessWithTag:(EnumPurchaseRequestType)type
{
    if (type == TypeRequestAllReplyList) {
        [self.tbViewReply reloadData];
        [self hideHudWithDelay:0];
    } else if (type == TypeRequestAddReplyPurchase) {
        [self showOnlyLabelHud:@"回复成功" withView:self.view];
        self.tfReply.text = @"";
        [self getReplyList];
    }
}

- (void)purchaseRequestError:(NSInteger)errorCode message:(NSString *)errorMessage type:(EnumPurchaseRequestType)type
{
    [self showOnlyLabelHud:errorMessage withView:self.view];
}

#pragma mark - UITableView methods
- (void)setupCellContent:(ReplyPurchaseCell *)cell indexPath:(NSIndexPath *)indexPath
{
    PurchaseReplyModel *model = self.viewModelPurchase.arrAllReplyPurchaseList[indexPath.row];
    cell.lblUsrName.text = [NSString stringWithFormat:@"用户名: %@",model.replyUserName];
    cell.lblContent.text = [NSString stringWithFormat:@"%@",model.content];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModelPurchase.arrAllReplyPurchaseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyPurchaseCell"];
    [self setupCellContent:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ReplyPurchaseCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:@"ReplyPurchaseCell"];
    });
    [self setupCellContent:sizingCell indexPath:indexPath];

    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1.0f;
}

#pragma mark - Keyboard methdos
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    [UIView animateWithDuration:animationDuration animations:^{
    }];
}

- (void)keyboardChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.constraintInupBottom.constant = height;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.constraintInupBottom.constant = 0;
    [self.view layoutIfNeeded];

}
- (IBAction)btnPressedCallPhone:(id)sender {
    if (self.model.purchaseUsrPhone.length > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.purchaseUsrPhone]]];
    }
}

- (IBAction)btnpressed_reply:(id)sender {
    if (self.apps.storedUserID <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        return;
    }
    NSString *strContent = [self.tfReply.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([strContent isEqualToString:@""]) {
        [self showOnlyLabelHud:@"请填写内容..." withView:self.view];
        return;
    }
    [self.tfReply resignFirstResponder];
    [self showProgressLabelHud:@"正在提交内容..." withView:self.view];
    [self.viewModelPurchase postReplyPurchase:self.apps.storedUserID appKey:self.apps.stroedAppKey ppid:self.model.purchaseID content:strContent];
    
}

#pragma mark - UIAlertview methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UINavigationController *viewControllerRoot = [[UIStoryboard storyboardWithName:@"Register" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        RegisterRootViewController *viewControllerRegister = (RegisterRootViewController *)[[viewControllerRoot viewControllers] objectAtIndex:0];
        __weak RequirePurchaseDetailViewController *weakSelf = self;
        [viewControllerRegister loginDidSuccess:^(BOOL success) {
            [weakSelf btnpressed_reply:nil];
        }];
        [self.navigationController presentViewController:viewControllerRoot animated:YES completion:^{
        }];
    }
}
@end
