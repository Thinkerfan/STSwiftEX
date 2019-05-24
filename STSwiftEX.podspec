Pod::Spec.new do |s|

  s.name             = 'STSwiftEX'
  s.version          = '0.0.3'
  s.summary          = ' Swift Extension kit'
  s.homepage         = 'https://github.com/Thinkerfan/STSwiftEX'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thinkerfan' => '731666148@qq.com' }
  s.source           = { :git => 'https://github.com/Thinkerfan/STSwiftEX.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'STSwiftEX/Classes/**/*'
  s.swift_version = '4.2'  

end
