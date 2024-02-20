# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'Briefing' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings! 
  
  # Pods for Briefing
  pod 'SnapKit', '~> 5.0.0'
  pod 'RxSwift', '6.6.0'
  pod 'RxCocoa', '6.6.0'
  pod 'Alamofire', '~> 5.0.0'
  pod 'GoogleSignIn'
  pod 'FirebaseAnalytics'
  pod 'FirebaseCrashlytics'
  pod 'Google-Mobile-Ads-SDK'
  pod 'Firebase/Messaging'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
end
