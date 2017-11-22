//
//  WebViewViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "WebViewViewController.h"

#define kFirstHtml @"<p>健康的继续是营养，营养的继续是生命。不论男女老幼，皆为生而食，为了延续生命现象，必须摄取有益于身体 健康的食物。 现代医学研究表明，人体所需的营养素不下百种，其中一些可由自身合成、制造，但无法自身合成、制造必须有外界摄取的约有40余种，精细分后，可概括七大营 养素：</p><p>蛋白质</p><p>蛋白质是一切生命的基础，在体内不断的合成与分解，是构成、更新、修补组织和细胞的重要成分，它参与物质代谢及生理功能的调控,保证机体的生长、发育、繁殖,遗传并供给能量。肉、蛋、奶、鱼、豆是提供蛋白质的主要营养素。</p><p>脂肪</p><p>脂肪是能量的来源之一，它协助脂溶性维生素（A、D、E、K和胡萝卜素）的吸收，保护和固定内脏，防止热量消失，保持体温。油脂是提供脂肪的主要营养素。</p><p>维生素</p><p>维生素是维持人体健康所必须的物质，需要量随少，但由于体内不能合成或合成量不足，必须从食物中摄去。维生素水溶性（维生素B族、维生素C）和脂溶性（维生素A、D、E、K等）两类。它们对人体正常生长发育和调节生理功能至关重要。蔬菜、水果是提供维生素的主要营养素。</p><p>糖类</p><p>糖类是人体的主要能源物质，人体所需要的能量的70%以上由糖类供给。它也是组织和细胞的重要组成成分。五谷类是提供糖类的主要营养素。</p><p>矿物质</p><p>矿物质是骨骼、牙齿和其他组织的重要成分，能活化荷尔蒙及维持主要硣素系统，具有十分重要的生理机能调节作用。蔬菜、水果是提供矿物质的主要营养素。</p><p>水</p><p>水是人体内体液的主要成分，是维持生命所必须的，约占体重的60%，具有调节体温、运输物质、促进体内化学反应和润滑的作用。水的来源主要由我们每天所引用的水，以维持体内所需。</p><p>膳食纤维</p><p>膳食纤维是指植物中不能被消化吸收的成分，是维持健康不可缺少的因素，它能软化肠内物质，刺激胃壁蠕动，辅助排便。并降低血液中胆固醇及葡萄糖的吸收。</p>"

@interface WebViewViewController ()
{
    UIWebView *webView;
}
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    [webView loadHTMLString:kFirstHtml baseURL:nil];
    [self.view addSubview:webView];

    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 20, 40, 40);
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 20;
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
