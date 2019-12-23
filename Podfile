platform :ios, '13.0'

use_frameworks!


workspace 'Swiftmazing'
project 'Infrastructure/Infrastructure.xcodeproj'
project 'Visual/Visual.xcodeproj'
project 'Swiftmazing/Swiftmazing.xcodeproj'

def testingPods
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
end

def promiseKit
    pod 'PromiseKit', '6.10.0'
end

##Swiftmazing
target 'Swiftmazing' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    promiseKit
end

target 'SwiftmazingTests' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
    testingPods
end

##Infrastructure
target 'Infrastructure' do
    project 'Infrastructure/Infrastructure.xcodeproj'
    promiseKit
end

target 'InfrastructureTests' do
    project 'Infrastructure/Infrastructure.xcodeproj'
    testingPods
end

##Visual
target 'Visual' do
    project 'Visual/Visual.xcodeproj'
#    pod 'SDWebImage', '5.4.0'
end

