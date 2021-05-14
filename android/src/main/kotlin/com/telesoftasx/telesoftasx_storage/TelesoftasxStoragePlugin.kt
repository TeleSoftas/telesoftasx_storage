package com.telesoftasx.telesoftasx_storage

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class TelesoftasxStoragePlugin : FlutterPlugin {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var generalStorageChannel: MethodChannel
    private lateinit var secureStorageChannel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        generalStorageChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "telesoftasx_general_storage").apply {
            val storage = FlutterStorageFactory.createGeneralStorage(flutterPluginBinding.applicationContext)
            storage.initializeWith(this)
        }
        secureStorageChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "telesoftasx_secure_storage").apply {
            val storage = FlutterStorageFactory.createSecureStorage(flutterPluginBinding.applicationContext)
            storage.initializeWith(this)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        generalStorageChannel.setMethodCallHandler(null)
        secureStorageChannel.setMethodCallHandler(null)
    }
}
