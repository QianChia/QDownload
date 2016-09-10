//
//  ViewController.m
//  QDownloadExample
//
//  Created by JHQ0228 on 16/9/10.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"
#import "AppInfoModel.h"


#import "QDownload.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, strong) UILabel *netTitleLabel;
@property (nonatomic, strong) UIImageView *netStatusImageView;
@property (nonatomic, strong) UILabel *netStatusLabel;
@property (nonatomic, strong) UILabel *netIsReachableLabel;
@property (nonatomic, strong) UILabel *netIsReachableViaWiFiLabel;
@property (nonatomic, strong) UILabel *netIsReachableViaWWANLabel;
@property (nonatomic, strong) UIButton *controlBtn;

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *goonBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *progressBtn;
@property (nonatomic, strong) NSURL *url;

@end

@implementation ViewController


/*******************************************************************************/


/// QReachability


- (void)QReachabilityDemo1 {
    
    // 开始监听网络状态
    [QReachability q_startMonitoringForDomain:nil statusChange:^(NetworkStatus status) {
        
        NSString *statusString = @"";
        UIImage *image = nil;
        
        switch (status) {
                
            case NotReachable: {
                statusString = @"Access Not Available";
                image = [UIImage imageNamed:@"stop-32.png"] ;
                break;
            }
            case ReachableViaWWAN: {
                statusString = @"Reachable WWAN";
                image = [UIImage imageNamed:@"WWAN5.png"];
                break;
            }
            case ReachableViaWiFi: {
                statusString = @"Reachable WiFi";
                image = [UIImage imageNamed:@"Airport.png"];
                break;
            }
        }
        self.netStatusLabel.text = statusString;
        self.netStatusImageView.image = image;
        
        // 获取网络是否可用
        BOOL isReachable = [QReachability q_isReachable];
        self.netIsReachableLabel.text = [NSString stringWithFormat:@"isReachable: %zi", isReachable];
        
        // 获取 WiFi 网络是否可用
        BOOL isReachableViaWiFi = [QReachability q_isReachableViaWiFi];
        self.netIsReachableViaWiFiLabel.text = [NSString stringWithFormat:@"isReachableViaWiFi: %zi", isReachableViaWiFi];
        
        // 获取蜂窝网络是否可用
        BOOL isReachableViaWWAN = [QReachability q_isReachableViaWWAN];
        self.netIsReachableViaWWANLabel.text = [NSString stringWithFormat:@"isReachableViaWWAN: %zi", isReachableViaWWAN];
    }];
    
    self.netTitleLabel.text = @"监听当前网络链接状";
}

- (void)QReachabilityDemo2 {
    
    // 域名
    NSString *hostName = @"www.apple.com";
    
    // 开始监听网络状态
    [QReachability q_startMonitoringForDomain:hostName statusChange:^(NetworkStatus status) {
        
        NSString *statusString = @"";
        UIImage *image = nil;
        
        switch (status) {
                
            case NotReachable: {
                statusString = @"Access Not Available";
                image = [UIImage imageNamed:@"stop-32.png"] ;
                break;
            }
            case ReachableViaWWAN: {
                statusString = @"Reachable WWAN";
                image = [UIImage imageNamed:@"WWAN5.png"];
                break;
            }
            case ReachableViaWiFi: {
                statusString = @"Reachable WiFi";
                image = [UIImage imageNamed:@"Airport.png"];
                break;
            }
        }
        self.netStatusLabel.text = statusString;
        self.netStatusImageView.image = image;
    }];
    
    self.netTitleLabel.text = [NSString stringWithFormat:@"Remote Host: %@", hostName];
}

- (void)QReachabilityDemo3 {
    
    // IP 地址
    NSString *hostAddress = @"202.108.22.5";
    
    // 开始监听网络状态
    [QReachability q_startMonitoringForAddress:hostAddress statusChange:^(NetworkStatus status) {
        
        NSString *statusString = @"";
        UIImage *image = nil;
        
        switch (status) {
                
            case NotReachable: {
                statusString = @"Access Not Available";
                image = [UIImage imageNamed:@"stop-32.png"] ;
                break;
            }
            case ReachableViaWWAN: {
                statusString = @"Reachable WWAN";
                image = [UIImage imageNamed:@"WWAN5.png"];
                break;
            }
            case ReachableViaWiFi: {
                statusString = @"Reachable WiFi";
                image = [UIImage imageNamed:@"Airport.png"];
                break;
            }
        }
        self.netStatusLabel.text = statusString;
        self.netStatusImageView.image = image;
    }];
    
    self.netTitleLabel.text = [NSString stringWithFormat:@"Remote Host: %@", hostAddress];
}

- (void)controlStatus {
    
    self.controlBtn.selected = !self.controlBtn.selected;
    
    if (self.controlBtn.selected) {
        
        // 停止监听网络状态
        [QReachability q_stopMonitoring];
        
        [self.controlBtn setTitle:@"start" forState:UIControlStateNormal];
        self.controlBtn.backgroundColor = [UIColor redColor];
    } else {
        
        // 开始监听网络状态
        [QReachability q_startMonitoring];
        
        [self.controlBtn setTitle:@"stop" forState:UIControlStateNormal];
        self.controlBtn.backgroundColor = [UIColor greenColor];
    }
}

- (UILabel *)netTitleLabel {
    if (_netTitleLabel == nil) {
        _netTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.view.bounds.size.width - 40, 30)];
        [self.view addSubview:_netTitleLabel];
    }
    
    self.controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.controlBtn.frame = CGRectMake(20, self.view.bounds.size.height - 100, 100, 50);
    [self.controlBtn setTitle:@"stop" forState:UIControlStateNormal];
    [self.controlBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.controlBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    self.controlBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.controlBtn.backgroundColor = [UIColor greenColor];
    [self.controlBtn addTarget:self action:@selector(controlStatus) forControlEvents:UIControlEventTouchUpInside];
    self.controlBtn.selected = NO;
    [self.view addSubview:self.controlBtn];
    
    return _netTitleLabel;
}

- (UIImageView *)netStatusImageView {
    if (_netStatusImageView == nil) {
        _netStatusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 60, 60)];
        [self.view addSubview:_netStatusImageView];
    }
    return _netStatusImageView;
}

- (UILabel *)netStatusLabel {
    if (_netStatusLabel == nil) {
        _netStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, self.view.bounds.size.width - 40, 30)];
        [self.view addSubview:_netStatusLabel];
    }
    return _netStatusLabel;
}

- (UILabel *)netIsReachableLabel {
    if (_netIsReachableLabel == nil) {
        _netIsReachableLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, self.view.bounds.size.width - 40, 30)];
        [self.view addSubview:_netIsReachableLabel];
    }
    return _netIsReachableLabel;
}

- (UILabel *)netIsReachableViaWiFiLabel {
    if (_netIsReachableViaWiFiLabel == nil) {
        _netIsReachableViaWiFiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, self.view.bounds.size.width - 40, 30)];
        [self.view addSubview:_netIsReachableViaWiFiLabel];
    }
    return _netIsReachableViaWiFiLabel;
}

- (UILabel *)netIsReachableViaWWANLabel {
    if (_netIsReachableViaWWANLabel == nil) {
        _netIsReachableViaWWANLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 350, self.view.bounds.size.width - 40, 30)];
        [self.view addSubview:_netIsReachableViaWWANLabel];
    }
    return _netIsReachableViaWWANLabel;
}


/*******************************************************************************/


/// QWebImage


- (void)QWebImageDemo {
    
    CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    UITableView *myTableView = [[UITableView alloc] initWithFrame:frame];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
}

- (NSArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = [AppInfoModel loadPList];
    }
    return _dataSourceArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AppCell"];
    }
    
    AppInfoModel *dataModel = self.dataSourceArray[indexPath.row];
    
    cell.textLabel.text = dataModel.name;
    cell.detailTextLabel.text = dataModel.download;
    
    // 设置网络图片
    [cell.imageView q_setWebImageWithURLStr:dataModel.icon];
    
    return cell;
}


/*******************************************************************************/


/// QSessionDownloader


/// 开始下载

- (void)startDownloadWithURL:(NSURL *)url button:(UIButton *)button {
    
    [[QSessionDownloader defaultDownloader] q_downloadWithURL:url progress:^(float progress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [button q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
        });
        
    } successed:^(NSString *targetPath) {
        
        NSLog(@"文件下载成功：%@", targetPath);
        
    } failed:^(NSError *error) {
        
        if ([error.userInfo[NSLocalizedDescriptionKey] isEqualToString:@"pauseDownload"]) {
            
            NSLog(@"暂停下载");
            
        } else if ([error.userInfo[NSLocalizedDescriptionKey] isEqualToString:@"cancelDownload"]) {
            
            NSLog(@"取消下载");
            
        } else {
            
            NSLog(@"文件下载失败：%@", error.userInfo[NSLocalizedDescriptionKey]);
        }
    }];
}

/// 暂停下载

- (void)pauseDownloadWithURL:(NSURL *)url {
    
    [[QSessionDownloader defaultDownloader] q_pauseWithURL:url];
}

/// 取消下载

- (void)cancelDownloadWithURL:(NSURL *)url button:(UIButton *)button {
    
    [[QSessionDownloader defaultDownloader] q_cancelWithURL:url];
    
    [button q_setButtonWithProgress:0 lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
}

- (void)QSessionDownloadDemo {
    
    self.startBtn = [self createdButtonWithTitle:@"start" frame:CGRectMake(20, 40, 80, 80) action:@selector(start:)];
    self.goonBtn = [self createdButtonWithTitle:@"goon" frame:CGRectMake(20, 150, 70, 30) action:@selector(goon)];
    self.pauseBtn = [self createdButtonWithTitle:@"pause" frame:CGRectMake(110, 150, 70, 30) action:@selector(pause)];
    self.cancelBtn = [self createdButtonWithTitle:@"cancel" frame:CGRectMake(200, 150, 70, 30) action:@selector(cancel)];
}

- (void)start:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];
    
    self.url = url;
    self.progressBtn = sender;
    
    [self startDownloadWithURL:url button:sender];
}

- (void)goon {
    [self startDownloadWithURL:self.url button:self.progressBtn];
}

- (void)pause {
    [self pauseDownloadWithURL:self.url];
}

- (void)cancel {
    [self cancelDownloadWithURL:self.url button:self.progressBtn];
}

- (UIButton *)createdButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}


/*******************************************************************************/


/// QAFNetworking


- (void)QAFNetworkingDemo1 {

    // AFNetworking 数据请求
    
    NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video?type=JSON";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error == nil && responseObject != nil) {
            NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
        } else {
            NSLog(@"failure: %@", error);
        }
    }] resume];
}

- (void)QAFNetworkingDemo2 {
    
    // QAFNetworking 封装
    
    NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video?type=JSON";
    
    [[QAFNetworking sharedNetworkTools] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject != nil) {
            NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure: %@", error);
    }];
}


/*******************************************************************************/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self QWebImageDemo];
    
//    [self QReachabilityDemo1];
    
//    [self QReachabilityDemo2];
    
//    [self QReachabilityDemo3];
    
    [self QSessionDownloadDemo];
    
//    [self QAFNetworkingDemo1];
    
//    [self QAFNetworkingDemo2];
}

@end
