//
//  QReachability.h
//  QDownload
//
//  Created by JHQ0228 on 16/7/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

NS_ASSUME_NONNULL_BEGIN


@interface QReachability : NSObject

/**
 *  开始监听网络状态
 *
 *  @param domain        监听的域名，nil 
 *  @param networkStatus 网络状态回调
 */
+ (void)q_startMonitoringForDomain:(nullable NSString *)domain statusChange:(void (^)(NetworkStatus status))networkStatus;

/**
 *  开始监听网络状态
 *
 *  @param address       监听的 IP 地址
 *  @param networkStatus 网络状态回调
 */
+ (void)q_startMonitoringForAddress:(nullable NSString *)address statusChange:(void (^)(NetworkStatus status))networkStatus;

/**
 *  开始监听网络状态
 */
+ (void)q_startMonitoring;

/**
 *  停止监听网络状态
 */
+ (void)q_stopMonitoring;

/**
 *  获取网络是否可用
 *
 *  @return YES 网络可用，NO 网络不可用
 */
+ (BOOL)q_isReachable;

/**
 *  获取 WiFi 网络是否可用
 *
 *  @return YES WiFi 网络可用，NO WiFi 网络不可用
 */
+ (BOOL)q_isReachableViaWiFi;

/**
 *  获取蜂窝网络是否可用
 *
 *  @return YES 蜂窝网络可用，NO 蜂窝网络不可用
 */
+ (BOOL)q_isReachableViaWWAN;

@end


NS_ASSUME_NONNULL_END
