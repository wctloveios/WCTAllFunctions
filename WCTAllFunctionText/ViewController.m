//
//  ViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/17.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ViewController.h"
#import "ShowQRCodeDetailViewController.h"
#import "ChooseShowDetailViewController.h"
#import "ShowImageWithTitleViewController.h"
#import "WebViewViewController.h"
#import "TextIQKeyBoardManagerViewController.h"
#import "TextMJRefreshViewController.h"
#import "ShowImageOnScrollviewViewController.h"
#import "TextHUDViewController.h"
#import "TextPhotoZoomViewController.h"
#import "TextTimerViewController.h"
#import "ScanCodeViewController.h"
#import "MuchChooseDeleteViewController.h"
#import "SecretViewController.h"
#import "FromViewController.h"
#import "KMFromViewController.h"
#import "LabelViewController.h"
#import "AutoScrollImageImageViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tvCurrent;
    NSMutableArray *_dataArray;
    
    NSArray *_firstArray;
    NSArray *_secondArray;
}
@end

@implementation ViewController
/**
// *
// *  视图初始化方法
// *
// */
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        _dataArray = [[NSMutableArray alloc]init];
//        NSLog(@"初始化方法，各种初始化都可以放这里！！！");
//    }
//    
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    label.text = @"iOS功能集锦";
    label.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = label;
    
    
    [self initTableView];
}
/**
 *  创建视图
 */
-(void)initTableView
{
    _firstArray = @[@"功能1：折线图(血压、血糖、血氧)",
                    @"功能2：点击身体部位显示点击位置内容",
                    @"功能3：WebView展示HTML语言",
                    @"功能4：键盘弹起输入框上移",
                    @"功能5：Reachability监测网络状态",
                    @"功能6：MJRefresh刷新",
                    @"功能7：永久滚动的ScrollView",
                    @"功能8：HUD提示框",
                    @"功能9：图片点击放大缩小",
                    @"功能10：计时器和倒数",
                    @"功能11：tableView多选和直接删除（多个tv）",
                    @"功能12：iOS常见加密解密",
                    @"功能13：iOS常见表格布局",
                    @"功能14：KMFrom表格",
                    @"功能15：Label自动变高",
                    @"功能16：自动滚动的图片",
                    @"功能17：",
                    @"功能18：",
                    @"功能19：",
                    @"功能20："];
    _secondArray = @[@"功能1：二维码（GS暂时没有扫描本地二维码功能）",
                     @"功能2：扫一扫（LW）",
                     @"功能3：",
                     @"功能4：",
                     @"功能5：",
                     @"功能6：",
                     @"功能7：",
                     @"功能8：",
                     @"功能9：",
                     @"功能10："];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:_firstArray];
    [_dataArray addObject:_secondArray];
//    NSLog(@"%@%@%@",_firstArray,_secondArray,_dataArray);
    
    _tvCurrent = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 50) style:UITableViewStyleGrouped];
    _tvCurrent.delegate = self;
    _tvCurrent.dataSource = self;
    [self.view addSubview:_tvCurrent];
    
    UIImageView *footView = [[UIImageView alloc]initWithFrame:CGRectMake(0, MainScreenHeight - 50 , MainScreenWidth, 50)];
    footView.image = [UIImage imageNamed:@"footView"];
    [self.view addSubview:footView];
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return _firstArray.count;
    else
        return _secondArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.textLabel.text = [_dataArray[indexPath.section] objectAtIndex:[indexPath row ]];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 60)];
    view.backgroundColor = [UIColor colorWithRed:130/255.0 green:200/255.0 blue:240/255.0 alpha:0.3];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, MainScreenWidth - 40, 60)];
    if (section == 0)
        label.text = @"简单功能：模拟器能执行的功能";
    else
        label.text = @"复杂功能：模拟器上不能执行的功能";
    [view addSubview:label];

    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

#pragma mark -UITableViewDelegete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //简单功能
        switch (indexPath.row) {
            case 0:
            {
                // 折线图(血压、血糖、血氧)
                NSLog(@"折线图(血压、血糖、血氧)");
                ChooseShowDetailViewController *view = [[ChooseShowDetailViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 1:
            {
                //点击身体部位显示点击位置内容
                NSLog(@"点击身体部位显示点击位置内容");
                ShowImageWithTitleViewController *view = [[ShowImageWithTitleViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            
            }
                break;
            case 2:
            {
                //WebView展示HTML语言
                NSLog(@"WebView展示HTML语言");
                WebViewViewController *view = [[WebViewViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
                
            }
                break;
            case 3:
            {
                //键盘弹起输入框上移
                NSLog(@"键盘弹起输入框上移");
                TextIQKeyBoardManagerViewController *view = [[TextIQKeyBoardManagerViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
                
            }
                break;
            case 4:
            {
                //Reachability监测网络状态（AppDeleGate）
                NSLog(@"Reachability监测网络状态（AppDeleGate）");
                [WCTTool showAlertMessage:@"后台监测网络，代码请到AppDelegate查看"];
            }
                break;
            case 5:
            {
                //MJRefresh刷新
                NSLog(@"MJRefresh刷新");
                TextMJRefreshViewController *view = [[TextMJRefreshViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 6:
            {
                //永久滚动的ScrollView
                NSLog(@"永久滚动的ScrollView");
                ShowImageOnScrollviewViewController *view = [[ShowImageOnScrollviewViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 7:
            {
                //HUD提示框
                NSLog(@"HUD提示框");
                TextHUDViewController *view = [[TextHUDViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 8:
            {
                //图片点击放大缩小 计时器和倒数
                NSLog(@"图片点击放大缩小");
                TextPhotoZoomViewController *view = [[TextPhotoZoomViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 9:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 10:
            {
                //tableView多选和直接删除（多个tv）
                NSLog(@"tableView多选和直接删除（多个tv）");
                                MuchChooseDeleteViewController *view = [[MuchChooseDeleteViewController alloc]init];
//                view.prescribeName = @"中药处方";
                view.prescribeName = @"西药处方";
                                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 11:
            {
                //iOS常见加密解密
                NSLog(@"iOS常见加密解密");
                SecretViewController *view = [[SecretViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 12:
            {
                //iOS常见表格布局"
                NSLog(@"iOS常见表格布局");
                FromViewController *view = [[FromViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 13:
            {
                //KMFrom表格
                NSLog(@"KMFrom表格");
                KMFromViewController *view = [[KMFromViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 14:
            {
                //Label自动变高
                NSLog(@"Label自动变高");
                LabelViewController *view = [[LabelViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 15:
            {
                //自动滚动图片
                NSLog(@"自动滚动图片");
                AutoScrollImageImageViewController *view = [[AutoScrollImageImageViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 16:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                //                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                //                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 17:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                //                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                //                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 18:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                //                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                //                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 19:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                //                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                //                [self.navigationController pushViewController:view animated:YES];
            }
                break;
            case 20:
            {
                //计时器和倒数
                NSLog(@"计时器和倒数");
                //                TextTimerViewController *view = [[TextTimerViewController alloc]init];
                //                [self.navigationController pushViewController:view animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        //复杂功能
        switch (indexPath.row) {
            case 0:
            {
                // 二维码（暂时没有扫描本地二维码功能）
                NSLog(@"二维码（暂时没有扫描本地二维码功能）");
                ShowQRCodeDetailViewController *view = [[ShowQRCodeDetailViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
                
            }
                break;
            case 1:
            {
                // 扫一扫
                NSLog(@"扫一扫");
                ScanCodeViewController *view = [[ScanCodeViewController alloc]init];
                [self.navigationController pushViewController:view animated:YES];
                
            }
                break;
                
            default:
                break;
        }
    }

}
@end
