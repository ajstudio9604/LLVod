# 与工程的最低部署版本保持一致，避免 CocoaPods 自动推断并告警
platform :ios, '15.0'

target 'AmbientFocus' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # 专注时钟业务为纯原生实现，已清理所有冗余的视频、弹幕及广告SDK
  pod 'LookinServer', :configurations => ['Debug']


  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
  end
end
