Pod::Spec.new do |s|
  s.name         = 'QDownload'
  s.version      = '1.0.0'
  s.license      = 'MIT'
  s.authors      = {'QianChia' => 'jhqian0228@icloud.com'}
  s.summary      = 'A simple encapsulation of files to download'
  s.homepage     = 'https://github.com/QianChia/QDownload'
  s.source       = {:git => 'https://github.com/QianChia/QDownload.git', :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.source_files        = 'QDownload/QDownload.h'
  s.public_header_files = 'QDownload/QDownload.h'

  s.subspec 'QReachability' do |ss|
    ss.source_files        = 'QDownload/QReachability/QReachability.{h,m}'
    ss.public_header_files = 'QDownload/QReachability/QReachability.h'

    ss.subspec 'Reachability' do |sss|
      sss.source_files        = 'QDownload/QReachability/Reachability/Reachability.{h,m}'
      sss.public_header_files = 'QDownload/QReachability/Reachability/Reachability.h'
    end
  end

  s.subspec 'QWebImage' do |ss|
    ss.source_files        = 'QDownload/QWebImage/**'
    ss.public_header_files = 'QDownload/QWebImage/QWebImage.h'
  end

  s.subspec 'QConnectionDownloader' do |ss|
    ss.source_files        = 'QDownload/QConnectionDownloader/**'
    ss.public_header_files = 'QDownload/QConnectionDownloader/QConnectionDownloader.h'
  end

  s.subspec 'QAFNetworking' do |ss|
    ss.source_files        = 'QDownload/QAFNetworking/QAFNetworking.{h,m}'
    ss.public_header_files = 'QDownload/QAFNetworking/QAFNetworking.h'

    ss.subspec 'AFNetworking' do |sss|
      sss.source_files        = 'QDownload/QAFNetworking/AFNetworking/**'
      sss.public_header_files = 'QDownload/QAFNetworking/AFNetworking/AFNetworking.h'
    end

    ss.subspec 'UIKit+AFNetworking' do |sss|
      sss.source_files        = 'QDownload/QAFNetworking/UIKit+AFNetworking/**'
      sss.public_header_files = 'QDownload/QAFNetworking/UIKit+AFNetworking/UIKit+AFNetworking.h'
    end
  end

end
