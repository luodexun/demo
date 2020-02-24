//
//  ArkDwnWallet.m
//  SnailGame
//
//  Created by Edison on 2019/10/11.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

#import "ArkDwnWallet.h"

#import "arkCrypto.h"
#import "arkClient.h"
#import "address.h"
#import "excards.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define isTest 0  // 1.测试 0.正式

#define kWallet_unit_to_satoshi_str @"100000000"

@implementation ArkDwnWallet

+ (void)arkWalletConfig {
    Ark::Crypto::Configuration::Network network; // 配置网络
    Ark::Crypto::Configuration::Fee fees; // 配置转账交易手续费
    if (isTest) {
        network.set(Devnet); //设置默认网络为devnet
        fees.set(0, 10000000ul);
    }else{
        network.set(Mainnet); //设置默认网络为mainnet
        fees.set(0, 1000000ul);
    }
}

// 产生钱包
+ (NSArray *)createWallet
{
    Ark::Crypto::Configuration::Network network;
    if (isTest) {
        network.set(Devnet); //设置默认网络为devnet
    }else{
        network.set(Mainnet); //设置默认网络为mainnet
    }
    //产生助记词
    const auto passphrase = Ark::Crypto::Identities::Mnemonic::generate();
    //产生钱包地址
    const uint8_t networkVersion = network.get().version();
    Address address = Address::fromPassphrase(passphrase.c_str(), networkVersion);
    NSString *passphrase_str = [NSString stringWithUTF8String:passphrase.c_str()];
    NSString *address_str = [NSString stringWithUTF8String:address.toString().c_str()];
    return @[address_str, passphrase_str];
}

// 通过助记得词获取钱包地址 老用户使用的
+ (NSString *)getAddressFromPassparse:(NSString *)passparse {
    Ark::Crypto::Configuration::Network network;
    if (isTest) {
        network.set(Devnet); //设置默认网络为devnet
    }else{
        network.set(Mainnet); //设置默认网络为mainnet
    }
    const uint8_t networkVersion = network.get().version();
    const char *passparseChar = [passparse UTF8String];
    Address address = Address::fromPassphrase(passparseChar, networkVersion);
    NSString *address_str = [NSString stringWithUTF8String:address.toString().c_str()];
    return address_str;
}

+ (NSString *)createTransation:(NSString *)walletAddress withIp:(NSString *)ip withSecretKey:(NSString *)secretKey amount:(NSInteger)num vendorField:(NSString *)remarkText
{
    const char *peerChar = [ip UTF8String];
    const char *walletChar = [walletAddress UTF8String];
    Ark::Client::Connection<Ark::Client::Api> connection(peerChar, 4103); // 节点地址
    //产生交易
    const std::string recipientId = walletChar;
    const uint64_t amount = num;
    // 交易的备注  如果有备注传入备注 如果没有备注直接不传
    const std::string vendorField = remarkText.length == 0 ? "" : [remarkText UTF8String];
    // 助记词转 c++字符串
    NSString *passparse = secretKey;
    if (!passparse) {
        return nil;
    }

    const char *passparse_str = [passparse UTF8String];
    const std::string sender_passphrase = passparse_str;
    Transaction transaction = Ark::Crypto::Transactions::Builder::buildTransfer(recipientId, amount, vendorField, sender_passphrase);
    NSString *transaction_str = [NSString stringWithUTF8String:transaction.toJson().c_str()];
    const std::string dwnTransation = transaction.toJson();  // 这一步就错了 转出来还不是整形的

    NSDictionary *dict = [self jsonStringTodictionary:transaction_str];
    NSString *rst_json = @"{";
    if (dict.count) {
        NSArray *keysArr = [dict allKeys];
        for (NSString *key in keysArr) {
            rst_json = [[[[rst_json stringByAppendingString:@"\""] stringByAppendingString:key] stringByAppendingString:@"\""] stringByAppendingString:@":"];
            if ([key isEqualToString:@"amount"] ||
                [key isEqualToString:@"fee"] ||
                [key isEqualToString:@"timestamp"] ||
                [key isEqualToString:@"type"]
                ) {
                // 数量  费用 时间 类型
                rst_json = [[rst_json stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)[dict[key] integerValue]]] stringByAppendingString:@","];;
            }  else {
                rst_json = [[[[rst_json stringByAppendingString:@"\""] stringByAppendingString:dict[key]] stringByAppendingString:@"\""] stringByAppendingString:@","];
            }
        }
        rst_json = [[rst_json substringToIndex:rst_json.length - 1] stringByAppendingString:@"}"];
    } else {
        return @"{}";
    }
    //转账交易上链
    NSString *transactions = [NSString stringWithFormat:@"{\"transactions\":[%@]}",/*transaction_str temp_transations rst_json*/ rst_json];
    std::string jsonTransaction = [transactions UTF8String];
    const auto rsp_transaction = connection.api.transactions.send(jsonTransaction);
    NSString *result = [NSString stringWithUTF8String:rsp_transaction.c_str()];
    return result;
}

+ (void)transationsWithAddress:(NSString *)address withIp:(NSString *)ip withPage:(int)pageNum callback:(void(^)(NSDictionary *result))completeBlock {
    if (!ip) {
        return ;
    }
    const char *peerChar = [ip UTF8String];
    const char *walletChar = [address UTF8String];
    Ark::Client::Connection<Ark::Client::Api> connection(peerChar, 4103);
    const auto str = connection.api.wallets.transactions(walletChar, 80, 1);
    NSString *jsonStr = [NSString stringWithUTF8String:str.c_str()];
    NSDictionary *dict = [self jsonStringTodictionary:jsonStr];
    completeBlock(dict);
}

+ (NSDictionary *)jsonStringTodictionary:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
初始化身份认证sdk
*/
+(int)initializeIdCard
{
    const char *thePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
    int ret = EXCARDS_Init(thePath);
    return ret;
}

+(NSDictionary *)IDCardRecognit:(CVImageBufferRef)imageBuffer withSession:(AVCaptureSession *)session
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    CVBufferRetain(imageBuffer);
    
    
    if (CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
            size_t width= CVPixelBufferGetWidth(imageBuffer);// 1920
            size_t height = CVPixelBufferGetHeight(imageBuffer);// 1080
            
            CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = (CVPlanarPixelBufferInfo_YCbCrBiPlanar *)CVPixelBufferGetBaseAddress(imageBuffer);
            size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
            size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
            unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
            unsigned char* pixelAddress = baseAddress + offset;
            
            static unsigned char *buffer = NULL;
            if (buffer == NULL) {
                buffer = (unsigned char *)malloc(sizeof(unsigned char) * width * height);
            }
            
            memcpy(buffer, pixelAddress, sizeof(unsigned char) * width * height);
            
            unsigned char pResult[1024];
            int ret = EXCARDS_RecoIDCardData(buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
            if (ret <= 0) {
            
            } else {
                // 播放一下“拍照”的声音，模拟拍照
                AudioServicesPlaySystemSound(1108);
                
                if ([session isRunning]) {
                    [session stopRunning];
                }

                char ctype;
                char content[256];
                int xlen;
                int i = 0;
                
                ctype = pResult[i++];
                
                while(i < ret)
                {
                    ctype = pResult[i++];
                    for(xlen = 0; i < ret; ++i)
                    {
                        if(pResult[i] == ' ')
                        {
                            ++i;
                            break;
                        }
                        content[xlen++] = pResult[i];
                    }
                    
                    content[xlen] = 0;
                    
                    if(xlen)
                    {
                        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                        if(ctype == 0x21)
                        {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"num"];
                        } else if(ctype == 0x22) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"name"];
                        } else if(ctype == 0x23) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"gender"];
                        } else if(ctype == 0x24) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"nation"];
                        } else if(ctype == 0x25) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"address"];
                        } else if(ctype == 0x26) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"issue"];
                        } else if(ctype == 0x27) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"valid"];
                        }
                    }
                }
                
                // 读取到身份证信息，实例化出IDInfo对象后，截取身份证的有效区域，获取到图像
                if (dict) {
                    
                    return dict;
                }
            }
            CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        }
        
        CVBufferRelease(imageBuffer);
    
    return nil;
}

/**
身份证背面信息识别
*/
+(NSDictionary *)IDCardBackRecognit:(CVImageBufferRef)imageBuffer withSession:(AVCaptureSession *)session
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    CVBufferRetain(imageBuffer);
        
        // Lock the image buffer
        if (CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess) {
            size_t width= CVPixelBufferGetWidth(imageBuffer);// 1920
            size_t height = CVPixelBufferGetHeight(imageBuffer);// 1080
            
            CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = (CVPlanarPixelBufferInfo_YCbCrBiPlanar *)CVPixelBufferGetBaseAddress(imageBuffer);
            size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
            size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
            unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
            unsigned char* pixelAddress = baseAddress + offset;
            
            static unsigned char *buffer = NULL;
            if (buffer == NULL) {
                buffer = (unsigned char *)malloc(sizeof(unsigned char) * width * height);
            }
            
            memcpy(buffer, pixelAddress, sizeof(unsigned char) * width * height);
            
            unsigned char pResult[1024];
            int ret = EXCARDS_RecoIDCardData(buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
            if (ret <= 0) {
                NSLog(@"ret=[%d]", ret);
            } else {
                NSLog(@"ret=[%d]", ret);
                
                // 播放一下“拍照”的声音，模拟拍照
                AudioServicesPlaySystemSound(1108);
                
                if ([session isRunning]) {
                    [session stopRunning];
                }

                char ctype;
                char content[256];
                int xlen;
                int i = 0;
            
                ctype = pResult[i++];

                while(i < ret){
                    ctype = pResult[i++];
                    for(xlen = 0; i < ret; ++i){
                        if(pResult[i] == ' ') { ++i; break; }
                        content[xlen++] = pResult[i];
                    }
                    
                    content[xlen] = 0;
                    
                    if(xlen) {
                        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                        if(ctype == 0x21) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"num"];
                        } else if(ctype == 0x22) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"name"];
                        } else if(ctype == 0x23) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"gender"];
                        } else if(ctype == 0x24) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"nation"];
                        } else if(ctype == 0x25) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"address"];
                        } else if(ctype == 0x26) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"issue"];
                        } else if(ctype == 0x27) {
                            [dict setValue:[NSString stringWithCString:(char *)content encoding:gbkEncoding] forKey:@"valid"];
                        }
                    }
                }
                
                if (dict) {
                    
                    return dict;
                }
            }
            
            CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        }
        
        CVBufferRelease(imageBuffer);
        return nil;
}

+(void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val  = (int)orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
