# coding: utf-8
Pod::Spec.new do |s|
    s.name         = "UIMenuScroll"
    s.version      = "0.0.2"
    s.summary      = "UIMenuScroll creating menu how on Facebook Messenger on take photo"
    s.author       = "AlekseyPleshkov <im@alekseypleshkov.ru>"
    s.homepage     = "https://github.com/AlekseyPleshkov/UIMenuScroll"
    s.license      = 'MIT'
    s.source       = { :git => 'https://github.com/AlekseyPleshkov/UIMenuScroll.git', :branch => "master", :tag => s.version.to_s }
    s.platform     = :ios, '10.0'
    s.source_files = 'UIMenuScroll/*.{h,m,swift}'
    s.requires_arc = true
    s.frameworks   = 'UIKit'
    s.swift_version= "4.2"
end
