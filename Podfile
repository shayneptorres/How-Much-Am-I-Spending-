# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'How Much Am I Spending' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master’,:submodules => true
  pod 'RealmSwift', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master’,:submodules => true
  pod 'Eureka', '~> 2.0.0-beta.1'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
