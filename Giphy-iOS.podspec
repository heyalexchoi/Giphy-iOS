
Pod::Spec.new do |s|
  s.name             = "Giphy-iOS"
  s.version          = "0.1.1"
  s.summary          = "Giphy API client for Objective-C"
  s.description      = "Giphy-iOS provides convenient access to the Giphy API for objective-c developers. The interface provides  block based methods with NSURLSessionDataTasks, NSURLRequests, and converting Giphy API responses into NSObjects"
  s.homepage         = "https://github.com/heyalexchoi/Giphy-iOS"
  s.license          = 'MIT'
  s.author           = { "Alex Choi" => "heyalexchoi@gmail.com" }
  s.source           = { :git => "https://github.com/heyalexchoi/Giphy-iOS.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.dependency 'AFNetworking/Serialization', '~> 2.3.1'
end
