//
// BaseRolloutStrategy.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

/** if the feature in an environment is different from its default, this will be the reason for it. a rollout strategy is defined at the Application level and then applied to a specific feature value. When they are copied to the cache layer they are cloned and the feature value for that strategy is inserted into the clone and those are published. */
public struct BaseRolloutStrategy: Codable, JSONEncodable, Hashable {

    public var id: String?
    /** value between 0 and 1000000 - for four decimal places */
    public var percentage: Int?
    /** if you don't wish to apply percentage based on user id, you can use one or more attributes defined here */
    public var percentageAttributes: [String]?
    /** when we attach the RolloutStrategy for Dacha or SSE this lets us push the value out. Only visible in SDK and SSE Edge. */
    public var value: AnyCodable?
    public var attributes: [BaseRolloutStrategyAttribute]?

    public init(id: String? = nil, percentage: Int? = nil, percentageAttributes: [String]? = nil, value: AnyCodable? = nil, attributes: [BaseRolloutStrategyAttribute]? = nil) {
        self.id = id
        self.percentage = percentage
        self.percentageAttributes = percentageAttributes
        self.value = value
        self.attributes = attributes
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case percentage
        case percentageAttributes
        case value
        case attributes
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(percentage, forKey: .percentage)
        try container.encodeIfPresent(percentageAttributes, forKey: .percentageAttributes)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(attributes, forKey: .attributes)
    }
}
