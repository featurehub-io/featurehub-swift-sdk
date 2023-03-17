Pod::Spec.new do |s|
  s.name = 'FeatureHub-Swift-SDK'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '11.0'
  s.watchos.deployment_target = '4.0'
  s.version = '1.0.0'
  s.source = { :git => 'git@github.com:featurehub-io/featurehub-swift-sdk.git', :tag => 'v1.1.4' }
  s.authors = 'Irina Southwell, Richard Vowles'
  s.license = 'MIT'
  s.homepage = 'https://featurehub.io'
  s.summary = 'FeatureHub Swift SDK'
  s.source_files = 'featurehub-swift-sdk/**/*.swift'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6.1'
end
