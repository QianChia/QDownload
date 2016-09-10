Pod::Spec.new do |s|
  s.name         = 'QDownload'
  s.version      = '1.0.1'
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
    ss.source_files        = 'QDownload/QWebImage/*.{h,m}'
    ss.public_header_files = 'QDownload/QWebImage/QWebImage.h'
  end

  s.subspec 'QSessionDownloader' do |ss|
    ss.source_files        = 'QDownload/QSessionDownloader/*.{h,m}'
    ss.public_header_files = 'QDownload/QSessionDownloader/QSessionDownloader.h'
  end

  s.subspec 'QAFNetworking' do |ss|
    ss.source_files        = 'QDownload/QAFNetworking/QAFNetworking.{h,m}'
    ss.public_header_files = 'QDownload/QAFNetworking/QAFNetworking.h'

    ss.subspec 'AFNetworking' do |sss|
      sss.source_files = 'QDownload/QAFNetworking/AFNetworking/*.{h,m}'
    end

    ss.subspec 'UIKit+AFNetworking' do |sss|
      sss.source_files = 'QDownload/QAFNetworking/UIKit+AFNetworking/*.{h,m}'
    end
  end

end
