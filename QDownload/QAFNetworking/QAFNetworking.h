//
//  QAFNetworking.h
//  QDownload
//
//  Created by JHQ0228 on 16/7/23.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//


/// AFNetworking - 3.1.0


#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface QAFNetworking : AFHTTPSessionManager

/**
 *  创建单例类对象
 */
+ (instancetype)sharedNetworkTools;

@end
