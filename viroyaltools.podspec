#
# Be sure to run `pod lib lint VIBLEManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViroyalTools'
  s.version          = '1.0.3'
  s.summary          = 'iOS开发的工具类和扩展'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  一些快速进行iOS开发的工具类和扩展
                      DESC

  s.homepage         = 'https://github.com/NJDevTangQi/ViroyalTools'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NJDevTangQi' => '824282017@qq.com' }
  s.source           = { :git => 'https://github.com/NJDevTangQi/ViroyalTools.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'ViroyalTools/VICocoaTools.h'

  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'SSZipArchive'

  s.resource_bundles = {
    'ViroyalTools' => ['ViroyalTools/Resources/*.png', 'ViroyalTools/Resources/*.lproj']
  }

  s.subspec 'Classes' do |ss|
    ss.source_files = 'ViroyalTools/Classes/*.{h,m}'
  end

end
