# Swift5 API client for OpenAPIClient

This describes the API clients use for accessing features

## Overview
This API client was generated by the [OpenAPI Generator](https://openapi-generator.tech) project.  By using the [openapi-spec](https://github.com/OAI/OpenAPI-Specification) from a remote server, you can easily generate an API client.

- API version: 1.1.4
- Package version: 
- Build package: org.openapitools.codegen.languages.Swift5ClientCodegen

## Installation

### Carthage

Run `carthage update`

### CocoaPods

Run `pod install`

## Documentation for API Endpoints

All URIs are relative to *http://localhost*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*FeatureServiceAPI* | [**getFeatureStates**](docs/FeatureServiceAPI.md#getfeaturestates) | **GET** /features/ | 
*FeatureServiceAPI* | [**setFeatureState**](docs/FeatureServiceAPI.md#setfeaturestate) | **PUT** /features/{sdkUrl}/{featureKey} | 
*InfoServiceAPI* | [**getInfoVersion**](docs/InfoServiceAPI.md#getinfoversion) | **GET** /info/version | 


## Documentation For Models

 - [ApplicationVersionInfo](docs/ApplicationVersionInfo.md)
 - [BaseRolloutStrategy](docs/BaseRolloutStrategy.md)
 - [BaseRolloutStrategyAttribute](docs/BaseRolloutStrategyAttribute.md)
 - [FeatureEnvironmentCollection](docs/FeatureEnvironmentCollection.md)
 - [FeatureRolloutStrategy](docs/FeatureRolloutStrategy.md)
 - [FeatureRolloutStrategyAllOf](docs/FeatureRolloutStrategyAllOf.md)
 - [FeatureRolloutStrategyAttribute](docs/FeatureRolloutStrategyAttribute.md)
 - [FeatureState](docs/FeatureState.md)
 - [FeatureStateUpdate](docs/FeatureStateUpdate.md)
 - [FeatureValueType](docs/FeatureValueType.md)
 - [RoleType](docs/RoleType.md)
 - [RolloutStrategyAttributeConditional](docs/RolloutStrategyAttributeConditional.md)
 - [RolloutStrategyFieldType](docs/RolloutStrategyFieldType.md)
 - [SSEResultState](docs/SSEResultState.md)
 - [StrategyAttributeCountryName](docs/StrategyAttributeCountryName.md)
 - [StrategyAttributeDeviceName](docs/StrategyAttributeDeviceName.md)
 - [StrategyAttributePlatformName](docs/StrategyAttributePlatformName.md)
 - [StrategyAttributeWellKnownNames](docs/StrategyAttributeWellKnownNames.md)


## Documentation For Authorization

 All endpoints do not require authorization.


## Author



