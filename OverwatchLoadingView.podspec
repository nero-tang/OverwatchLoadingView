#
# Be sure to run `pod lib lint OverwatchLoadingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OverwatchLoadingView'
  s.version          = '0.1.0'
  s.summary          = 'Overwatch loading indicator in Swift'

  s.description      = <<-DESC
  This project is an implementation of the Overwatch matchmaking loading indicator on iOS.
  
  Overwatch is a registered trademark of Blizzard Entertainment, Inc.
  This project is in no way affiliated or endorsed by Blizzard Entertainment, Inc.
                       DESC

  s.homepage         = 'https://github.com/nero-tang/OverwatchLoadingView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Archangel' => 'nero.tangyufei@gmail.com' }
  s.source           = { :git => 'https://github.com/nero-tang/OverwatchLoadingView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'OverwatchLoadingView/Classes/**/*'
end
