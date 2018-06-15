//
//  ViewController.m
//  TipCalculator
//
//  Created by Will Chew on 2018-06-15.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateTip:(id)sender {
    
    
    NSString *tipString = self.billAmountTextField.text;
    NSInteger tipInteger = [tipString integerValue];
    NSInteger tipAmount = (tipInteger * 1.15);
    
    self.tipAmountLabel.text = [@(tipAmount)stringValue];
    
}


@end
