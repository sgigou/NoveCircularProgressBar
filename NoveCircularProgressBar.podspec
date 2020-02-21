Pod::Spec.new do |spec|
  spec.name = "NoveCircularProgressBar"
  spec.version = "1.0.0"
  spec.summary = "A Swift circular progress bar."
  spec.description = <<-DESC
    A customizable progress bar with a beautiful circular design.
  DESC
  spec.homepage = "https://github.com/sgigou/NoveCircularProgressBar"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author = { "Steve Gigou" => "steve@gigou.fr" }
  spec.social_media_url = "https://twitter.com/SteveGigou"
  spec.ios.deployment_target = "9.0"
  spec.source = { :git => "https://github.com/sgigou/NoveCircularProgressBar.git", :tag => "#{spec.version}" }
  spec.source_files  = "NoveCircularProgressBar"
  spec.swift_versions = "5.0"
end