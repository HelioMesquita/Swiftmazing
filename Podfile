platform :ios, '13.0'

use_frameworks!

workspace 'Swiftmazing'


def testingPods
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
end

def visualPods
    pod 'SDWebImage', '5.4.0'
end

def infrastructurePods
    pod 'PromiseKit', '6.10.0'
end

##Swiftmazing
target 'Swiftmazing' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    infrastructurePods
    visualPods
end

# target 'SwiftmazingTests' do
#     project 'Swiftmazing/Swiftmazing.xcodeproj'
#     testingPods
# end

##Infrastructure
target 'Infrastructure' do
    project 'Infrastructure/Infrastructure.xcodeproj'
    infrastructurePods
end

# target 'InfrastructureTests' do
#     project 'Infrastructure/Infrastructure.xcodeproj'
#     testingPods
# end

##Visual
target 'Visual' do
    project 'Visual/Visual.xcodeproj'
    visualPods
end

# target 'VisualTests' do
#     project 'Visual/Visual.xcodeproj'

# end

