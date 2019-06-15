# coding: utf-8
#
# Be sure to run `pod lib lint EKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EKit'
  s.version          = '2.10.1'
  s.summary          = 'UIKit的扩展集，初版支持在storyboard上给UIView及其子类配置圆角'
  s.description      = <<-DESC
                        UIKit的扩展集，初版支持在storyboard上给UIView及其子类配置圆角, 后续还会添加其他的各种UI组件进来
                       DESC

  s.homepage         = 'https://github.com/lazyjean/EKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lazyjean' => 'lazyjean@foxmail.com' }
  s.source           = { :git => 'https://github.com/lazyjean/EKit.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'EKit/**/*'

  s.frameworks = 'UIKit'
end
