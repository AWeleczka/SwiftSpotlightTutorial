Pod::Spec.new do |s|
  s.name         = "SwiftSpotlightTutorial"
  s.version      = "1.0.0"
  s.summary      = "A Spotlight Tutorial built in Swift"
  s.description  = <<-DESC
    Easily guide your app's users through the first experience of your application
                   DESC
  s.homepage     = "https://github.com/AWeleczka/SwiftSpotlightTutorial"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "Alexander Weleczka"
  s.social_media_url   = "http://twitter.com/AWeleczka"

  s.source       = { :git => "https://github.com/AWeleczka/SwiftSpotlightTutorial.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
