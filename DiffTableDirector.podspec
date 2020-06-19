#
# Be sure to run `pod lib lint DiffTableDirector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DiffTableDirector'
  s.version          = '1.0.0'
  s.summary          = 'Work with table view via view models. Diff, paginate, show special view when table is empty.'

  s.description      = <<-DESC
'Easy work with table view via view models. Self regestration, pagination, difference between old and new states. Empty state view support.'
                       DESC

  s.homepage         = 'https://github.com/aleksiosdev/DiffTableDirector'
  s.license          = { :type => 'Appache 2.0', :file => 'LICENSE' }
  s.author           = { 'aleksiosdev' => 'aleksios@manychat.com' }
  s.source           = { :git => 'https://github.com/aleksiosdev/DiffTableDirector.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'DiffTableDirector/Classes/**/*'

  s.dependency 'SwiftLint'
  s.dependency 'DeepDiff', '2.3.1'
end
