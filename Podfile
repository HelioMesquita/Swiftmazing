platform :ios, '9.0'

workspace 'Swiftmazing'
project 'Infrastructure/Infrastructure.xcodeproj'
project 'Visual/Visual.xcodeproj'
project 'Swiftmazing/Swiftmazing.xcodeproj'

target 'Swiftmazing' do
    project 'Swiftmazing/Swiftmazing.xcodeproj'
   #Pods for Project2
end

target 'Infrastructure' do
    project 'Infrastructure/Infrastructure.xcodeproj'
   #Pods for Project1
    pod 'PromiseKit', '6.10.0'
end

target 'Visual' do
    project 'Visual/Visual.xcodeproj'
   #Pods for Project2
end