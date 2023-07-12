#
# Be sure to run `pod lib lint ExtensionCollection.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ExtensionCollection'
  s.version          = '0.3.0'
  s.summary          = 'Extension Collections'
  s.homepage         = 'https://github.com/ymjin/ExtensionCollection'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ymjin' => 'somethigjin@gmail.com' }
  s.source           = { :git => 'https://github.com/ymjin/ExtensionCollection.git', :branch => "main" , :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'ExtensionCollection/Classes/**/*'
  s.swift_versions = '5.0'
end
