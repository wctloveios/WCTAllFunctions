//
//  TextMJRefreshViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "TextMJRefreshViewController.h"

@interface TextMJRefreshViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *dataArray;
    
}

@end

@implementation TextMJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    dataArray = [[NSMutableArray alloc]init];
    [self addData];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    
    //防止block中循环引用的问题
    __weak typeof (self) mySelf = self;
    
    //下拉刷新
    [tableV addHeaderWithCallback:^{
        [mySelf addData];
    }];
    
    //上拉刷新
    [tableV addFooterWithCallback:^{
        [mySelf addData2];
    }];
    
    
}

-(void)addData
{
    [dataArray removeAllObjects];
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"%04d",arc4random()%10000]];
    }
    [tableV reloadData];
    //停止头部刷新
    [tableV headerEndRefreshing];
}

-(void)addData2
{
    for (int i=0; i<20; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"刷新数据%d",i]];
    }
    [tableV reloadData];
    //停止尾部刷新
    [tableV footerEndRefreshing];
}

#pragma mark - UITableViewDeleGate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
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
