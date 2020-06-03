package ru.penf00k.env_native

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.Context

/** EnvNativePlugin */
public class EnvNativePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "penf00k.ru/env_native")
            channel.setMethodCallHandler(EnvNativePlugin())
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "penf00k.ru/env_native")
        mContext = flutterPluginBinding.getApplicationContext()
        channel.setMethodCallHandler(this);
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
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

    private fun <T> get(defType: String, call: MethodCall, result: MethodChannel.Result, getter: (resId: Int) -> T) {
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
