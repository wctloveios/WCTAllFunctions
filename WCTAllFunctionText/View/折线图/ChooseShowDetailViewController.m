//
//  ChooseShowDetailViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ChooseShowDetailViewController.h"
#import "ShowDetailViewController.h"

@interface ChooseShowDetailViewController ()

@end

@implementation ChooseShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initMianView];
}
-(void)initMianView
{
    NSArray *iconArray = [NSArray arrayWithObjects:@"icon_booldP",@"icon_booldS",@"icon_booldO", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"血压记录",@"血糖记录",@"血氧记录", nil];
    
    for (int i  = 0; i < titleArray.count; i++) {
        
        float btnwidth = MainScreenWidth/3;
        float btnHeight = 110;
        float btnX = (i%3)*(btnwidth);
        float btnY =floor(i/3)*(btnHeight)+64;//加了一个顶部高度
        
        IconNameView *view = [[IconNameView alloc] initWithFrame:CGRectMake(btnX, btnY, btnwidth, btnHeight)];
        view.iconImg.image = [UIImage imageNamed:iconArray[i]];
        view.nameLabel.text = titleArray[i];
        view.nameLabel.textColor = [UIColor blackColor];
        view.tag = i+1000;
        //        view.backgroundColor = [UIColor whiteColor];
        [view addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:view];
    }
}
-(void)viewClick:(UIImageView *)view
{
    NSInteger tag = view.tag;
    switch (tag) {
        case 1000:
        {
            NSLog(@"血压");
            ShowDetailViewController *view = [[ShowDetailViewController alloc]init];
            view.titleStr = @"血压记录";
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1001:
        {
            NSLog(@"血糖");
            ShowDetailViewController *view = [[ShowDetailViewController alloc]init];
            view.titleStr = @"血糖记录";
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1002:
        {
            NSLog(@"血氧");
            ShowDetailViewController *view = [[ShowDetailViewController alloc]init];
            view.titleStr = @"血氧记录";
            [self.navigationController pushViewController:view animated:YES];
            
        }
            break;
        default:
            break;
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
