//
//  QReachability.m
//  QDownload
//
//  Created by JHQ0228 on 16/7/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "QReachability.h"
#import <arpa/inet.h>

NS_ASSUME_NONNULL_BEGIN

@interface QReachability ()

@property (nonatomic) Reachability *internetReachability;

@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, copy) NSString *hostAddress;

@property (nonatomic, copy) void (^networkStatusBlock)(NetworkStatus);

@end

@implementation QReachability

/// 开始监听网络状态

+ (void)q_startMonitoringForDomain:(nullable NSString *)domain statusChange:(void (^)(NetworkStatus))networkStatus {
    
    QReachability *rech = [QReachability sharedManager];
    
    rech.networkStatusBlock = networkStatus;
    rech.hostName = domain;
    
    [rech q_start];
}

+ (void)q_startMonitoringForAddress:(nullable NSString *)address statusChange:(void (^)(NetworkStatus status))networkStatus {
    
    QReachability *rech = [QReachability sharedManager];
    
    rech.networkStatusBlock = networkStatus;
    rech.hostAddress = address;
    
    [rech q_start];
}

- (void)q_start {
    
    if (self.hostName) {
        self.internetReachability = [Reachability reachabilityWithHostName:self.hostName];
        [self.internetReachability startNotifier];
        [self q_updateInterfaceWithReachability:self.internetReachability];
        
        return;
    }
    
    if (self.hostAddress) {
        
        struct sockaddr_in serverAddress;
        serverAddress.sin_family = AF_INET;
        serverAddress.sin_addr.s_addr = inet_addr(self.hostAddress.UTF8String);
        
        self.internetReachability = [Reachability reachabilityWithAddress:(const struct sockaddr *)&serverAddress];
        [self.internetReachability startNotifier];
        [self q_updateInterfaceWithReachability:self.internetReachability];
        
        return;
    }
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self q_updateInterfaceWithReachability:self.internetReachability];
}

/// 开始监听网络状态
+ (void)q_startMonitoring {
    
    QReachability *rech = [QReachability sharedManager];
    
    [rech q_start];
}

/// 停止监听网络状态
+ (void)q_stopMonitoring {
    
    QReachability *rech = [QReachability sharedManager];
    
    [rech.internetReachability stopNotifier];
}

/// 获取网络是否可用
+ (BOOL)q_isReachable {
    
    if ([QReachability currentStatus] == NotReachable) {
        return NO;
    }
    return YES;
}

/// 获取 WiFi 网络是否可用
+ (BOOL)q_isReachableViaWiFi {
    
    if ([QReachability currentStatus] == ReachableViaWiFi) {
        return YES;
    }
    return NO;
}

/// 获取蜂窝网络是否可用
+ (BOOL)q_isReachableViaWWAN {
    
    if ([QReachability currentStatus] == ReachableViaWWAN) {
        return YES;
    }
    return NO;
}

/// 获取当前网络状态
+ (NetworkStatus)currentStatus {
    
    NetworkStatus netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    return netStatus;
}

/// 网络状态改变系统通知响应
- (void)q_reachabilityChanged:(NSNotification *)note {
    
    Reachability* curReach = [note object];
    [self q_updateInterfaceWithReachability:curReach];
}

/// 更新网络状态
- (void)q_updateInterfaceWithReachability:(Reachability *)reachability {
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    if (self.networkStatusBlock) {
        self.networkStatusBlock(netStatus);
    }
}

/// 实例化单例类对象
+ (instancetype)sharedManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/// 注册通知
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(q_reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}

/// 注销通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end

NS_ASSUME_NONNULL_END
