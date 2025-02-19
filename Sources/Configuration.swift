//
// Copyright 2018 - Present Hyperwallet
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

/// Configuration object retrieved on successful authentication
public struct Configuration: Codable {
    
    let createOn: Double
    let clientToken: String
    let expiresOn: Double
    let graphQlUrl: String
    let restUrl: String
    /// The environment type
    public let environment: String?
    /// The insights Url
    public let insightsUrl: String?
    /// The issuer
    public let issuer: String
    /// The user token
    public let userToken: String
    /// The program model
    public let programModel: String?
    var authorization: String!
    private static let stalePeriod = 30.0 // 30 seconds
    private let createOnBootTime = ProcessInfo.processInfo.systemUptime

    enum CodingKeys: String, CodingKey {
        case createOn = "iat"
        case clientToken = "aud"
        case expiresOn = "exp"
        case graphQlUrl = "graphql-uri"
        case issuer = "iss"
        case userToken = "sub"
        case restUrl = "rest-uri"
        case insightsUrl = "insights-uri"
        case environment = "environment"
        case programModel = "program-model"
    }

    func isTokenStale() -> Bool {
        let tokenLifespan = expiresOn - createOn
        return ProcessInfo.processInfo.systemUptime - createOnBootTime >= tokenLifespan - Configuration.stalePeriod
    }

    func isTokenExpired() -> Bool {
        let tokenLifespan = expiresOn - createOn
        return ProcessInfo.processInfo.systemUptime - createOnBootTime >= tokenLifespan
    }
    
    var isUnauthenticated: Bool {
        return userToken.isEmpty
    }
}

extension Configuration {
    init(restUrl: String, authorization: String) {
        self.init(createOn: 0.0, clientToken: "", expiresOn: 0.0, graphQlUrl: "", restUrl: restUrl, environment: nil, insightsUrl: nil, issuer: "", userToken: "", programModel: nil, authorization: authorization)
    }
}
