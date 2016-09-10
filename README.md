![Logo](https://avatars3.githubusercontent.com/u/13508076?v=3&s=460)
# QDownload

- A simple encapsulation of files to download.

GitHub：[QianChia](https://github.com/QianChia) ｜ Blog：[QianChia(Chinese)](http://www.cnblogs.com/QianChia)

---
## Installation

### From CocoaPods

- `pod 'QDownload'`

### Manually
- Drag all source files under floder `QDownload ` to your project.
- Import the main header file：`#import "QDownload.h"`

---
## Examples

### QReachability

* QReachability methods

	```objc
		
		// 开始监听网络状态
		
		+ (void)q_startMonitoringForDomain:(nullable NSString *)domain 
		                      statusChange:(void (^)(NetworkStatus status))networkStatus;
		
		+ (void)q_startMonitoringForAddress:(nullable NSString *)address 
		                       statusChange:(void (^)(NetworkStatus status))networkStatus;

		// 开始监听网络状态
		+ (void)q_startMonitoring;

		// 停止监听网络状态
		+ (void)q_stopMonitoring;

		// 获取网络是否可用
		+ (BOOL)q_isReachable;

		// 获取 WiFi 网络是否可用
		+ (BOOL)q_isReachableViaWiFi;

		// 获取蜂窝网络是否可用
		+ (BOOL)q_isReachableViaWWAN;
		
	```

* The use of QReachability
	
	```objc
		
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
		}];
	    
	```
	
	```objc
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
	```
	
	```objc
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
    ```
	
	```objc
	
		// 获取网络是否可用
		BOOL isReachable = [QReachability q_isReachable];
	    
		// 获取 WiFi 网络是否可用
		BOOL isReachableViaWiFi = [QReachability q_isReachableViaWiFi];
	    
		// 获取蜂窝网络是否可用
		BOOL isReachableViaWWAN = [QReachability q_isReachableViaWWAN];
	
	```
	
	```objc
		
    	// 开始监听网络状态
    	[QReachability q_startMonitoring];
    
    	// 停止监听网络状态
    	[QReachability q_stopMonitoring];
        
	```

### QWebImage

* QWebImage methods
	
	```objc
		
		// 设置 Web 图像
		- (void)q_setWebImageWithURLStr:(NSString *)urlStr;
	
	```

* The use of QWebImage
	
	```objc
		
		// 设置网络图片
		[cell.imageView q_setWebImageWithURLStr:dataModel.icon];
	    
	```

### QConnectionDownloader

* QConnectionDownloader methods

	```objc
		
	 	// 创建单例类对象
		+ (instancetype)defaultDownloader;

		// 创建下载
		- (void)q_downloadWithURL:(NSURL *)url
		                 progress:(void (^)(float progress))progress
		                successed:(void (^)(NSString *targetPath))successed
		                   failed:(void (^)(NSError *error))failed;

		// 暂停下载
		- (void)q_pauseWithURL:(NSURL *)url;

		// 取消下载
		- (void)q_cancelWithURL:(NSURL *)url;
		
	```

* The use of QConnectionDownloader

	```objc
		
		// 开始下载

		[[QConnectionDownloader defaultDownloader] q_downloadWithURL:url progress:^(float progress) {
    
    		dispatch_async(dispatch_get_main_queue(), ^{
        		[button q_setButtonWithProgress:progress lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
    		});
    
		} successed:^(NSString *targetPath) {
    
    		NSLog(@"文件下载成功：%@", targetPath);
    
		} failed:^(NSError *error) {
    
    		NSLog(@"文件下载失败：%@", error);
		}];

		// 暂停下载

    	[[QConnectionDownloader defaultDownloader] q_pauseWithURL:url];

		// 取消下载

    	[[QConnectionDownloader defaultDownloader] q_cancelWithURL:url];
    	
	```

### QAFNetworking

* QAFNetworking methods

	```objc
	 
	 	// 创建单例类对象
		+ (instancetype)sharedNetworkTools;
	
	```

* The use of QAFNetworking

	```objc
	
    	// AFNetworking 数据请求
    
    	NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video?type=JSON";
    	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    	[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        	if (error == nil && responseObject != nil) {
            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
        	} else {
            	NSLog(@"failure: %@", error);
        	}
    	}] resume];
	
	```

	```objc
	
    	// QAFNetworking 封装
    
    	NSString *urlStr = @"http://192.168.88.200:8080/MJServer/video?type=JSON";
    
    	[[QAFNetworking sharedNetworkTools] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        	if (responseObject != nil) {
            	NSLog(@"success: %@ --- %@", responseObject, [responseObject class]);
        	}
        
    	} failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        	NSLog(@"failure: %@", error);
    	}];
	
	```

