//
//  ShowImageWithTitleViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ShowImageWithTitleViewController.h"
#import "ShowParts.h"

@interface ShowImageWithTitleViewController ()
{
    CGPoint rootViewLocation;
    NSInteger _line;         //行
    NSInteger _column;       //列
}
@end

@implementation ShowImageWithTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _line = 30;
    _column = 10;
    
    //尺寸最好用CGFloat，这样更加规范
    CGFloat _widthColumn = MainScreenWidth/_column;
    CGFloat _heightLine = (MainScreenHeight-20)/_line;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, MainScreenWidth, (MainScreenHeight-20))];
    imageV.image = [UIImage imageNamed:@"male_icon_zheng"];
    [self.view addSubview:imageV];
    
    for (int i=0; i<_line; i++) {
        for (int j=0; j<_column; j++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(j*_widthColumn, i*_heightLine + 20, _widthColumn, _heightLine)];
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.2f];
            [self.view addSubview:view];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _widthColumn, _heightLine)];
            label.text = [NSString stringWithFormat:@"%d-%d",i,j];
            label.font = [UIFont systemFontOfSize:5];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
            
        }
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((_widthColumn - _heightLine)/2, 20, _heightLine, _heightLine);
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = _heightLine/2;
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches  anyObject ];
    CGPoint currentTouchPosition = [touch locationInView:self.view];
    //显示点击位置
    NSLog(@"1111---%f-%f",currentTouchPosition.x,currentTouchPosition.y);
    
    //    [WCTCalculatePosition getPositionType:currentTouchPosition];
    NSString *str =  [ShowParts getPositionType:currentTouchPosition andLine:_line andColumn:_column];
    
    //通过alertView显示内容
    [WCTTool showAlertMessage:str];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
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
