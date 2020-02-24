//
//  ArkDwnWallet.h
//  SnailGame
//
//  Created by Edison on 2019/10/11.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

#import <UIKit/UIKit.h>

@interface ArkDwnWallet : NSObject

/**
 初始化配置网络
 */
+ (void)arkWalletConfig;

/**
 产生钱包
 */
+ (NSArray *)createWallet;

/**
 验证钱包
 */
+ (NSString *)getAddressFromPassparse:(NSString *)passparse;

/**
 产生交易

 @param walletAddress 钱包地址
 @param ip ip
 @param secretKey 密钥
 @param num 数量
 @param remarkText 备注
 @return 交易信息
 */
+ (NSString *)createTransation:(NSString *)walletAddress withIp:(NSString *)ip withSecretKey:(NSString *)secretKey amount:(NSInteger)num vendorField:(NSString *)remarkText;


/**
 交易记录
 */
+ (void)transationsWithAddress:(NSString *)address withIp:(NSString *)ip withPage:(int)pageNum callback:(void(^)(NSDictionary *result))completeBlock;

/**
初始化身份认证sdk
*/
+(int)initializeIdCard;

/**
身份证信息识别
*/
+(NSDictionary *)IDCardRecognit:(CVImageBufferRef)imageBuffer withSession:(AVCaptureSession *)session;

/**
身份证背面信息识别
*/
+(NSDictionary *)IDCardBackRecognit:(CVImageBufferRef)imageBuffer withSession:(AVCaptureSession *)session;

/**
强制横竖屏
*/
+(void)interfaceOrientation:(UIInterfaceOrientation)orientation;

@end
