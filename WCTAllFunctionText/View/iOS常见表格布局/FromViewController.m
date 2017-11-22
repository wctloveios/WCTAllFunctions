//
//  FromViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "FromViewController.h"
#import "FromVC.h"
#import "FirstViewController.h"

@interface FromViewController ()
{
    NSMutableArray *array;
}
@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VBK_WC;
    
    //数组需要自己来传入
    array = [[NSMutableArray alloc]init];
    for (int i=0; i< 25; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [array addObject:str];
        
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
    FirstViewController *view = [[FirstViewController alloc]init];
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void)show
{
    //提前给行，列，高度，能设置显示frame
    FromVC *view = [[FromVC alloc]init];
    view.line = 5;
    view.arrange = 5;
    view.heigth = 30;
    view.frame = CGRectMake(0, 100, MainScreenWidth, view.line*view.heigth);
    [self.view addSubview:view];
    
    [view showFormWithData2:array andLine:5 andArrange:5 andHeigh:30];
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
