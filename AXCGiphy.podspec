
Pod::Spec.new do |s|
  s.name             = "AXCGiphy"
  s.version          = "0.1.0"
  s.summary          = "A short description of AXCGiphy."
  s.description      = <<-DESC
                       An optional longer description of AXCGiphy

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/AXCGiphy"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alex Choi" => "heyalexchoi@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/AXCGiphy.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
