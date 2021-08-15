Pod::Spec.new do |s|

  s.name = 'NativeUIKit'
  s.version = '1.0.1'
  s.summary = 'Mimicrated views and controls to native Apple appearance.'
  s.homepage = 'https://github.com/ivanvorobei/NativeUIKit'
  s.source = { :git => 'https://github.com/ivanvorobei/NativeUIKit.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { 'Ivan Vorobei' => 'hello@ivanvorobei.by' }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '12.0'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '6.0'

  s.source_files = 'Sources/NativeUIKit/**/*.swift'
  s.dependency 'SparrowKit'

end