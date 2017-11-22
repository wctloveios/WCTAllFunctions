//
//  TextIQKeyBoardManagerViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "TextIQKeyBoardManagerViewController.h"

@interface TextIQKeyBoardManagerViewController ()

@end

@implementation TextIQKeyBoardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i= 0; i<8; i++) {
        
        UITextField *textFiled = [[UITextField alloc]initWithFrame:CGRectMake(50, i*60 + 64 + 20, 200, 50)];
        textFiled.borderStyle = UITextBorderStyleRoundedRect;
        textFiled.backgroundColor = [UIColor lightGrayColor];
        textFiled.placeholder = [NSString stringWithFormat:@"%04d",i];
        [self.view addSubview:textFiled];
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
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

@end
