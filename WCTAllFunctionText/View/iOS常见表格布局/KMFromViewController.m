//
//  KMFromViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "KMFromViewController.h"
#import "KWFormViewQuickBuilder.h"

@interface KMFromViewController ()
{
    KWFormView *_formView;
    NSMutableArray *_dataArray;
}
@end

@implementation KMFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VBK_WC;
    
    _dataArray = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        NSDictionary *dict = @{@"orderName":@"药",@"orderSubTotal":@"100",@"chargeStatus":@"B"};
        [_dataArray addObject:dict];
    }
    [self crteateFormView];
}


- (void)crteateFormView
{
    KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc] init];
    //添加标题
    [builder addRecord:@[@"名称",@"金额（元）",@"支付状态"]];
    for (NSDictionary *dic in _dataArray) {
        NSString *stateString = @"";
        if ([[dic objectForKey:@"chargeStatus"] isEqualToString:@"Y"]) {
            stateString = @"已缴费";
        }else if ([[dic objectForKey:@"chargeStatus"] isEqualToString:@"N"]){
            stateString = @"未缴费";
        }else if ([[dic objectForKey:@"chargeStatus"] isEqualToString:@"B"]){
            stateString = @"退费";
        }
        
        //添加数据
        [builder addRecord:@[[dic objectForKey:@"orderName"],[dic objectForKey:@"orderSubTotal"],stateString]];
    }
    
    _formView = [builder startCreatWithWidths:@[@(100),@(50),@(200)] startPoint:CGPointMake(15, 100)];
    [self.view addSubview:_formView];
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
