//
//  ScanningQRCodeViewController.h
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanningQRCodeViewController : UIViewController

//扫描结束回调
@property (nonatomic, copy) void (^didScanedResult)(NSString *scanResult);


@end
