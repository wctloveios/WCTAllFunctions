//
//  TextHUDViewController.m
//  WCTAllFunctionText
//
//  Created by 董嵩 on 16/3/19.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "TextHUDViewController.h"

#define Register_Loading @"正在注册"
#define RequestState_Loading @"加载中..."
#define NoNetWork_Check @"您还未连上网络，请检查后再操作!"
#define GetInfoMessage @"正在获取信息..."
#define GetLoading @"正在加载数据"
#define NoMoreData @"没有更多数据"
#define PostLoading @"正在上传"
#define LogInState_Ing @"登录中..."
#define LoginFailed @"登录失败"

@interface TextHUDViewController ()
{
    UIView *view ;
}
@end

@implementation TextHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatButton];
}

-(void)creatButton
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width , 300)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 60, 20);
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(300, 100, 60, 20);
    [button1 setTitle:@"结果" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(press1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

-(void)press{
    
    
    /**
     *   只显示一个一直加载的HUD
     */
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    /**
     *  显示内容(字和图片)  随后消失
     */
    //    [MBProgressHUD showInfoWithStatus:GetLoading withView:self.view];
    
    /**
     *  一直显示
     */
    [MBProgressHUD showHUDAddedTo:view withString:@"正在刷新"];
    
    /**
     *  显示内容(字和图片)  随后消失
     */
    [MBProgressHUD showSuccess:GetLoading toView:view];
    [MBProgressHUD showSuccessWithStatus:GetLoading withView:view];
    //    [MBProgressHUD showError:<#(NSString *)#> toView:<#(UIView *)#>]
    //    [MBProgressHUD showErrorWithStatus:<#(NSString *)#> withView:<#(UIView *)#>]
    
    /**
     *  windows被操作 一直显示
     */
    [MBProgressHUD showMessag:GetLoading toView:view];
}

-(void)press1{
    /**
     *  结束所有一直显示的HUD
     */
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    //    [MBProgressHUD hideHUDForView:view animated:YES];
    
    
    [MBProgressHUD showErrorWithStatus:NoMoreData withView:view];
    
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
