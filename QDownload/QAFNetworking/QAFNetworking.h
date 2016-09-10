//
//  QAFNetworking.h
//  QDownload
//
//  Created by JHQ0228 on 16/7/23.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//


/// AFNetworking - 2.5.4


#import "AFNetworking/AFNetworking.h"

@interface QAFNetworking : AFHTTPSessionManager

/**
 *  创建单例类对象
 */
+ (instancetype)sharedNetworkTools;

@end
