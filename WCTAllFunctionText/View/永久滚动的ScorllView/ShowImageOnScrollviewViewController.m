//
//  ShowImageOnScrollviewViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ShowImageOnScrollviewViewController.h"
#import "WCTScrollView.h"

@interface ShowImageOnScrollviewViewController ()

@end

@implementation ShowImageOnScrollviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *tempArray = @[@"1111",@"2222",@"3333",@"4444",@"5555",@"6666"];
    /**
     需要提供的数据
     1、图片加载入本工程
     2、图片数组
     3、视图frame
     */
    WCTScrollView *view = [[WCTScrollView alloc]initWithFrame:CGRectMake(0, 64, MainScreenWidth, 300) imageItems:tempArray];
    
    //这是scrollview不会移动位置（关键一句）
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:view];
    

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
