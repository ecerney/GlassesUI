Pod::Spec.new do |s|
  s.name         = "Glasses"
  s.version      = "0.0.11"
  s.summary      = "A short description of Glasses."
  s.description  = "Provides pixel data for different glasses"
  s.homepage     = "http://ericcerney.com"
  s.author       = { "Eric Cerney" => "ecerney@gmail.com" }
  s.source       = { :git => "../", :tag => "#{s.version}" }
  s.source_files  = "Sources", "Sources/**/*.{h,m,swift}"
end
