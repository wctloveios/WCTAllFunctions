//
//  ScanCodeViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ScanCodeViewController.h"

#define kScanLineHeight 13.0
static SystemSoundID twodimensioncode_sound_id = 0;

@interface ScanCodeViewController ()
<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView * imageView;
}

@property (strong, nonatomic)AVCaptureDevice *device;
@property (strong, nonatomic)AVCaptureDeviceInput *input;
@property (strong, nonatomic)AVCaptureMetadataOutput *output;
@property (strong, nonatomic)AVCaptureSession *session;
@property (strong, nonatomic)AVCaptureVideoPreviewLayer *preview;

@end

@implementation ScanCodeViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_session) {
        // Start
        [_session startRunning];
        [timer fire];
    }else{
        [self setupCamera];
        // Start
        [_session startRunning];
        [timer fire];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Start
    [_session stopRunning];
    [timer invalidate];
}

#pragma makr - 此页面禁掉左滑返回上级功能
- (BOOL)fd_interactivePopDisabled {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    upOrdown = NO;
    num =0;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(_line.frame.origin.x, imageView.frame.origin.y + 2 * num, _line.frame.size.width, _line.frame.size.height);
        if (2 * num == 222) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(_line.frame.origin.x, imageView.frame.origin.y + 2 * num, _line.frame.size.width, _line.frame.size.height);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

- (void)setupCamera
{
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    
    [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // Preview
    _preview =[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0, 0, MainScreenWidth, self.view.frame.size.height);
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    UIView * maskView = [[UIButton alloc] init];
    [maskView setFrame:CGRectMake(0, 0, MainScreenWidth, self.view.frame.size.height)];
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self.view addSubview:maskView];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:maskView.frame];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake((MainScreenWidth - 228) / 2, 110, 228, 228)
                                                 cornerRadius:0] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [maskView.layer setMask:shapeLayer];
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    CGSize size = self.view.bounds.size;
    CGRect cropRect = CGRectMake((MainScreenWidth - 228) / 2, 110, 228, 228);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        _output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                            cropRect.origin.x/size.width,
                                            cropRect.size.height/fixHeight,
                                            cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                            (cropRect.origin.x + fixPadding)/fixWidth,
                                            cropRect.size.height/size.height,
                                            cropRect.size.width/fixWidth);
    }
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((MainScreenWidth - 228) / 2, 110, 228, 228)];
    imageView.image = [UIImage imageNamed:@"twodimen_scan"];
    imageView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.7].CGColor;
    imageView.layer.borderWidth = 0.5;
    [self.view addSubview:imageView];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 10, MainScreenWidth, 20)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.font = [UIFont systemFontOfSize:12];
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text = @"将二维码图像置于框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 6)];
    _line.image = [UIImage imageNamed:@"twodimen_scanline"];
    [self.view addSubview:_line];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self playSound];
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    [timer invalidate];
    
    if (stringValue.length > 0) {
        [self.view makeToast:@"扫描成功" duration:2.0 position:@"center"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描内容" message:stringValue delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1000;
        [alert show];
    }else{
        [self.view makeToast:@"扫描失败" duration:2.0 position:@"center"];
    }
    
    NSLog(@"%@",stringValue);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [_session startRunning];
        [timer fire];
    }
    
}

#pragma mark - 播放声音
- (void) playSound {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"twodimen" ofType:@"wav"];
    if (filePath) {
        // 注册到声音系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:filePath], &twodimensioncode_sound_id);
        AudioServicesPlaySystemSound(twodimensioncode_sound_id);
    }
    
}

- (void) dealloc {
    
}
@end
