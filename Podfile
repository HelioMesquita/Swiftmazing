platform :ios, '14.0'

def unitTestingPods
  pod 'Quick', '7.4.1'
  pod 'Nimble', '12.0.0'
  pod 'Nimble-Snapshots', '9.6.1'
end

def visualPods
  pod 'SDWebImage', '5.19.0'
end

target 'SwiftmazingMock' do
  use_frameworks!
  visualPods

  target 'SwiftmazingFunctionalTests' do
    inherit! :search_paths
    pod 'KIF', '3.8.9'
  end

end

target 'Swiftmazing' do
  use_frameworks!
  visualPods

  target 'SwiftmazingTests' do
    inherit! :search_paths
    unitTestingPods
    visualPods
  end

end

target 'Visual' do
  use_frameworks!
  visualPods

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
