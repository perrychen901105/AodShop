//
//  AddPurchaseViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/15.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "AddPurchaseViewController.h"
#import "ProductViewModel.h"
#import "ProductModel.h"
#import "AppConfig.h"
@interface AddPurchaseViewController ()<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, ProductViewModelDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewContent;

@property (weak, nonatomic) IBOutlet UIView *viewChooseType;
@property (weak, nonatomic) IBOutlet UITextField *tfChooseType;
@property (weak, nonatomic) IBOutlet UITextField *tfAddTitle;
@property (weak, nonatomic) IBOutlet UIView *viewAddContent;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lblTVplaceholder;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@property (nonatomic, assign) NSInteger selectTag;

@property (nonatomic, assign) NSInteger selectCatID;

@property (strong,nonatomic) NSArray *theData;

@property (strong, nonatomic) ProductViewModel *viewModelProduct;

- (IBAction)btnpressed_submit:(id)sender;
@end

@implementation AddPurchaseViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getProductCategory
{
    [self showProgressLabelHud:@"正在请求中..." withView:self.view];
    [self.viewModelProduct getProductTypeListWithStart:-1 count:-1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"添加求购商品"];
    [self setBackButton];
    self.selectCatID = 0;
    
    self.selectTag = 0;
    self.tfAddTitle.tag = 1;
    self.tfChooseType.tag = 2;
    self.tvContent.tag = 3;
    
    self.tvContent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tvContent.layer.borderWidth = 0.5;
    self.tvContent.textContainer.lineFragmentPadding = 0;
    self.tvContent.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.viewModelProduct = [[ProductViewModel alloc] init];
    self.viewModelProduct.delegate = self;
    [self getProductCategory];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.tfChooseType.inputView = picker;

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfAddTitle.leftView = paddingView;
    self.tfAddTitle.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfChooseType.leftView = paddingViewTwo;
    self.tfChooseType.leftViewMode = UITextFieldViewModeAlways;
    UITapGestureRecognizer *gesDismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputView)];
    [self.scrollViewContent addGestureRecognizer:gesDismissKeyboard];
}

- (void)dismissInputView
{
    [self.tfChooseType resignFirstResponder];
    [self.tfAddTitle resignFirstResponder];
    [self.tvContent resignFirstResponder];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Product viewmodel methods
- (void)productHttpError:(NSInteger)errorCode errMsg:(NSString *)errorStr withType:(EnumProductRequestType)typeRequest
{
    [self hideHudWithDelay:0];
}

- (void)productHttpSuccessWithTag:(EnumProductRequestType)typeRequest
{
    if (typeRequest == ProductRequestAllTypeList) {
        self.theData = self.viewModelProduct.arrAllProCatList;
        if (self.viewModelProduct.arrAllProCatList.count > 0) {
            ProductCatModel *model = self.viewModelProduct.arrAllProCatList[0];
            self.tfChooseType.text = model.name;
            self.selectCatID = model.catID;
        }
        [self hideHudWithDelay:0];
    } else if (typeRequest == ProductRequestAddPurchase) {
        
        [self showOnlyLabelHud:@"提交成功" withView:self.view];
        self.HUD.delegate = self;
        self.HUD.tag = 100;
    }
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud.tag == 100) {
        if (self.AddPurchaseBlock) {
            self.AddPurchaseBlock(YES);
        }
        [self backAction];
    }
}

#pragma mark - Keyboard methods
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
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

#pragma mark - UITextView methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.lblTVplaceholder.hidden = YES;
    self.tvContent.layer.borderColor = [COLOR_TITLE_DEFAULT CGColor];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *strContent = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (strContent.length <= 0) {
        self.lblTVplaceholder.hidden = NO;
    }
    self.tvContent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

#pragma mark - UITextField methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 2) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        [self.tfAddTitle setBackground:[UIImage imageNamed:@"editLineSelectBg"]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        [self.tfAddTitle setBackground:[UIImage imageNamed:@"editLineBg"]];
    }
}

#pragma mark - UIPicker methods
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.theData.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    ProductCatModel *model = self.theData[row];
    NSString *title = model.name;
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:COLOR_TITLE_DEFAULT,NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    
    return attString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    ProductCatModel *model = self.theData[row];
    self.selectCatID = model.catID;
    self.tfChooseType.text = model.name;
}

- (IBAction)btnpressed_submit:(id)sender {
    [self dismissInputView];
    NSString *strPurchaseTitle = [self.tfAddTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *strPurchaseInfo = [self.tvContent.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (self.apps.storedDistrictID <= 0) {
        [self showOnlyLabelHud:@"请选择地区" withView:self.view];
        return;
    }
    if (self.apps.storedUserID <= 0) {
        [self showOnlyLabelHud:@"请登录" withView:self.view];
        return;
    }
//    if (self.selectCatID <= 0) {
//        [self showOnlyLabelHud:@"请选择分类" withView:self.view];
//        return;
//    }
    if (strPurchaseTitle.length <= 0) {
        [self showOnlyLabelHud:@"请填写标题" withView:self.view];
        return;
    } else if (strPurchaseTitle.length > 10) {
        [self showOnlyLabelHud:@"标题不能超过10个字" withView:self.view];
        return;
    }
    if (strPurchaseInfo.length <= 0) {
        [self showOnlyLabelHud:@"请填写内容" withView:self.view];
        return;
    }
    
    [self showProgressLabelHud:@"正在提交中..." withView:self.view];
    [self.viewModelProduct postToPurchaseWithUsrID:self.apps.storedUserID appKey:self.apps.stroedAppKey title:strPurchaseTitle purchaseInfo:strPurchaseInfo districtID:self.apps.storedDistrictID productcatid:self.selectCatID];
}
@end
