$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "yelp_html_parser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "yelp_html_parser"
  s.version     = YelpHtmlParser::VERSION
  s.authors     = ["Achiinto"]
  s.email       = []
  s.homepage    = ""
  s.summary     = "To prase Yelp html content into consumable business objects."
  s.description = "This allows fetching and parsing Yelp businesses data from html content where otherwise not avaiblable."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "nokogiri", "~> 1.6.5"

  s.add_development_dependency "rspec", "~> 3.2"
  s.add_development_dependency 'webmock', "~> 1.20"
end
