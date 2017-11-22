//
//  WCTTool.h
//  WCT折线图
//
//  Created by four on 16/3/15.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> //需要用到UIKit框架里的文件

#import <CommonCrypto/CommonDigest.h>//MD5加密

#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>//3DES加密

@interface WCTTool : NSObject
#pragma mark -iOS常见加密方法
/**
 一.MD5加密
 MD5加密是最常用的加密方法之一，是从一段字符串中通过相应特征生成一段32位的数字字母混合码。MD5主要特点是 不可逆，相同数据的MD5值肯定一样，不同数据的MD5值不一样（也不是绝对的，但基本是不能一样的）。 MD5算法还具有以下性质： 1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。 2、容易计算：从原数据计算出MD5值很容易。 3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。 4、弱抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。 5、强抗碰撞：想找到两个不同的数据，使它们具有相同的MD5值，是非常困难的
 
 二.HMAC加密
 此加密方法需要先生成密钥，然后再对密码进行MD5和HMAC加密，数据库中需要存放当时使用的密钥和密码加密后的密文 在用户登陆时 再次对填入的密码用密钥进行加密 并且还要加上当前时间（精确到分钟） 再次HMAC加密，服务器里也会拿出以前存放的密文加上时间再次加密。所以就算黑客在中途截取了密码的密文 也在能在1分钟只能破译才能有效，大大加强了安全性。服务器为了考虑到网络的延迟一般会多算一种答案，如23分过来的密码 他会把23分和22分的都算一下和用户匹配只要对上一个就允许登陆。
 
 三.base64加密
 BASE64使用常用的URL密文编码方式，用于在HTTP环境下传递较长的标识信息。采用Base64编码不仅比较简短，同时也具有不可读性。，在MIME格式的电子邮件中，base64可以用来将binary的字节序列数据编码成ASCII字符序列构成的文本。使用时，在传输编码方式中指定base64。使用的字符包括大小写字母各26个，加上10个数字，和加号“+”，斜杠“/”，一共64个字符，等号“=”用来作为后缀用途。
 
 四.对称加密算法
 优点：算法公开、计算量小、加密速度快、加密效率高、可逆 缺点：双方使用相同钥匙，安全性得不到保证 现状：对称加密的速度比公钥加密快很多，在很多场合都需要对称加密， 相较于DES和3DES算法而言，AES算法有着更高的速度和资源使用效率，安全级别也较之更高了，被称为下一代加密标准
 AES加密模式和填充方式：
 算法/模式/填充                16字节加密后数据长度        不满16字节加密后长度
 AES/CBC/NoPadding             16                          不支持
 AES/CBC/PKCS5Padding          32                          16
 AES/CBC/ISO10126Padding       32                          16
 AES/CFB/NoPadding             16                          原始数据长度
 AES/CFB/PKCS5Padding          32                          16
 AES/CFB/ISO10126Padding       32                          16
 AES/ECB/NoPadding             16                          不支持
 AES/ECB/PKCS5Padding          32                          16
 AES/ECB/ISO10126Padding       32                          16
 AES/OFB/NoPadding             16                          原始数据长度
 AES/OFB/PKCS5Padding          32                          16
 AES/OFB/ISO10126Padding       32                          16
 AES/PCBC/NoPadding            16                          不支持
 AES/PCBC/PKCS5Padding         32                          16
 AES/PCBC/ISO10126Padding      32                          16
 
 
 AES有一些设置，你得保证是否一致
 
 1、模式 模式有ECB/CBC等，iOS默认的是CBC
 
 2、Padding iOS默认的是PKCS7 等价于PKCS5
 
 3、初始向量   iv  iOS默认是00000000000
 
 4、keySize   有 128/192/256等。
 
 你得保证这些都是一样的配置才可以。
 
 五.RSA加密
 RSA非对称加密算法 非对称加密算法需要两个密钥：公开密钥（publickey）和私有密钥（privatekey） 公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密 特点： 非对称密码体制的特点：算法强度复杂、安全性依赖于算法与密钥但是由于其算法复杂，而使得加密解密速度没有对称加密解密的速度快 对称密码体制中只有一种密钥，并且是非公开的，如果要解密就得让对方知道密钥。所以保证其安全性就是保证密钥的安全，而非对称密钥体制有两种密钥，其中一个是公开的，这样就可以不需要像对称密码那样传输对方的密钥了。常用场景： 分部要给总部发一段报文，先对报文整个进行MD5得到一个报文摘要，再对这个报文摘要用公钥加密。然后把报文和这个RSA密文一起发过去。 总部接收到报文之后要先确定报文是否在中途被人篡改，就先把这个密文用私钥解密得到报文摘要，再和整个报文MD5一下得到的报文摘要进行对比 如果一样就是没被改过。
 */

#pragma mark - MD5加密(MD5不可逆，所以没有解密方法)
+ (NSString *)md5String:(NSString *)str;


#pragma mark - SHA-256加密（具体参数根据需求而定）
+ (NSString *)SHA256WithUserDate:(NSString *)account andPsd:(NSString *)psd andDateString:(NSString *)dateString;



#pragma mark - 3DES加密（需要用到CTMBase64）
+ (NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey;
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;


#pragma mark - HMAC+MD5加密（需要传入密文，因为用到了MD5，因此不可逆）
+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr;



#pragma mark - ASE128加密(用到了GTMBase64)
//加密
+ (NSString *)AES128EncryptWithKey:(NSString *)plainText;
//解密
+ (NSString *)AES128DecryptWithKey:(NSString *)encryptText;


#pragma mark - 各种获取时间
// 获取当前时间 yyyy-MM-dd
+ (NSString *) getCurrentDateString;

// 获取当前时间 yyyy年MM月dd日
+ (NSString *) getdateStringByFormat:(BOOL)isChinese;

// 获取当前时间 yyyy-MM-dd HH:mm:ss
+ (NSString *) getCurrentDateTimeString;

// 获取当前时间 HH:mm:ss
+ (NSString *) getCurrentTimeString;

// 根据当前的时间获取n个月前的日期
+ (NSString *) getDateStringCurrentBeforeMonths:(NSInteger)numberOfMonth;

// 获取从startDate到当前日期的所有日期字符串
+ (NSMutableArray *) getAllDateStringsFromDateToNow:(NSString *)startString;

// 根据时间，调整格式
+ (NSString *) getDateStringByStrings:(NSString *)string;

// 获取两个时间段的中间值
+ (NSString *) getMiddleDateStringByStart:(NSString *)startDateString End:(NSString *)endDateString;

//获取到上次使用到这次使用的时间间隔
+ (NSString *)getTimeStringFromDateString:(NSString *)dateString;


//十六进制颜色字符串转uicolor
+ (UIColor *) colorWithHexString: (NSString *) hexString;

//消息提示框
+ (void)showAlertMessage:(NSString *)message;

//消息提示框(兼容iOS8以后)
+ (void)showAlertMessage:(NSString *)message cancel:(NSString *)cancal inViewController:(UIViewController *)viewController handler:(void (^)(UIAlertAction *action))handler;



@end
