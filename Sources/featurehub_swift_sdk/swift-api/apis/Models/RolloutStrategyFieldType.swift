//
// RolloutStrategyFieldType.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum RolloutStrategyFieldType: String, Codable, CaseIterable {
    case string = "STRING"
    case semanticVersion = "SEMANTIC_VERSION"
    case number = "NUMBER"
    case date = "DATE"
    case datetime = "DATETIME"
    case boolean = "BOOLEAN"
    case ipAddress = "IP_ADDRESS"
}
