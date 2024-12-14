package com.example.hospital_app

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.gson.Gson
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val CHANNEL = "easebuzz"
    private var channelResult: MethodChannel.Result? = null
    private var startPaymentFlag = true

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            channelResult = result
            if (call.method == "payWithEasebuzz") {
                if (startPaymentFlag) {
                    startPaymentFlag = false
                    startPayment(call.arguments)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startPayment(arguments: Any) {
        try {
            val gson = Gson()
            val parameters = JSONObject(gson.toJson(arguments))
            val intentProceed = Intent(this, PWECouponsActivity::class.java)
            intentProceed.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT

            val keys: Iterator<*> = parameters.keys()
            while (keys.hasNext()) {
                val key = keys.next() as String
                val value = parameters.optString(key)
                if (key == "amount") {
                    val amount: Double = parameters.optDouble("amount")
                    intentProceed.putExtra(key, amount)
                } else {
                    intentProceed.putExtra(key, value)
                }
            }
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE)

        } catch (e: Exception) {
            startPaymentFlag = true
            val errorMap: MutableMap<String, Any> = HashMap()
            val errorDescMap: MutableMap<String, Any> = HashMap()
            val errorDesc = "Exception occurred: ${e.message}"
            errorDescMap["error"] = "Exception"
            errorDescMap["error_msg"] = errorDesc
            errorMap["result"] = PWEStaticDataModel.TXN_FAILED_CODE
            errorMap["payment_response"] = errorDescMap
            channelResult?.success(errorMap)
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == PWEStaticDataModel.PWE_REQUEST_CODE) {
            startPaymentFlag = true
            val response = JSONObject()
            val errorMap: MutableMap<String, Any> = HashMap()

            if (data != null) {
                val result = data.getStringExtra("result")
                val paymentResponse = data.getStringExtra("payment_response")
                try {
                    val obj = JSONObject(paymentResponse ?: "{}")
                    response.put("result", result)
                    response.put("payment_response", obj)
                    channelResult?.success(JsonConverter.convertToMap(response))
                } catch (e: Exception) {
                    val errorDescMap: MutableMap<String, Any> = HashMap()
                    errorDescMap["error"] = result.toString()
                    errorDescMap["error_msg"] = paymentResponse ?: "Unknown error"
                    errorMap["result"] = result.toString()
                    errorMap["payment_response"] = errorDescMap
                    channelResult?.success(errorMap)
                }
            } else {
                val errorDescMap: MutableMap<String, Any> = HashMap()
                errorDescMap["error"] = "Empty error"
                errorDescMap["error_msg"] = "Empty payment response"
                errorMap["result"] = "payment_failed"
                errorMap["payment_response"] = errorDescMap
                channelResult?.success(errorMap)
            }
        }
    }
}
