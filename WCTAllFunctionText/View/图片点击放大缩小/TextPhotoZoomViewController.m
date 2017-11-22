//
//  TextPhotoZoomViewController.m
//  WCTAllFunctionText
//
//  Created by 董嵩 on 16/3/19.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "TextPhotoZoomViewController.h"
#import "WCTPhotoZoom.h"

@interface TextPhotoZoomViewController ()
{
    UIImageView *_imageV;
}
@end

@implementation TextPhotoZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageV.image = [UIImage imageNamed:@"touxiang"];
    /**
     *  开启图片的交互
     */
    _imageV.userInteractionEnabled = YES;
    [self.view addSubview:_imageV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressImage)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [_imageV addGestureRecognizer:tap];
    
    
}

-(void)pressImage
{
    [WCTPhotoZoom showImage:_imageV];
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
