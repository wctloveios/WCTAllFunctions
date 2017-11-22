//
//  WCTTool.m
//  WCT折线图
//
//  Created by four on 16/3/15.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "WCTTool.h"

//3DES加密解密拼接的数字
#define TripleDESKey    @"wctxhdjh1314"
#define gIv             @"wctxhdjh"
#define kSecondOfOneDay 86400

//ASE128加密解密拼接的数字
#define gkey			@"16位长度的字符串" //自行修改
#define gIv2             @"16位长度的字符串" //自行修改

@implementation WCTTool


#pragma mark - MD5加密(MD5不可逆，所以没有解密方法)
//MD5加密
+ (NSString *)md5String:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]];
}


#pragma mark - SHA-256加密（具体参数根据需求而定）
//SHA-256加密（这里通过账户、密码、本地时间加密,去掉空格、'<'、'>'）
+ (NSString *)SHA256WithUserDate:(NSString *)account andPsd:(NSString *)psd andDateString:(NSString *)dateString;
{
    NSString *tmpstr =[NSString stringWithFormat:@"%@%@%@", account, psd,dateString];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    //不是返回密码，而是加密数据
    psd=[out2 description];
    psd = [psd stringByReplacingOccurrencesOfString:@" " withString:@""];
    psd = [psd stringByReplacingOccurrencesOfString:@"<" withString:@""];
    psd = [psd stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return psd;
}
//获取当前时间
+ (NSString *) getCurrentDateString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}


#pragma mark - 3DES加密（需要用到CTMBase64）
//3DES加密（需要用到CTMBase64）
+ (NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[encryptOrDecryptKey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    /*if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
     else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
     **/
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText {
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [TripleDESKey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText {
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [TripleDESKey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}


#pragma mark - HMAC+MD5加密（需要传入密文）
//HMAC+MD5加密（需要传入密文）
+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr
{
    const char *cKey  = [keyStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [toEncryptStr cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned int keyLen = strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding] autorelease];
    [HMAC release];
    return hash;
}

#pragma mark - ASE128加密(用到了GTMBase64)
//加密
+ (NSString *)AES128EncryptWithKey:(NSString *)plainText{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv2 getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;}
//解密
+ (NSString *)AES128DecryptWithKey:(NSString *)encryptText{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv2 getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding] autorelease];
    }
    free(buffer);
    return nil;
}

+ (NSString *) getdateStringByFormat:(BOOL)isChinese {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (isChinese) {
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *) getCurrentDateTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *) getCurrentTimeString {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *strTime = [formatter stringFromDate:date];
    
    return strTime;
}

+ (NSString *) getDateStringByStrings:(NSString *)string {
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter1 dateFromString:string];
    
    NSString *strTime = [formatter1 stringFromDate:startDate];
    
    return strTime;
}

// 根据当前的时间获取n个月前的日期
+ (NSString *) getDateStringCurrentBeforeMonths:(NSInteger)numberOfMonth {
    NSDate *mydate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0 - numberOfMonth];
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [formatter stringFromDate:newdate];
    
    return strDate;
}

// 获取从startDate到当前日期的所有日期字符串
+ (NSMutableArray *) getAllDateStringsFromDateToNow:(NSString *)startString {
    
    //NSString *strindDate = @"2015-11-05 11:11:11";
    if (startString.length == 10) {
        startString = [startString stringByAppendingString:@" 00:00:00"];
    }
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter1 dateFromString:startString];
    NSTimeInterval startInterval = [startDate timeIntervalSince1970];
    
    NSDate *endDate = [NSDate date];
    NSTimeInterval endInterval = [endDate timeIntervalSince1970];
    
    NSTimeInterval minusInterval = endInterval - startInterval;
    NSInteger nDays = minusInterval / kSecondOfOneDay;
    
    NSMutableArray *aryAllDateStrings = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (NSInteger n = nDays; n >= 0; n--) {
        NSDate *dates = [endDate dateByAddingTimeInterval:(-n + (0 * 7)) * kSecondOfOneDay];
        NSString *dateString = [dateFormatter stringFromDate:dates];
        [aryAllDateStrings addObject:dateString];
    }
    
    return aryAllDateStrings;
}

// 获取两个时间段的中间值
+ (NSString *) getMiddleDateStringByStart:(NSString *)startDateString End:(NSString *)endDateString {
    NSString *middleDateString = @"";
    
    if (startDateString.length == 10) {
        startDateString = [startDateString stringByAppendingString:@" 00:00:00"];
    }
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter1 dateFromString:startDateString];
    NSTimeInterval startInterval = [startDate timeIntervalSince1970];
    
    if (endDateString.length == 10) {
        endDateString = [endDateString stringByAppendingString:@" 00:00:00"];
    }
    NSDate *endDate = [formatter1 dateFromString:endDateString];
    NSTimeInterval endInterval = [endDate timeIntervalSince1970];
    
    NSTimeInterval middleInterval = (startInterval + endInterval) / 2.0;
    
    NSDate *middleDate = [NSDate dateWithTimeIntervalSince1970:middleInterval];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    middleDateString = [formatter2 stringFromDate:middleDate];
    
    return middleDateString;
}

+ (NSString *)getTimeStringFromDateString:(NSString *)dateString {
    NSString *timeString = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [formatter dateFromString:dateString];
    NSTimeInterval sendInterval = [startDate timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSString *strNow = [formatter stringFromDate:nowDate];
    NSDate *nowingDate = [formatter dateFromString:strNow];
    NSTimeInterval nowInterval = [nowingDate timeIntervalSince1970];
    
    NSTimeInterval minusInterval = nowInterval - sendInterval;
    
    if (minusInterval < 60) {
        timeString = @"刚刚...";
    }
    else if (minusInterval >= 60 && minusInterval < 3600) {
        timeString = [NSString stringWithFormat:@"%ld分钟前", (long)minusInterval / 60];
    }
    else if (minusInterval >= 3600 && minusInterval < 86400) {
        timeString = [NSString stringWithFormat:@"%ld小时前", (long)minusInterval / 3600];
    }
    else if (minusInterval >= 86400) {
        timeString = [NSString stringWithFormat:@"%ld天前", (long)minusInterval / 86400];
    }
    
    return timeString;
}


+ (UIColor *) colorWithHexString: (NSString *) hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return [UIColor blackColor];
            //[NSException:@"Invalid color value"format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


+ (void)showAlertMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

+ (void)showAlertMessage:(NSString *)message cancel:(NSString *)cancal inViewController:(UIViewController *)viewController handler:(void (^)(UIAlertAction *action))handler{
    
    if (iPhoneSystemVersion >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
        [alertController addAction:sureAction];
        UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:canleAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:viewController cancelButtonTitle:cancal otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
}


@end
