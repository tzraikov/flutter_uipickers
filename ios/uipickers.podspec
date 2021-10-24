#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint uipickers.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'uipickers'
  s.version          = '0.0.1'
  s.summary          = 'Exposes native iOS UIKit UIDatePicker and SwiftUI Picker controls to Flutter.'
  s.description      = <<-DESC
  Exposes native iOS UIKit UIDatePicker and SwiftUI Picker controls to Flutter.
                       DESC
  s.homepage         = ' https://github.com/tzraikov/flutter_uipickers'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Tsvetan Raykov' => 'tsvetan.raikov@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
