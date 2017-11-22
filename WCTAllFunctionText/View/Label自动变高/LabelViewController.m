//
//  LabelViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "LabelViewController.h"

@interface LabelViewController ()

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = VBK_WC;
    
    UILabel * testlable = [[UILabel alloc]initWithFrame:CGRectMake(10,64,232,20)];
    
    NSString * tstring =@"UILabel  ios7 与ios7之前实现自适应撑高的方法,文本的内容长度不一，我们需要根据内容的多少来自动换行处理。在IOS7下要求font，与breakmode与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrappingUILabel  ios7 与ios7之前实现自适应撑高的方法,文本的内容长度不一，我们需要根据内容的多少来自动换行处理。在IOS7下要求font，与breakmode与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrappingUILabel  ios7 与ios7之前实现自适应撑高的方法,文本的内容长度不一，我们需要根据内容的多少来自动换行处理。在IOS7下要求font，与breakmode与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrappingUILabel  ios7 与ios7之前实现自适应撑高的方法,文本的内容长度不一，我们需要根据内容的多少来自动换行处理。在IOS7下要求font，与breakmode与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrappingUILabel  ios7 与ios7之前实现自适应撑高的方法,文本的内容长度不一，我们需要根据内容的多少来自动换行处理。在IOS7下要求font，与breakmode与之前设置的完全一致sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping";
    
    testlable.numberOfLines = 0;
    
    UIFont * tfont = [UIFont systemFontOfSize:14];
    
    testlable.font = tfont;
    
    testlable.lineBreakMode = NSLineBreakByWordWrapping  ;
    
    testlable.text = tstring ;
    [testlable setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:testlable];
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size =CGSizeMake(self.view.frame.size.width ,3330);
    
    // label可设置的最大高度和宽度
    //    CGSize size = CGSizeMake(300.f, MAXFLOAT);
    
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    // ios7之前使用方法获取文本需要的size，7.0已弃用下面的方法。此方法要求font，与breakmode与之前设置的完全一致
    //    CGSize actualsize = [tstring sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    //   更新UILabel的frame
    
    testlable.frame =CGRectMake(0,64, actualsize.width, actualsize.height);
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
