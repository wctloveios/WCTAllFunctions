//
//  ShowQRCodeDetailViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ShowQRCodeDetailViewController.h"
#import "ScanningQRCodeViewController.h"

@interface ShowQRCodeDetailViewController ()
{
    UILabel *_descLabel;
}
@end

@implementation ShowQRCodeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 200, MainScreenWidth - 40 , 30);
    button.backgroundColor = RGB(139, 236, 117);
    button.layer.cornerRadius = 5;
    [button setTitle:@"二维码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, MainScreenWidth, 100)];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.font = [UIFont systemFontOfSize:17];
    _descLabel.numberOfLines = 0;
    [self.view addSubview:_descLabel];
}

-(void)press:(UIButton *)button
{
    ScanningQRCodeViewController *view= [[ScanningQRCodeViewController alloc]init];
    view.didScanedResult = ^ (NSString *scanResult) {
        NSLog(@"二维码扫描结果是：%@", scanResult);
        //这里进行这种操作：（取消关注/添加关注等...）
        _descLabel.text =[NSString stringWithFormat:@"二维码扫描结果是：%@", scanResult];
    };
    [self.navigationController pushViewController:view animated:YES];
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
