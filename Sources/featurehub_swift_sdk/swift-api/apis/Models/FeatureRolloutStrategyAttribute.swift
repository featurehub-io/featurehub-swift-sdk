//
// FeatureRolloutStrategyAttribute.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct FeatureRolloutStrategyAttribute: Codable, JSONEncodable, Hashable {

    public var conditional: RolloutStrategyAttributeConditional
    public var fieldName: String
    /** the value(s) associated with this rule */
    public var values: [AnyCodable]?
    public var type: RolloutStrategyFieldType

    public init(conditional: RolloutStrategyAttributeConditional, fieldName: String, values: [AnyCodable]? = nil, type: RolloutStrategyFieldType) {
        self.conditional = conditional
        self.fieldName = fieldName
        self.values = values
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case conditional
        case fieldName
        case values
        case type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(conditional, forKey: .conditional)
        try container.encode(fieldName, forKey: .fieldName)
        try container.encodeIfPresent(values, forKey: .values)
        try container.encode(type, forKey: .type)
    }
}
