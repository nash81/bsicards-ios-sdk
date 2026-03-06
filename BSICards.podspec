Pod::Spec.new do |spec|
  spec.name         = "BSICards"
  spec.version      = "1.0.0"
  spec.summary      = "BSICARDS iOS SDK"
  spec.description  = <<-DESC
    A comprehensive Swift SDK for integrating with the BSICARDS Card Issuance API.
    Create and manage Mastercard, Visa, and Digital Wallet cards with ease on iOS.
  DESC

  spec.homepage     = "https://github.com/nash81/bsicards-ios-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "BSI Group" => "cs@bsigroup.tech" }

  spec.platform     = :ios, "13.0"
  spec.swift_version = "5.5"

  spec.source       = { :git => "https://github.com/nash81/bsicards-ios-sdk.git", :tag => "#{spec.version}" }

  spec.source_files = "Sources/BSICards/**/*.swift"
  spec.requires_arc = true

  spec.frameworks   = "Foundation"
end

