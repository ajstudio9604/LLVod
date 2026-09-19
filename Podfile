# 与工程的最低部署版本保持一致，避免 CocoaPods 自动推断并告警
platform :ios, '15.0'

target 'LLVod' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for LLVod
  # 影视业务移除后，源码不再引用任何第三方库，仅保留 Debug 下的视图调试工具
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
