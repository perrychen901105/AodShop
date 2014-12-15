//
//  AddPurchaseViewController.m
//  YiHaiShiBei
//
//  Created by chenzhipeng on 14/12/15.
//  Copyright (c) 2014年 perry. All rights reserved.
//

#import "AddPurchaseViewController.h"
#import "AppConfig.h"
@interface AddPurchaseViewController ()<UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewContent;

@property (weak, nonatomic) IBOutlet UIView *viewChooseType;
@property (weak, nonatomic) IBOutlet UITextField *tfChooseType;
@property (weak, nonatomic) IBOutlet UITextField *tfAddTitle;
@property (weak, nonatomic) IBOutlet UIView *viewAddContent;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lblTVplaceholder;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@property (nonatomic, assign) NSInteger selectTag;

@property (strong,nonatomic) NSArray *theData;

- (IBAction)btnpressed_submit:(id)sender;
@end

@implementation AddPurchaseViewController

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarTitle:@"添加求购商品"];
    [self setBackButton];
    
    self.selectTag = 0;
    self.tfAddTitle.tag = 1;
    self.tfChooseType.tag = 2;
    self.tvContent.tag = 3;
    
    self.tvContent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tvContent.layer.borderWidth = 0.5;
    self.tvContent.textContainer.lineFragmentPadding = 0;
    self.tvContent.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    
    picker.dataSource = self;
    picker.delegate = self;
    self.tfChooseType.inputView = picker;
    self.theData = @[@"one",@"two",@"three",@"four"];

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfAddTitle.leftView = paddingView;
    self.tfAddTitle.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.tfChooseType.leftView = paddingViewTwo;
    self.tfChooseType.leftViewMode = UITextFieldViewModeAlways;
    UITapGestureRecognizer *gesDismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputView)];
    [self.scrollViewContent addGestureRecognizer:gesDismissKeyboard];
    // Do any additional setup after loading the view.
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
    NSString *title = self.theData[row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:COLOR_TITLE_DEFAULT,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}];
    
    return attString;
    
}

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.theData[row];
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.tfChooseType.text = self.theData[row];
//    [self.tfChooseType resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnpressed_submit:(id)sender {
    [self dismissInputView];
}
@end
