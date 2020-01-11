platform :ios, '13.0'

use_frameworks!

workspace 'Swiftmazing'

#workaround cocoapods issue #9275
class Pod::Target::BuildSettings::AggregateTargetSettings
    BUILT_PRODUCTS_DIR_VARIABLE = "${BUILT_PRODUCTS_DIR}"

    alias_method :ld_runpath_search_paths_original, :ld_runpath_search_paths

    def ld_runpath_search_paths
        ld_runpath_search_paths_original + custom_ld_paths + [BUILT_PRODUCTS_DIR_VARIABLE]
    end

    def custom_ld_paths
        return [] unless configuration_name == "Debug"
        target.pod_targets.map do |pod|
            BUILT_PRODUCTS_DIR_VARIABLE + "/" + pod.product_basename
        end
    end
end

def unitTestingPods
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
    pod 'Nimble-Snapshots', '8.0.0'
end

def visualPods
    pod 'SDWebImage', '5.4.0'
end

def infrastructurePods
    pod 'PromiseKit', '6.10.0'
end

#######Swiftmazing######
target 'Swiftmazing' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    infrastructurePods
    visualPods 
end

target 'SwiftmazingTests' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    infrastructurePods
    unitTestingPods
end

target 'SwiftmazingMock' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    infrastructurePods
    visualPods
end

target 'SwiftmazingFunctionalTests' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    pod 'KIF', '3.7.8'
end
#########################

######Infrastructure#####
target 'Infrastructure' do
    project 'Infrastructure/Infrastructure.xcodeproj'
    infrastructurePods
end

 target 'InfrastructureTests' do
     project 'Infrastructure/Infrastructure.xcodeproj'
     infrastructurePods
     unitTestingPods
 end
 #########################

##########Visual##########
target 'Visual' do
    project 'Visual/Visual.xcodeproj'
    visualPods
end

 target 'VisualTests' do
     project 'Visual/Visual.xcodeproj'
     unitTestingPods
 end
#########################

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end
