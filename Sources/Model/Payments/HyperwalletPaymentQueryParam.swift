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

/// Representation of the common payment query parameters.
public class HyperwalletPaymentQueryParam: QueryParam {
    enum QueryParam: String {
        case clientPaymentId
        case releaseDate
        case currency
        case memo
    }

    /// Returns payment method with this status.
    public var clientPaymentId: String?
    public var currency: String?
    public var releaseDate: Date?
    public var memo: String?


    /// Representation of the field's sortable
    public enum QuerySortable: String {
        /// Sort the result by ascendant created on
        case ascendantCreatedOn = "+createdOn"
        /// Sort the result by ascendant status
        case ascendantStatus = "+status"
        /// Sort the result by ascendant amount
        case ascendantAmount = "+amount"
        /// Sort the result by descendant created on
        case descendantCreatedOn = "-createdOn"
        /// Sort the result by descendant status
        case descendantStatus = "-status"
        /// Sort the result by descendant amount
        case descendantAmount = "-amount"
    }

    override public func toQuery() -> [String: String] {
        var query = super.toQuery()
        if let clientPaymentId = clientPaymentId {
            query[QueryParam.clientPaymentId.rawValue] = clientPaymentId
        }
        if let date = releaseDate {
            query[QueryParam.releaseDate.rawValue] = ISO8601DateFormatter.ignoreTimeZone.string(from: date)
        }
        if let currency = currency {
            query[QueryParam.currency.rawValue] = currency
        }
        if let memo = memo {
            query[QueryParam.memo.rawValue] = memo
        }
        return query
    }
}
