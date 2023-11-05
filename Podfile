# 请不要遗漏Master仓库。
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'

inhibit_all_warnings!

targetsArray = ['KeysocCodingTest']

targetsArray.each do |t|
    target t do
        
        use_frameworks!
        
        pod 'RxSwift'
        pod 'RxCocoa'
        pod 'Kingfisher'
        pod 'SnapKit'
        pod 'Toast-Swift'
#        pod 'Moya-ObjectMapper/RxSwift'
        pod 'Moya'
        pod "ObjectMapper"
        pod 'MJRefresh'
        pod 'RealmSwift'
        # 网络检测
        # pod 'Reachability'
        # 键盘
        pod 'IQKeyboardManagerSwift'
        #FB 动画库
        pod 'pop'
        end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end

