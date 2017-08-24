#
# Be sure to run `pod lib lint ZJComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJComponents'
  s.version          = '0.1.1'
  s.summary          = 'ZJComponents 包含网络请求组件，常用工具组件，功能性组件开发中'
  s.description      = '满足项目开发大部分需求，刷新，数据存储，json——>model,webIamge load,color... 不定期更新中。。。'
  s.homepage         = 'https://github.com/zhujin001032/ZJComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jason He' => 'zhujin001xb@163.con' }
  s.source           = { :git => 'https://github.com/zhujin001032/ZJComponents.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJComponents.h'
  
  # s.resource_bundles = {
  #   'ZJComponents' => ['ZJComponents/Assets/*.png']
  # }

  s.public_header_files = 'ZJComponents.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  #s.dependency 'AFNetworking', '~>3.1.0'
  
  s.subspec 'HTTPComponent' do |ss|
      ss.source_files = 'HTTPComponent/ZJHTTPManager.{h,m}'
      ss.public_header_files = 'HTTPComponent/ZJHTTPManager.h'
      ss.dependency 'AFNetworking', '~>3.1.0'
      end
  s.subspec 'UtilComponent' do |util|
      util.source_files = 'UtilComponent/**/*.{h,m}'
      util.public_header_files = 'UtilComponent/**/*.h'
      util.resource_bundles = {
         'UtilComponent' =>['UtilComponent/Assets/*.png']
      }
      util.dependency 'SAMKeychain','~> 1.5.2'
      #Refresh
      util.dependency 'MJRefresh'
      #model
      util.dependency 'MJExtension'
      util.dependency 'SVProgressHUD'
      util.dependency 'IQKeyboardManager'
      util.dependency 'LKDBHelper'
      util.dependency 'SDWebImage'
    end

end
