
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "uptime_reports_spreadsheet/version"

Gem::Specification.new do |spec|

  url="https://rubygems.org"
  spec.name          = "uptime_reports_spreadsheet"
  spec.version       = UptimeReportsSpreadsheet::VERSION
  spec.authors       = ["Diego H Piccinini Lagos"]
  spec.email         = ["dlagos@bookingbug.com"]

  spec.summary       = %q{ Write spreadsheet in Google. }
  spec.description   = %q{ Get a report and write it in a google sheet. }
  spec.homepage      = "#{url}/docs/bbeng/index.html"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = url
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_dependency "google-api-client", "~> 0.16"
  spec.add_dependency "byebug", "~> 9.1"
  spec.add_dependency "dotenv", "~> 2.2"
end
