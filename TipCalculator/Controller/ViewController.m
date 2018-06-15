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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateTip:(id)sender {
    [self.billAmountTextField resignFirstResponder];
    [self.customAmountTextField resignFirstResponder];
    
    //    double billAmount = [self.billAmountTextField.text doubleValue];
    //    double defaultTipAmount = (billAmount * 1.15);
    //    double tipCustomAmountInteger = [self.customAmountTextField.text doubleValue];
    //
    //    if ([self.customAmountTextField.text isEqualToString:@"0"]){
    //    self.tipAmountLabel.text = [@(billAmount * (1+(tipCustomAmountInteger/100)))stringValue]; //returns amount 15%
    //
    //    } else {
    //    self.tipAmountLabel.text = [@(defaultTipAmount)stringValue]; //returns amount 15%
    //    }
    
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
    //    self.billAmountTextField.text = @"";
    //    self.customAmountTextField.text = @"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self displayText:self.billAmountTextField.text];
    [self displayText:self.customAmountTextField.text];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self displayText:textField.text];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_billAmountTextField resignFirstResponder];
    [_customAmountTextField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tipLabel = self.tipAmountLabel.text;
    BOOL (isDeleting) = range.length == 1;
    if (isDeleting) {
        tipLabel = [tipLabel substringToIndex:range.location];
    }
    self.tipAmountLabel.text = tipLabel;
    return YES;
}

@end
