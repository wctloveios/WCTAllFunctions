//
//  SecondViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "SecondViewController.h"
#import "FromVC.h"

@interface SecondViewController ()
{
    NSMutableArray *array;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VBK_WC;
    
    array = [[NSMutableArray alloc]init];
    NSDictionary *dict = @{@"name":@"脑残片",@"does":@"20",@"remarks":@"煎服",@"use":@"一天/三次"};
    [array addObject:@"药名"];
    [array addObject:@"剂量(g)"];
    [array addObject:@"备注"];
    [array addObject:@"用法用量"];
    for (int i=0; i<3; i++) {
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]]];
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"does"]]];
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"remarks"]]];
        [array addObject:[NSString stringWithFormat:@"%@",[dict objectForKey:@"use"]]];
    }
    [self show];
    
}

-(void)show
{
    //提前给行，列，高度，能设置显示frame
    FromVC *view = [[FromVC alloc]init];
    view.line = 7;
    view.arrange = 4;
    view.heigth = 30;
    view.frame = CGRectMake(0, 100, MainScreenWidth, view.line*view.heigth);
    [self.view addSubview:view];
    
    [view showFormWithData1:array andLine:7 andArrange:4 andHeigh:30];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
