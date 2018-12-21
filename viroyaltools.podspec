Pod::Spec.new do |s|
s.name             = "viroyaltools"
s.version          = "1.0.1"
s.summary          = "Some Tools."
s.description      = "Some Tools For Develop."
s.homepage         = "https://github.com/MJTangQi/ViroyalTools"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "tangqi" => "tagnqi@viroyal.cn" }
s.source           = { :git => "https://github.com/MJTangQi/ViroyalTools.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/'
s.platform     = :ios, '9.0'
s.requires_arc = true
s.source_files = ''
s.source_files = 'ViroyalTools/Classes/*.{h,m}'
s.resource_bundles = {
# 'viroyaltools' => ['ViroyalTools/Assets/*.png']
}
# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking'
end
