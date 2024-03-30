platform :ios, '13.0'

def unitTestingPods
  pod 'Quick', '7.4.1'
  pod 'Nimble', '12.0.0'
  pod 'Nimble-Snapshots', '9.6.1'
end

def visualPods
  pod 'SDWebImage', '5.19.0'
end

def infrastructurePods
  pod 'PromiseKit', '8.0.0'
end

# target 'Swiftmazing' do
#   use_frameworks!
#   infrastructurePods
#   visualPods

#   target 'SwiftmazingFunctionalTests' do
#     inherit! :search_paths
#     pod 'KIF', '3.7.8'
#   end

#   target 'SwiftmazingTests' do
#     inherit! :search_paths
#     infrastructurePods
#     visualPods
#     unitTestingPods
#   end

# end

# target 'SwiftmazingMock' do
#   use_frameworks!
#   infrastructurePods
#   visualPods
# end

target 'Visual' do
  use_frameworks!
  visualPods

  target 'VisualTests' do
    unitTestingPods
  end

end

target 'Infrastructure' do
  use_frameworks!
  infrastructurePods

  target 'InfrastructureTests' do
    unitTestingPods
  end

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      end
  end
end
