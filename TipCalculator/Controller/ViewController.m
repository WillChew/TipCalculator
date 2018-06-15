//
//  ViewController.m
//  TipCalculator
//
//  Created by Will Chew on 2018-06-15.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *customAmountTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (assign, nonatomic) NSInteger bottomConstant;

@end

@implementation ViewController

#define defaultPercent 20

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.billAmountTextField.delegate = self;
    [self setupTextField];
    [self displayText:@""];
    self.tipAmountLabel.text = @"";
    self.customAmountTextField.delegate = self;
    self.customAmountTextField.text = @"";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHeight:) name:UIKeyboardWillShowNotification object:nil];
    
}

-(void)setBottomConstraint:(NSLayoutConstraint *)bottomConstraint {
    self.bottomConstant = bottomConstraint.constant;
    _bottomConstraint = bottomConstraint;
}

-(void)keyboardHeight:(NSNotification*)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSValue *value = userInfo[@"UIKeyboardBoundsUserInfoKey"];
//    NSInteger kbHeight = value.CGRectValue.size.height;
//    CGRect newBounds = CGRectMake(0, kbHeight, self.view.bounds.size.width, self.view.bounds.size.width);
//    self.view.bounds = newBounds;
    self.bottomConstraint.constant = self.bottomConstant + value.CGRectValue.size.height;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    self.view.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [textField resignFirstResponder];
    
    self.bottomConstraint.constant = self.bottomConstant;
    return YES;
}

- (void)tapGesture:(UITapGestureRecognizer*)sender {
    [self.billAmountTextField resignFirstResponder];
    [self.customAmountTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateTip:(id)sender {
    [self.billAmountTextField resignFirstResponder];
    [self.customAmountTextField resignFirstResponder];

    
}

-(void)setupTextField {
    self.billAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.customAmountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

-(void)displayText:(NSString*)text {
    
    float totalOfBill = [self.billAmountTextField.text floatValue];
    float customNumber = [self.customAmountTextField.text floatValue];
    float customTipAmount = (totalOfBill * (1+(customNumber/100)));
    NSString *defaultTip = [@(totalOfBill * 1.15) stringValue];
    //
    if (customTipAmount == 0) {
        self.tipAmountLabel.text = defaultTip;
    } else {
        self.tipAmountLabel.text = [@(customTipAmount)stringValue];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self displayText:@""];
    self.billAmountTextField.text = @"";
    self.customAmountTextField.text = @"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self displayText:self.billAmountTextField.text];
    [self displayText:self.customAmountTextField.text];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self displayText:textField.text];
    return YES;
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [_billAmountTextField resignFirstResponder];
//    [_customAmountTextField resignFirstResponder];
//    return YES;
//}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *oldStr = textField.text;
    NSString *billAmount = [oldStr stringByAppendingString:string];
    
    BOOL (isDeleting) = range.length == 1;
    if (isDeleting) {
        billAmount = [billAmount substringToIndex:range.location];
    }
    self.tipAmountLabel.text = billAmount;
    
    [self.tipAmountLabel sizeToFit];
    
    
    return YES;
}
    @end
