package ru.penf00k.env_native

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context

/** EnvNativePlugin */
class EnvNativePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "penf00k.ru/env_native")
        mContext = flutterPluginBinding.getApplicationContext()
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getString" -> getString(call, result)
            "getInt" -> getInt(call, result)
            else -> result.notImplemented()
        }
    }

    private fun getString(call: MethodCall, result: MethodChannel.Result) {
        get("string", call, result) { resId ->
            mContext.resources.getString(resId)
        }
    }

    private fun getInt(call: MethodCall, result: MethodChannel.Result) {
        get("integer", call, result) { resId ->
            mContext.resources.getInteger(resId)
        }
    }

    private fun <T> get(
        defType: String,
        call: MethodCall,
        result: MethodChannel.Result,
        getter: (resId: Int) -> T
    ) {
        val key = call.arguments<String>()

        val resId = mContext.resources.getIdentifier(key, defType, mContext.packageName)
        if (resId == 0) {
            result.error("resource not found", "$defType resource with name $key not found", null)
            return
        }

        val v = getter(resId)
        result.success(v)
    }
}
