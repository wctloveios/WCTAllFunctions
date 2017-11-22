//
//  FromVC.m
//  FormInterfaceArrangement
//
//  Created by four on 16/2/16.
//  Copyright © 2016年 four. All rights reserved.
//

#import "FromVC.h"

//定义屏幕的宽和高
#define MainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define MainScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation FromVC

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
    }
    return self;
}

-(void)showFormWithData:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh
{
    //创建背景view，高度有行和每行的高度决定
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth , line * heigh + 10)];
    [self addSubview:backView];
    
    //通过循环来布局每一个lable
    for (int i=0; i<line + 1  ; i++) {
        for (int j=0; j<arrange + 1; j++) {
            //横线
            if(j<line)
            {
                UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5 + i*30, MainScreenWidth - 20 , 1)];
                line1.backgroundColor = [UIColor grayColor];
                [backView addSubview:line1];
            }
            //竖线(个数根据横线数来的)
            if(i<line)
            {
                UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + j*(MainScreenWidth - 20)/arrange, 5 + i*30, 1 , 30)];
                line2.backgroundColor = [UIColor grayColor];
                [backView addSubview:line2];
            }
        }
    }
    
    //显示lable
    for (int i=0; i<line ; i++) {
        for (int j=0; j<arrange; j++) {
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(j*(MainScreenWidth - 20)/arrange + 10, i*30 + 5, (MainScreenWidth - 20)/arrange, 30)];
            lable.text = array[self.index];
            self.index ++;
            lable.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:lable];
        }
    }
}

-(void)showFormWithData1:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh
{
    //创建背景view，高度有行和每行的高度决定
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth , line * heigh + 10)];
    [self addSubview:backView];
    
    //通过循环来布局每一个lable
    for (int i=0; i<line + 1  ; i++) {
        for (int j=0; j<arrange + 1; j++) {
            //横线
            if(j<line)
            {
                UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5 + i*30, MainScreenWidth - 20 , 1)];
                line1.backgroundColor = [UIColor grayColor];
                [backView addSubview:line1];
            }
            //竖线(个数根据横线数来的)
            if(i<line)
            {
                if (i%2==0 && i!=0) {
                    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5 + i*30, 1 , 30)];
                    line2.backgroundColor = [UIColor grayColor];
                    [backView addSubview:line2];
                    
                    UIImageView *line22 = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth - 10, 5 + i*30, 1 , 30)];
                    line22.backgroundColor = [UIColor grayColor];
                    [backView addSubview:line22];
                }
                else
                {
                    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + j*(MainScreenWidth - 20)/arrange, 5 + i*30, 1 , 30)];
                    line2.backgroundColor = [UIColor grayColor];
                    [backView addSubview:line2];
                }
            }
        }
    }
    
    //显示lable
    for (int i=0; i<line ; i++) {
        for (int j=0; j<arrange; j++) {
            if(i%2==0 && i!=0)
            {
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, i*30 + 5, 40, 30)];
                lable.text = @"备注";
                lable.textAlignment = NSTextAlignmentLeft;
                [backView addSubview:lable];
            }
            else
            {
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(j*(MainScreenWidth - 20)/arrange + 10, i*30 + 5, (MainScreenWidth - 20)/arrange, 30)];
                lable.text = array[self.index];
                self.index ++;
                lable.textAlignment = NSTextAlignmentCenter;
                [backView addSubview:lable];
            }
        }
    }
    
    
}

-(void)showFormWithData2:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh
{
    //创建背景view，高度有行和每行的高度决定
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth , line * heigh + 10)];
    [self addSubview:backView];
    
    //通过循环来布局每一个lable
    for (int i=0; i<line + 1  ; i++) {
        for (int j=0; j<arrange + 1; j++) {
            //横线
            if(j<line)
            {
                UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5 + i*30, MainScreenWidth - 20 , 1)];
                line1.backgroundColor = [UIColor grayColor];
                [backView addSubview:line1];
            }
            //竖线(个数根据横线数来的)
            if(i<line)
            {
                //开头
                UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5 + i*30, 1 , 30)];
                line2.backgroundColor = [UIColor grayColor];
                [backView addSubview:line2];
                
                //最后
                UIImageView *line22 = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth - 10, 5 + i*30, 1 , 30)];
                line22.backgroundColor = [UIColor grayColor];
                [backView addSubview:line22];
                
                //中间
                UIImageView *line222 = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (MainScreenWidth - 20)/arrange, 5 + i*30, 1 , 30)];
                line222.backgroundColor = [UIColor grayColor];
                [backView addSubview:line222];
                
            }
        }
    }
    
    //    //显示lable
    //    for (int i=0; i<line ; i++) {
    //        for (int j=0; j<arrange; j++) {
    //            if(i%2==0 && i!=0)
    //            {
    //                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(20, i*30 + 5, 40, 30)];
    //                lable.text = @"备注";
    //                lable.textAlignment = NSTextAlignmentLeft;
    //                [backView addSubview:lable];
    //            }
    //            else
    //            {
    //                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(j*(MainScreenWidth - 20)/arrange + 10, i*30 + 5, (MainScreenWidth - 20)/arrange, 30)];
    //                lable.text = array[self.index];
    //                self.index ++;
    //                lable.textAlignment = NSTextAlignmentCenter;
    //                [backView addSubview:lable];
    //            }
    //        }
    //    }
    
}


@end
