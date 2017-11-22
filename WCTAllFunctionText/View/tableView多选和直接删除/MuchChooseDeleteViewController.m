//
//  MuchChooseDeleteViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "MuchChooseDeleteViewController.h"

#import "ChinaMedicinesTableViewCell.h"
#import "WeastMedicinesTableViewCell.h"

#import "DeleteDirectlyViewController.h"

@interface MuchChooseDeleteViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *removeDataBtn;
    
    NSArray *chinadiagArr;
    NSArray *medicinesFromArr;
    NSArray *listArr;
    NSMutableArray *medicinesListArr;
    NSMutableArray *removeArr;
    
    UITextField *chinaDiagTF;
    UITextField *medicinesFromTF;
    UITextField *listTF;
    
    UITableView *chinaTV;
    UITableView *medicineFromTV;
    UITableView *listTV;
    UITableView *medicineListTV;
    
}
@end

@implementation MuchChooseDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //  导航栏下一步按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"直接删除" forState:UIControlStateNormal];
    nextBtn.frame = CGRectMake(0, 0, 80, 25);
    [nextBtn setTintColor:[UIColor whiteColor]];
    [nextBtn addTarget:self action:@selector(pressNetBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    
    [self initMainView];
    
}
#pragma mark - 整体界面搭建
-(void)initMainView
{
    /**
     两个下拉菜单框
     */
    chinadiagArr = @[@"感冒",@"发烧",@"都比",@"没事",@"坐月子",@"中毒",@"吃撑了",@"傻缺",@"笨蛋",@"蠢得死",@"麻烦精",];
    medicinesFromArr = @[@"普宁大药房",@"北京大药房",@"深证大药房",@"武汉大药房",@"杭州大药房",@"1111111",@"2222222",@"3333333",@"4444444",@"5555555",@"6666666",];
    listArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"20",@"30",@"40",@"50",@"60",@"70"];
    
    medicinesListArr = [[NSMutableArray alloc]init];
    removeArr = [[NSMutableArray alloc]init];
    NSDictionary *dict0 = @{@"name":@"0000",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict1 = @{@"name":@"1111",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict2 = @{@"name":@"2222",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict3 = @{@"name":@"3333",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict4 = @{@"name":@"4444",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict5 = @{@"name":@"5555",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict6 = @{@"name":@"6666",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict7 = @{@"name":@"7777",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict8 = @{@"name":@"8888",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    NSDictionary *dict9 = @{@"name":@"9999",@"rank":@"100片*0.5g/瓶",@"factory":@"康美健康云",@"dose":@"2瓶",@"use":@"口含",@"desc":@"无法形容"};
    [medicinesListArr addObject:dict0];
    [medicinesListArr addObject:dict1];
    [medicinesListArr addObject:dict2];
    [medicinesListArr addObject:dict3];
    [medicinesListArr addObject:dict4];
    [medicinesListArr addObject:dict5];
    [medicinesListArr addObject:dict6];
    [medicinesListArr addObject:dict7];
    [medicinesListArr addObject:dict8];
    [medicinesListArr addObject:dict9];
    
    //1.1中医诊断
    UILabel *chainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50+64, 80, 30)];
    chainLabel.text = @"中医诊断：";
    chainLabel.font = kFont;
    [self.view addSubview:chainLabel];
    
    //1.2中医诊断TF
    chinaDiagTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 50+64, MainScreenWidth - 100 - 10, 30)];
    chinaDiagTF.borderStyle = UITextBorderStyleRoundedRect;
    chinaDiagTF.placeholder = @"请点击选择...";
    chinaDiagTF.secureTextEntry = NO;   //明文显示
    chinaDiagTF.clearButtonMode = UITextFieldViewModeNever; //不显示删除按钮
    chinaDiagTF.rightViewMode = UITextFieldViewModeAlways;
    chinaDiagTF.tag = 301;
    [self.view addSubview:chinaDiagTF];
    
    //1.3
    UIButton *arrowBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    arrowBtn1.frame = CGRectMake(100, 50+64, MainScreenWidth - 100 - 10, 30);
    arrowBtn1.backgroundColor = [UIColor clearColor];
    arrowBtn1.tag = 201;
    [arrowBtn1 addTarget:self action:@selector(pullTableViewWithData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arrowBtn1];
    
    //2.1药物来源：
    UILabel *medicinesFromLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90+64, 80, 30)];
    medicinesFromLabel.text = @"药物来源：";
    medicinesFromLabel.font = kFont;
    [self.view addSubview:medicinesFromLabel];
    
    //2.2药物来源TF
    medicinesFromTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 90+64, MainScreenWidth - 100 - 10, 30)];
    medicinesFromTF.borderStyle = UITextBorderStyleRoundedRect;
    medicinesFromTF.placeholder = @"请点击选择...";
    medicinesFromTF.secureTextEntry = NO;   //明文显示
    medicinesFromTF.clearButtonMode = UITextFieldViewModeNever; //不显示删除按钮
    medicinesFromTF.rightViewMode = UITextFieldViewModeAlways;
    medicinesFromTF.tag = 302;
    [self.view addSubview:medicinesFromTF];
    
    //2.3
    UIButton *arrowBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    arrowBtn2.frame = CGRectMake(100, 90+64, MainScreenWidth - 100 - 10, 30);
    arrowBtn2.backgroundColor = [UIColor clearColor];
    arrowBtn2.tag = 202;
    [arrowBtn2 addTarget:self action:@selector(pullTableViewWithData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arrowBtn2];
    
    
    //    3.1中药清单：
    UILabel *listLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 130+64, 80, 30)];
    if([self.prescribeName isEqualToString:@"中药处方"])
    {
        listLable.text = @"中药清单：";
        
        UILabel *numLable1 = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth - 150, 130+64, 40 , 30)];
        numLable1.text = @"数量";
        numLable1.textAlignment = NSTextAlignmentCenter;
        numLable1.font = kFont;
        [self.view addSubview:numLable1];
        
        //3.2中药清单TF
        listTF = [[UITextField alloc]initWithFrame:CGRectMake(MainScreenWidth - 150 + 40 , 130+64, 70 , 30)];
        listTF.borderStyle = UITextBorderStyleRoundedRect;
        listTF.placeholder = @"00";
        listTF.textAlignment = NSTextAlignmentCenter;
        listTF.secureTextEntry = NO;   //明文显示
        listTF.clearButtonMode = UITextFieldViewModeNever; //不显示删除按钮
        listTF.rightViewMode = UITextFieldViewModeAlways;
        listTF.tag = 303;
        [self.view addSubview:listTF];
        
        UILabel *numLable2 = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth - 150 + 40 + 70, 130+64, 40, 30)];
        numLable2.text = @"剂";
        numLable2.font = kFont;
        numLable2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:numLable2];
        
    }
    else
        listLable.text = @"西药清单：";
    listLable.font = kFont;
    [self.view addSubview:listLable];
    
    
    //3.3
    UIButton *arrowBtn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    arrowBtn3.frame = CGRectMake(MainScreenWidth - 150 + 40 , 130+64, 70 , 30);
    arrowBtn3.backgroundColor = [UIColor clearColor];
    arrowBtn3.tag = 203;
    [arrowBtn3 addTarget:self action:@selector(pullTableViewWithData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arrowBtn3];
    
    
    medicineListTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 160+64, MainScreenWidth,MainScreenHeight - 160 - 150) style:UITableViewStylePlain];
    medicineListTV.tag = 104;
    medicineListTV.delegate = self;
    medicineListTV.dataSource = self;
    medicineListTV.bounces = NO;
    medicineListTV.editing = YES;
    [self.view addSubview:medicineListTV];
    
    
    // 多选删除药品按钮
    removeDataBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    removeDataBtn.frame = CGRectMake(25, MainScreenHeight - 140 +64 , MainScreenWidth-50 , 30);
    [removeDataBtn setTitle:@"删除药品" forState:UIControlStateNormal];
    [removeDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    removeDataBtn.titleLabel.font = kFont;
    removeDataBtn.layer.cornerRadius = 15.f;
    [removeDataBtn setBackgroundColor:[UIColor orangeColor]];
    [removeDataBtn addTarget:self action:@selector(toggleEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeDataBtn];
}

#pragma  mark - 点击弹出tableview（三个）
-(void)pullTableViewWithData:(UIButton *)bubtton
{
    if (bubtton.tag == 201) {
        
        chinaTV = [[UITableView alloc]initWithFrame:CGRectMake(100, 50+64, MainScreenWidth - 100 - 10, 200) style:UITableViewStylePlain];
        chinaTV.tag = 101;
        chinaTV.delegate = self;
        chinaTV.dataSource = self;
        chinaTV.bounces = NO;
        [self.view addSubview:chinaTV];
        
    }
    else if (bubtton.tag == 202) {
        
        medicineFromTV = [[UITableView alloc]initWithFrame:CGRectMake(100, 90+64, MainScreenWidth - 100 - 10, 200) style:UITableViewStylePlain];
        medicineFromTV.tag = 102;
        medicineFromTV.delegate = self;
        medicineFromTV.dataSource = self;
        medicineFromTV.bounces = NO;
        [self.view addSubview:medicineFromTV];
        
    }
    else
    {
        listTV = [[UITableView alloc]initWithFrame:CGRectMake(MainScreenWidth - 150 + 40 , 130+64, 70 , 200) style:UITableViewStylePlain];
        listTV.tag = 103;
        listTV.delegate = self;
        listTV.dataSource = self;
        listTV.separatorStyle = UITableViewCellAccessoryNone;
        listTV.bounces = NO;
        [self.view addSubview:listTV];
    }
    
}

#pragma mark - 下一步（保存处方）
-(void)pressNetBtn:(UIButton *)button
{
    DeleteDirectlyViewController *view = [[DeleteDirectlyViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - UITableViewDategete
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        return chinadiagArr.count;
    }
    else  if (tableView.tag == 102) {
        return medicinesFromArr.count;
    }
    else  if (tableView.tag == 103)
    {
        return listArr.count;
    }
    else
    {
        return medicinesListArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 104) {
        if([self.prescribeName isEqualToString:@"中药处方"])
        {
            NSDictionary *dict = medicinesListArr[indexPath.row];
            
            static NSString *cellIdentifier = @"moreCell";
            ChinaMedicinesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[ChinaMedicinesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            cell.nameLabel.text = [NSString stringWithFormat:@"  药名：%@000%ld",[dict objectForKey:@"name"],indexPath.row];
            cell.doseLabel.text = [NSString stringWithFormat:@"  剂量：%@",[dict objectForKey:@"rank"]];
            cell.useLable.text = [NSString stringWithFormat:@"  用法：%@",[dict objectForKey:@"use"]];
            //cell 删除选中颜色
            cell.tintColor = [UIColor redColor];
            return cell;
            
        }
        else
        {
            NSDictionary *dict = medicinesListArr[indexPath.row];
            
            static NSString *cellIdentifier = @"moreCell";
            WeastMedicinesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[WeastMedicinesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            cell.nameLabel.text = [NSString stringWithFormat:@"  药名：%@000%ld",[dict objectForKey:@"name"],indexPath.row];
            cell.doseLabel.text = [NSString stringWithFormat:@"  剂量：%@",[dict objectForKey:@"rank"]];
            cell.useLable.text = [NSString stringWithFormat:@"  用法：%@",[dict objectForKey:@"use"]];
            cell.rankLabel.text = [NSString stringWithFormat:@"  规格：%@",[dict objectForKey:@"rank"]];
            cell.factoryLabel.text = [NSString stringWithFormat:@"  厂家：%@",[dict objectForKey:@"factory"]];
            cell.descLabel.text = [NSString stringWithFormat:@"  描述：%@",[dict objectForKey:@"use"]];
            cell.tintColor = [UIColor redColor];
            return cell;
        }
    }
    else
    {
        static NSString *cellIdentifier = @"moreCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (tableView.tag == 101) {
            cell.textLabel.text = chinadiagArr[indexPath.row];
        }
        else  if (tableView.tag == 102) {
            cell.textLabel.text = medicinesFromArr[indexPath.row];
        }
        else if (tableView.tag == 103)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"   %@",listArr[indexPath.row]];
            cell.textLabel.font = kFont;
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 104)
    {
        if([self.prescribeName isEqualToString:@"中药处方"])
        {
            return 40;
        }
        else
            return 100;
    }
    else
        return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        chinaDiagTF.text = chinadiagArr[indexPath.row];
        //删除下拉菜单
        [tableView removeFromSuperview];
    }
    else if (tableView.tag == 102) {
        medicinesFromTF.text = medicinesFromArr[indexPath.row];
        
        [tableView removeFromSuperview];
    }
    else if (tableView.tag == 103)
    {
        listTF.text = listArr[indexPath.row];
        
        [tableView removeFromSuperview];
    }
    else
    {
        //点击cell没有跳转了
        
        if (medicineListTV.editing) {
            NSDictionary *dcit = medicinesListArr[indexPath.row];
            [removeArr addObject:dcit];
        }
        else
        {
            NSLog(@" cell 被点击了!");
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (medicineListTV.editing) {
        [removeArr removeObject:indexPath];
    }
}

#pragma mark - 删除操作

-(void)toggleEdit:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"删除药品"]) {
        [medicineListTV setEditing:YES animated:YES];
        [removeDataBtn setTitle:@"确认删除" forState:UIControlStateNormal];
    }
    else
    {
        //编辑状态准许删除
        if (medicineListTV.editing)
        {
            NSLog(@"removeArr.count == %ld",removeArr.count);
            NSLog(@"medicinesListArr.count == %ld",medicinesListArr.count);
            
            if (removeArr.count)
            {
                [medicinesListArr removeObjectsInArray:removeArr];
                
                //刷新TV和清空数组
                [medicineListTV reloadData];
                [removeArr removeAllObjects];
                
                NSLog(@"medicinesListArr.count == %ld",medicinesListArr.count);
                NSLog(@"removeArr.count == %ld",removeArr.count);
            }
            
            [medicineListTV setEditing:NO animated:YES];
            
            [removeDataBtn setTitle:@"删除药品" forState:UIControlStateNormal];
        }
        else
        {
            NSLog(@"removeArr.count == %ld",removeArr.count);
            NSLog(@"没什么好删除的");
            [removeArr removeAllObjects];
        }
        
    }
    
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
