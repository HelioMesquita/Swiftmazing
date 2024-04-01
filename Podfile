platform :ios, '14.0'

def unitTestingPods
  pod 'Quick', '7.4.1'
  pod 'Nimble', '12.0.0'
  pod 'Nimble-Snapshots', '9.6.1'
end

target 'Visual' do
  use_frameworks!

  target 'VisualTests' do
    unitTestingPods
  end

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 14
      end
  end
end
