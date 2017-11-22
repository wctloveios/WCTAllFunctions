//
//  TextTimerViewController.m
//  WCTAllFunctionText
//
//  Created by 董嵩 on 16/3/19.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "TextTimerViewController.h"
#import "MZTimerLabel.h"

@interface TextTimerViewController ()<MZTimerLabelDelegate>
{
    MZTimerLabel *labelMZT;
    MZTimerLabel *timer;
    
    CGFloat countTime;
}
@end

@implementation TextTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initZMTlabel1];
    
    [self initZMTlabel2];
    
}


- (void)initZMTlabel1
{
    /**
     自己直接创建一个 计时器
     */
    labelMZT= [[MZTimerLabel alloc]init];
    labelMZT.frame = CGRectMake(50, 80, MainScreenWidth - 100, 50);
    labelMZT.timeLabel.font = [UIFont systemFontOfSize:40];
    labelMZT.timeLabel.textColor = [UIColor redColor];
    labelMZT.delegate = self;
    labelMZT.backgroundColor = [UIColor grayColor];
    //MZTimerLabel的时间格式是：00:00:00 (小时HH:分钟mm:秒ss)
    labelMZT.timeFormat = @"HH:mm:ss";
    labelMZT.text = @"00:00:00";
    labelMZT.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelMZT];
    [labelMZT start];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 150, 100, 30);
    [button setTitle:@"暂停" forState:UIControlStateNormal];
    [button setTitle:@"继续" forState:UIControlStateSelected];
    [button addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(200, 150, 100, 30);
    [button1 setTitle:@"重置" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)initZMTlabel2
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, MainScreenWidth - 100, 50)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:40];
    lable.backgroundColor = [UIColor grayColor];
    lable.textColor = [UIColor whiteColor];
    [self.view addSubview:lable];
    /**
     通过已有的lable来确定位置和大小
     通过类型来设置 计时器还是秒表
     */
    timer = [[MZTimerLabel alloc] initWithLabel:lable andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:100];//初始值
    timer.delegate = self;
    [timer start];
}

- (void)pause:(UIButton *)button
{
    button.selected = !button.selected;
    if (!button.selected) {
        //继续
        [labelMZT start];
        [timer start];
    }
    else
    {
        //暂停
        [labelMZT pause];
        [timer pause];
        NSLog(@"%@",labelMZT.text);
        NSLog(@"%f",countTime);
    }
}

-(void)reset
{
    [labelMZT reset];
    [labelMZT start];
    
    [timer reset];
    [timer reset];
    
}

#pragma mark - MZTimerLabel
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    NSLog(@"倒计时结束");
}
-(void)timerLabel:(MZTimerLabel *)timerlabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType
{
    //记录计时器当前时间
    //    NSLog(@"%f",time);
    countTime = time;
    
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
