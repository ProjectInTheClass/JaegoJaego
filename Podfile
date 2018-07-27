source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'proc' do
    pod 'JTAppleCalendar', '~> 7.0'
    pod 'FSCalendar'
	pod 'ABMenuTableViewCell', '~> 2.0'
	pod 'SWTableViewCell', '~> 0.3.7'

 post_install do |installer|

    installer.pods_project.build_configurations.each do |config|

        config.build_settings.delete('CODE_SIGNING_ALLOWED')

        config.build_settings.delete('CODE_SIGNING_REQUIRED')

    end

end

end
