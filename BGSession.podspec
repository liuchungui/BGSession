Pod::Spec.new do |spec|
  spec.name         = 'BGSession'
  spec.version      = '0.1.0'
  spec.license      = 'MIT'
  spec.summary      = 'BGSession is a lightweight local data storage in one case, it can automatically synchronize their attributes value to NSUserDefaults.'
  spec.homepage     = 'https://github.com/liuchungui/BGSession'
  spec.author       = {'liuchungui' => '404468494@qq.com'}
  spec.source       = { :git => 'https://github.com/liuchungui/BGSession.git', :tag => spec.version }
  spec.source_files = "BGSession/*"
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
end
