//
//  AutoScrollImageImageViewController.m
//  WCTAllFunctionText
//
//  Created by four on 2017/9/27.
//  Copyright © 2017年 王春涛. All rights reserved.
//

#import "AutoScrollImageImageViewController.h"

@interface AutoScrollImageImageViewController ()

@property (nonatomic,strong) UIImageView *maskView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) CGFloat moveCount;
@property (nonatomic,assign) BOOL ismove;

@end

@implementation AutoScrollImageImageViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.ismove) {
        self.ismove = NO;
        self.moveCount = 1;
        [self.timer invalidate];
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset= CGPointMake(0,MainScreenHeight * 4);
        }];
    }else{
        self.ismove = YES;
        [self bgImageViewMove];
    }
    
}

- (void)bgImageViewMove{
    self.timer = [NSTimer timerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0 animations:^{
            self.scrollView.contentOffset= CGPointMake(0,MainScreenHeight * 4 - self.moveCount);
        }completion:^(BOOL finished) {
            self.moveCount++;
            
            //重来
            if (self.scrollView.contentOffset.y == 0) {
                self.moveCount = 0;
            }
            
        }];
        
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.moveCount = 1;
    self.ismove = YES;
    
    self.scrollView =  [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight); // frame中的size指UIScrollView的可视范围
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, MainScreenHeight * 5);
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.scrollView.bounces = NO;
    self.scrollView.scrollsToTop = YES;
    self.scrollView.contentOffset= CGPointMake(0,MainScreenHeight * 4);
    [self.view addSubview:self.scrollView];
    
    // 2.创建UIImageView（图片）
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight * 5);
    [self.scrollView addSubview:imageView];
    
    self.maskView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    self.maskView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.maskView];
    
    
    [self bgImageViewMove];
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
