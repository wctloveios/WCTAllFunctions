//
//  SecretViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "SecretViewController.h"

@interface SecretViewController ()

@end

@implementation SecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self textMD5];
    
    [self textSHA256];
    
    [self text3DES];
    
    [self textHMACAndMD5];
    
    [self textGTMBase64];
    
    [self textASE128];
    
    
    //延迟1000000000纳秒 == 1秒
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    void (^task)() = ^ {
        // 延迟操作执行的代码
        [self showData];
        NSLog(@"%@", [NSThread currentThread]);
    };
    // 经过多少纳秒，由主队列调度任务异步执行
    dispatch_after(when, dispatch_get_main_queue(), task);
    // 先执行就是异步，后执行就是同步
    NSLog(@"come here");
}

-(void)textMD5{
    NSString *str = @"123456789";
    NSString *str2 =[WCTTool md5String:str];
    
    NSLog(@"MD5-16位加密：%@",str2);
}

-(void)textSHA256{
    NSString *str1 = @"123456789";
    NSString *str2 = @"123456789";
    NSString *str3 = [WCTTool getCurrentDateString];
    NSString *str4 = [WCTTool SHA256WithUserDate:str1 andPsd:str2 andDateString:str3];
    
    NSLog(@"SHA-256加密：%@",str4);
}

-(void)text3DES{
    NSString *str1 = @"123456789";
    
    //第一种：需要传入加密还是解密、加密和解密的key
    NSString *str2 = [WCTTool TripleDES:str1 encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:@"wctxhdjh"];
    NSLog(@"3DES加密：%@",str2);
    NSString *str22 = [WCTTool TripleDES:str2 encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:@"wctxhdjh"];
    NSLog(@"3DES解密：%@",str22);
    
    //第二种：加密、已经设置了key，传入文明直接加密
    //第三种：解密、已经设置了解密key、传入密文直接解密
    NSString *str3 = [WCTTool encrypt:str1];
    NSLog(@"3DES只加密：%@",str3);
    NSString *str33 = [WCTTool decrypt:str3];
    NSLog(@"3DES只解密：%@",str33);
}

-(void)textHMACAndMD5{
    NSString *str1 = @"123456789";
    NSString *str11 = [WCTTool getCurrentDateTimeString];
    NSString *str111 = [NSString stringWithFormat:@"%@%@",str1,str11];
    
    /**
     *  第一种：有密钥，有时间，有数据
     *  第二种：有密钥，没时间，有数据
     *  第三种：有密钥，有时间，没数据
     */
    NSString *str2 = [WCTTool HMACMD5WithString:str111 WithKey:@"wctxhdjh"];
    NSLog(@"HMAC+MD5加密：%@",str2);
    NSString *str22 = [WCTTool HMACMD5WithString:str1 WithKey:@"wctxhdjh"];
    NSLog(@"HMAC+MD5加密：%@",str22);
    NSString *str222 = [WCTTool HMACMD5WithString:str11 WithKey:@"wctxhdjh"];
    NSLog(@"HMAC+MD5加密：%@",str222);
}

-(void)textGTMBase64{
    NSData *data = [@"http://www.baidu.com.cn" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    NSLog(@"GTMBase64加密：%@",str);
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str1 = [[NSString alloc]initWithData:[GTMBase64 decodeData:data1] encoding:NSUTF8StringEncoding];
    NSLog(@"GTMBase64解密：%@",str1);
}

-(void)textASE128{
    NSString *str = [WCTTool AES128EncryptWithKey:@"http://www.baidu.com.cn"];
    NSLog(@"ASE128加密：%@",str);
    
    NSString *str1 = [WCTTool AES128DecryptWithKey:str];
    NSLog(@"ASE128解密：%@",str1);
    
    
}

-(void)showData{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"iOS常见加密解密" message:@"具体细节常看代码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [view show];
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
