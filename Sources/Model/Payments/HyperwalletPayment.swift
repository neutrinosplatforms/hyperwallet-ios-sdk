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

/// Representation of a `HyperwalletPayment`
public struct HyperwalletPayment: Codable {
    public let token: String?
    public let status: HyperwalletPaymentStatus?
    public let createdOn: String?
    public let amount: String?
    public let currency: String?
    public let clientPaymentId: String
    public let purpose: String?
    public let releaseOn: String?
    public let expiresOn: String?
    public let destinationToken: String
    public let programToken: String
   
    /// Representation of a `HyperwalletPaymentStatus`
    public enum HyperwalletPaymentStatus: String, Codable {
        case created = "CREATED"
        case scheduled = "SCHEDULED"
        case pendingAccountActivation = "PENDING_ACCOUNT_ACTIVATION"
        case pendingIdVerification = "PENDING_ID_VERIFICATION"
        case pendingTaxVerification = "PENDING_TAX_VERIFICATION"
        case pendingTransferMethodAction = "PENDING_TRANSFER_METHOD_ACTION"
        case pendingTransactionVerification = "PENDING_TRANSACTION_VERIFICATION"
        case inProgress = "IN_PROGRESS"
        case unclaimed = "UNCLAIMED"
        case completed = "COMPLETED"
        case cancelled = "CANCELLED"
        case failed = "FAILED"
        case recalled = "RECALLED"
        case returned = "RETURNED"
        case expired = "EXPIRED"
    }
    
    private init(token: String? = nil,
                 status: HyperwalletPaymentStatus? = nil,
                 createdOn: String? = nil,
                 amount: String? = nil,
                 clientPaymentId: String,
                 currency: String? = nil,
                 destinationToken: String,
                 programToken: String,
                 purpose: String? = nil,
                 releaseOn: String? = nil,
                 expiresOn: String? = nil) {
        self.token = token
        self.status = status
        self.createdOn = createdOn
        self.amount = amount
        self.clientPaymentId = clientPaymentId
        self.currency = currency
        self.destinationToken = destinationToken
        self.programToken = programToken
        self.purpose = purpose
        self.releaseOn = releaseOn
        self.expiresOn = expiresOn
    }

    /// A helper class to build the `HyperwalletPayment` instance.
    public class Builder {
        private let amount: String?
        private let clientPaymentId: String
        private var currency: String?
        private let destinationToken: String
        private let programToken: String
        private var purpose: String?
        

        /// Creates a new instance of the `HyperwalletPayment.Builder` based on the required parameters to create
        /// a transfer.
        ///
        /// - Parameters:
        ///   - clientTransferId: A client defined transfer identifier.
        ///                       This is the unique ID assigned to the transfer on your system.
        ///                       Max 50 characters.
        ///   - sourceToken: A token identifying the source of funds.
        ///                  It can be a prepaid card token prefixed with `trm-` or user token prefixed with `usr-`.
        ///   - destinationToken: A token identifying where the funds have been sent.
        ///                       It is your merchant account token prefixed with `act-`.
        public init(amount: String, clientPaymentId: String, destinationToken: String, programToken: String) {
            self.amount = amount
            self.clientPaymentId = clientPaymentId
            self.destinationToken = destinationToken
            self.programToken = programToken
        }
        
        public func currency(_ currency: String) -> Builder {
            self.currency = currency
            return self
        }
        
        public func purpose(_ purpose: String) -> Builder {
            self.purpose = purpose
            return self
        }
        
        // Builds a new instance of the `HyperwalletPayment`.
        ///
        /// - Returns: a new instance of the `HyperwalletPayment`.
        public func build() -> HyperwalletPayment {
            HyperwalletPayment(amount: amount,
                               clientPaymentId: clientPaymentId,
                               currency: currency,
                               destinationToken: destinationToken,
                               programToken: programToken,
                               purpose: purpose)
        }
    }
}
