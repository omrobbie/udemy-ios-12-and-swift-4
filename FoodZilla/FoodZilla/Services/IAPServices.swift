//
//  IAPServices.swift
//  FoodZilla
//
//  Created by omrobbie on 03/03/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation
import StoreKit

protocol IAPServiceDelegate {
    func iapProductsLoaded()
}

class IAPService: NSObject {

    static let instance = IAPService()

    var delegate: IAPServiceDelegate?

    var products = [SKProduct]()
    var productIds = Set<String>()
    var productRequest = SKProductsRequest()

    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    func loadProducts() {
        productIdToStringSet()
        requestProducts(forIds: productIds)
    }

    func productIdToStringSet() {
        productIds.insert(IAP_MEAL_ID)
    }

    func requestProducts(forIds ids: Set<String>) {
        productRequest.cancel()
        productRequest = SKProductsRequest(productIdentifiers: ids)
        productRequest.delegate = self
        productRequest.start()
    }

    func attemptPurchaseForItemWith(productIndex: Product) {
        if products.count == 0 {
            debugPrint("There is no products available to purchase!")
            return
        }

        let product = products[productIndex.rawValue]
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension IAPService: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products

        if products.count == 0 {
            requestProducts(forIds: productIds)
            return
        }

        delegate?.iapProductsLoaded()
    }
}

extension IAPService: SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                debugPrint("Purchase was successful!")
            case .restored: break
            case .failed: break
            case .deferred: break
            case .purchasing: break
            default: break
            }
        }
    }
}
