Pod::Spec.new do |s|
  s.name          = 'NWLogging'
  s.version       = '1.2.7'
  s.summary       = 'A minimalistic logging framework for Cocoa.'
  s.homepage      = 'https://github.com/noodlewerk/NWLogging'
  s.license       = { :type => 'BSD', :file => 'LICENSE.txt' }
  s.author        = { 'Leonard van Driel' => 'leonardvandriel@gmail.com' }

  s.platform      = :ios
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.requires_arc  = true
  s.source        = { :git => 'https://github.com/foo4u/NWLogging.git', :tag => s.version.to_s }
  s.source_files  = 'Library/**/*.{h,m,c}'
  s.ios.exclude_files = 'Library/UI/NWLLogViewController.{h,m}'
  s.osx.exclude_files = 'Library/UI/NWLLogViewController.{h,m}'
  s.libraries     = 'z'
end
