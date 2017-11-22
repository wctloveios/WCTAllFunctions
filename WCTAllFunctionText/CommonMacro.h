//
//  CommonMacro.h
//  CancerDoctor
//
//  Created by 123 on 15/7/15.
//  Copyright (c) 2015年 KM. All rights reserved.
//

#ifndef CancerNeighbour_CommonMacro_h
#define CancerNeighbour_CommonMacro_h

//定义屏幕的宽和高
//(导航栏的高度不算里面！！！)
#define MainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define MainScreenHeight ([UIScreen mainScreen].bounds.size.height)

//定义需要显示的文字信息
#define kNotify_Disease_Alert @"您想更新今天的病症吗？"
#define kNotify_Feeling_Alert @"您想更新今天的心情吗？"

#define RequestState_Loading @"加载中..."
#define CurrentNetWorkState_Bad @"操作失败，请重新尝试"
#define NoNetWork_Check @"您还未连上网络，请检查后再操作!"
#define GetInfoMessage @"正在获取信息..."
#define LogInState_Ing @"登录中..."

#define CollectionState_Ing @"正在收藏..."
#define CollectionState_Success @"收藏成功"
#define CollectionState_Failed @"收藏失败"
#define CollectionState_Unable @"您还未登录,不能收藏"
#define CancelCollectionState_Ing @"正在取消收藏..."
#define CancelCollectionState_Success @"取消收藏成功!"
#define CancelCollectionState_Failed @"取消收藏失败!"
#define CancelCollectionState_Unable @"您还未登录,不能取消收藏"

#define GetDepartmentState_Failed @"获取科室列表失败"
#define BundingNoTreatCard @"您还未绑定诊疗卡!"
#define NoReport_HoldOn @"报告未出，请耐心等候!"

#define RegisterState_Ing @"正在挂号..."
#define RegisterState_Success @"挂号成功"
#define RegisterState_Failed @"挂号失败"
#define CancelRegisterState_Ing @"取消挂号..."
#define CancelRegisterState_Success @"取消挂号成功"
#define CancelRegisterState_Failed @"取消挂号失败"

//修改密码文字信息
#define PassWordEmpty @"请输入密码"
#define ChangePwState_Ing @"正在修改密码..."
#define ChangePwState_Success @"修改密码成功"
#define ChangePwState_Failed @"修改密码失败!"
#define ChangePwState_OldPwNotRight @"旧密码不正确"
#define ChangePwState_NotTheSame @"新密码和确认密码不一致"
#define ChangePwState_SurePwNotEmpty @"确认密码不能为空"
#define ChangePwState_NewPwNotEmpty @"新密码不能为空"
#define ChangePwState_OldPwNotEmpty @"原密码不能为空"
#define PassWordNotTheSame @"两次密码不一致"

#define PayState_Success @"支付成功"
#define PayState_Failed @"支付失败"
#define PayState_Cancel @"取消支付"
#define GetPayInfoState_Ing @"正在获取支付信息..."

#define InputRightMobile @"请输入正确的手机号码"
#define InputVerifyCode @"请输入验证码"
#define InputTreatCardNumber @"请输入诊疗卡号"
#define InputPatientName @"请输入就诊人姓名"
#define SendState_Failed @"发送失败"
#define PhoneHaveRegiste @"手机已经注册"
#define PhoneNoRegiste @"手机未注册"
#define RequestTooManyTimes @"请求过于频繁"
#define TreatCardNoMatchPhone @"诊疗卡号与手机号不匹配"
#define BundingState_Failed @"绑定诊疗卡失败"
#define BundingState_Success @"绑定诊疗卡成功"
#define UnbundingState_Ing @"正在解除绑定..."
#define UnbundingState_Failed @"解除绑定失败"
#define UnbundingState_Success @"解除绑定成功"
#define CardNumberWrong @"卡号错误"
#define ReservePhoneNumberWrong @"预留手机号错误"
#define HaveBundingTreatCard @"用户已经绑定该卡"
#define ExpiredVerifyCode @"验证码过期"
#define WrongVerifyCode @"验证码错误"
#define GetVerifyCodeState_Ing @"正在获取验证码..."
#define GetVerifyCodeState_Success @"获取验证码成功"
#define GetVerifyCodeState_Failed @"获取验证码失败"

#define UserExpired_LogInAgain @"用户授权过期，请重新登录"
#define LoadAllData @"数据已加载完毕"
#define RegisteState_Failed @"注册失败"
#define RegisteState_Unlegal @"注册请求不合法"


//定义导航栏的位置(默认状态栏,导航栏在iOS7后均为透明或半透明的,但在程序里设置为不透明)
#define NavTop  20
#define NavDown 64
#define StatusAndNavHeight 64

//定义设备的类型
#define iPad   (([UIScreen mainScreen].currentMode.size.height) == 1024?YES:NO)
#define iPadAir   (([UIScreen mainScreen].currentMode.size.height) == 2048?YES:NO)
#define iPhone4   (([UIScreen mainScreen].currentMode.size.height) == 960?YES:NO)
#define iPhone5   (([UIScreen mainScreen].currentMode.size.height) == 1136?YES:NO)
#define iPhone6   (([UIScreen mainScreen].currentMode.size.height) == 1334?YES:NO)
#define iPhone6p  (([UIScreen mainScreen].currentMode.size.height) == 2208?YES:NO)

//判断设备的软件版本
#define iPhoneSystemVersion ([UIDevice currentDevice].systemVersion.floatValue)

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height-(double)568 ) < DBL_EPSILON)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define IS_IOS8 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8)
#define IS_IOS7 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
#define IS_IOS6 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] == 6)


// 选择和取消选择颜色
#define unselectColor   [UIColor colorWithRed:100.0/255.0  green:100.0/255.0  blue:100.0/255.0 alpha:1.0]
#define selectedColor   [UIColor colorWithRed:255.0/255.0  green:84.0/255.0   blue:27.0/255.0  alpha:1.0]

// 所有按钮的颜色
// 蓝色
#define kAllBtnBgBlueColor [UIColor colorWithRed:23.0/255.0  green:126.0/255.0   blue:245.0/255.0  alpha:1.0]

// 所有字体颜色
// 灰色
#define kBackgroudGrayColor [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1.0]
#define kAllTextGrayColor [UIColor colorWithRed:133.0 / 255 green:138.0 / 255 blue:142.0 / 255 alpha:1.0]
#define kAllCellSepGrayColor [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1.0]


//自定义RGB
#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kFont [UIFont systemFontOfSize:14];
#define VBK_WC [UIColor whiteColor];
#endif
