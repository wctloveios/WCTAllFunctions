//
//  FirstViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "FromVC.h"

@interface FirstViewController ()
{
    NSMutableArray *array;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VBK_WC;
    
    array = [[NSMutableArray alloc]init];
    NSDictionary *dict = @{@"name":@"脑残片",@"does":@"20",@"remarks":@"煎服"};
    [array addObject:@"药名"];
    [array addObject:@"剂量(g)"];
    [array addObject:@"备注"];
    for (int i=0; i<5; i++) {
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]]];
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"does"]]];
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"remarks"]]];
    }
    [self show];
    
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeSystem];
    push.frame = CGRectMake(100, 300, MainScreenWidth-200, 30);
    push.backgroundColor = RGB(255, 160, 100);
    [push setTitle:@"Push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
    
}

-(void)push
{
    SecondViewController *view = [[SecondViewController alloc]init];
    
   [self.navigationController pushViewController:view animated:YES];
}

-(void)show
{
    //根据界面，提前给行，列，高度，能设置显示frame
    FromVC *view = [[FromVC alloc]init];
    view.line = 6;
    view.arrange = 3;
    view.heigth = 30;
    view.frame = CGRectMake(0, 100, MainScreenWidth, view.line*view.heigth);
    [self.view addSubview:view];
    
    [view showFormWithData:array andLine:6 andArrange:3 andHeigh:30];
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
