package com.telesoftasx.telesoftasx_storage

import android.content.SharedPreferences
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PreferencesStorageAdapter(private val preferences: SharedPreferences) {
    private val editor get() = preferences.edit()

    fun initializeWith(methodChannel: MethodChannel) {
        methodChannel.setMethodCallHandler(::onMethodCall)
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "put" -> {
                putValue(getKey(call), getValue(call))
                result.success(null)
            }
            "getString" -> result.success(preferences.getString(getKey(call), getDefaultValue(call)))
            "getBool" -> result.success(preferences.getBoolean(getKey(call), getDefaultValue(call) ?: false))
            "getDouble" -> result.success(preferences.getFloat(getKey(call), getDefaultValue(call) ?: 0f))
            "getInt" -> result.success(preferences.getInt(getKey(call), getDefaultValue(call) ?: 0))
            else -> result.notImplemented()
        }
    }

    private fun getKey(call: MethodCall): String = call.argument(ARG_KEY)!!

    private inline fun <reified T> getValue(call: MethodCall): T? = call.argument(ARG_VALUE)

    private inline fun <reified T> getDefaultValue(call: MethodCall): T? = call.argument(ARG_DEFAULT_VALUE)

    private fun putValue(key: String, value: Any?) {
        when (value) {
            null -> editor.remove(key).apply()
            is String -> editor.putString(key, value).apply()
            is Int -> editor.putInt(key, value).apply()
            is Long -> editor.putLong(key, value).apply()
            is Double -> editor.putFloat(key, value.toFloat()).apply()
            is Boolean -> editor.putBoolean(key, value).apply()
            else -> throw IllegalArgumentException("Storage type not supported")
        }
    }

    companion object {
        const val ARG_KEY = "key"
        const val ARG_VALUE = "value"
        const val ARG_DEFAULT_VALUE = "defaultValue"
    }
}