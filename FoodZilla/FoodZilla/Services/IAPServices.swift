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

    var nonConsumablePurchaseWasMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")

    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    func loadProducts() {
        productIdToStringSet()
        requestProducts(forIds: productIds)
    }

    func productIdToStringSet() {
        productIds.insert(IAP_HIDE_ADS_ID)
        productIds.insert(IAP_MEAL_ID)
        productIds.insert(IAP_MEAL_MONTHLY)
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

    func restorePurcases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func uploadReceipt(completion: @escaping (Bool) -> ()) {
        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
            let receipt = try? Data(contentsOf: receiptUrl).base64EncodedString()
            else {
                debugPrint("No receipt url")
                completion(false)
                return
        }

        let body = [
            "receipt-data": receipt,
            "password": appSecret
        ]

        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])

        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint("Error: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let data = data else {return}

            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
            let newExpirationDate = self.expirationDateFromResponse(jsonResponse: json)
            debugPrint("New expiration date: \(newExpirationDate!)")
            completion(true)
        }

        task.resume()
    }

    func expirationDateFromResponse(jsonResponse: Dictionary<String, Any>) -> Date? {
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            let lastReceipt = receiptInfo.lastObject as! Dictionary<String, Any>
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            let expirationDate: Date = (formatter.date(from: lastReceipt["expires_date"] as! String) as Date?)!
            return expirationDate
        }

        return nil
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
                complete(transaction: transaction)
                uploadReceipt { (valid) in }
                debugPrint("Purchase was successful!")
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                debugPrint("Purchases was restored!")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                sendNotificationFor(status: .failed, withIdentifier: nil, orBoolean: nil)
                debugPrint("Purchase was failed!")
            case .deferred: break
            case .purchasing: break
            default: break
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        sendNotificationFor(status: .restored, withIdentifier: nil, orBoolean: nil)
        setNonConsumablePurchase(true)
    }

    func complete(transaction: SKPaymentTransaction) {
        switch transaction.payment.productIdentifier {
        case IAP_MEAL_ID:
            sendNotificationFor(status: .purchased, withIdentifier: transaction.payment.productIdentifier, orBoolean: nil)
        case IAP_HIDE_ADS_ID:
            setNonConsumablePurchase(true)
        case IAP_MEAL_MONTHLY:
            uploadReceipt { (valid) in
                if valid {
                    debugPrint("Subscription is valid.")
                } else {
                    debugPrint("You don't have subscription purchased!")
                }
            }
            sendNotificationFor(status: .subsribed, withIdentifier: transaction.payment.productIdentifier, orBoolean: true)
            setNonConsumablePurchase(true)
        default: break
        }
    }

    func setNonConsumablePurchase(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "nonConsumablePurchaseWasMade")
    }

    func sendNotificationFor(status: PurchaseStatus, withIdentifier identifier: String?, orBoolean bool: Bool?) {
        switch status {
        case .purchased:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServicenPurchaseNotification), object: identifier)
        case .restored:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
        case .failed:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
        case .subsribed:
            NotificationCenter.default.post(name: NSNotification.Name(IAPSubInfoChangedNotification), object: bool)
        }
    }
}
