import UIKit
import Flutter
import Easebuzz

@main
@objc class AppDelegate: FlutterAppDelegate, PayWithEasebuzzCallback {
    var payResult: FlutterResult!

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.initializeFlutterChannelMethod()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Initialize Flutter channel
    func initializeFlutterChannelMethod() {
        GeneratedPluginRegistrant.register(with: self)
        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not type FlutterViewController")
        }

        let methodChannel = FlutterMethodChannel(name: "easebuzz", binaryMessenger: controller.binaryMessenger)
        methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard call.method == "payWithEasebuzz" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.payResult = result
            self?.initiatePaymentAction(call: call)
        }
    }

    // Initiate payment action and call payment gateway
    func initiatePaymentAction(call: FlutterMethodCall) {
        guard let orderDetails = call.arguments as? [String: String] else {
            let dict = self.setErrorResponseDictError("Invalid Arguments", errorMessage: "Expected order details", result: "Invalid request")
            self.payResult(dict ?? [:])
            return
        }

        let payment = Payment(customerData: orderDetails)
        let paymentValid = payment.isValid().validity
        if !paymentValid {
            print("Invalid records")
        } else {
            PayWithEasebuzz.setUp(pebCallback: self)
            DispatchQueue.main.async {
                PayWithEasebuzz.invokePaymentOptionsView(paymentObj: payment, isFrom: self)
            }
        }
    }

    // Payment call callback and handle response
    func PEBCallback(data: [String: AnyObject]) {
        if let responseData = data as? [String: Any], !responseData.isEmpty {
            self.payResult(responseData)
        } else {
            let dict = self.setErrorResponseDictError("Empty error", errorMessage: "Empty payment response", result: "payment_failed")
            self.payResult(dict ?? [:])
        }
    }

    // Create error response dictionary for errors
    func setErrorResponseDictError(_ error: String?, errorMessage: String?, result: String?) -> [AnyHashable: Any]? {
        var dict: [AnyHashable: Any] = [:]
        var dictChild: [AnyHashable: Any] = [:]
        dictChild["error"] = "\(error ?? "")"
        dictChild["error_msg"] = "\(errorMessage ?? "")"
        dict["result"] = "\(result ?? "")"
        dict["payment_response"] = dictChild
        return dict
    }
}
