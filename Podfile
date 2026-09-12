# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LLVod' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for LLVod
  pod 'SwiftUIPager'
  pod "Kingfisher"
  pod "KingfisherWebP"
  pod 'DanmakuKit'
  
  pod 'AnyThinkiOS','6.5.81'
  pod 'AnyThinkMediationAdxSmartdigimktCNAdapter','6.5.77.2.0'
  pod 'AnyThinkMediationBaiduAdapter','10.051.2.2'
  pod 'AnyThinkMediationGDTAdapter','4.15.90.2.1'

  pod 'CryptoSwift', :git => 'https://github.com/krzyzanowskim/CryptoSwift.git'
  
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
