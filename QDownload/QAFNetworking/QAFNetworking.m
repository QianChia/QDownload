//
//  QAFNetworking.m
//  QDownload
//
//  Created by JHQ0228 on 16/7/23.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "QAFNetworking.h"

@implementation QAFNetworking

/// 创建单例类对象

+ (instancetype)sharedNetworkTools {
    static QAFNetworking *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // baseURL 的目的，就是让后续的网络访问直接使用 相对路径即可，baseURL 的路径一定要有 / 结尾
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        tools = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        
        // 修改 解析数据格式 能够接受的内容类型 － 官方推荐的做法，民间做法：直接修改 AFN 的源代码
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                                @"text/json",
                                                                                @"text/javascript",
                                                                                @"text/html",
                                                                                nil];
    });
    return tools;
}

@end
