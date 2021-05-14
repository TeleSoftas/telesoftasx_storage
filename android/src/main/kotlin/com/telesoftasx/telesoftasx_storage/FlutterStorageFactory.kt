package com.telesoftasx.telesoftasx_storage

import android.content.Context
import android.os.Build
import android.util.Log
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKeys

object FlutterStorageFactory {
    fun createSecureStorage(context: Context) =
            PreferencesStorageAdapter(getSecurePreferences(context))

    fun createGeneralStorage(context: Context) =
            PreferencesStorageAdapter(getGeneralPreferences(context))

    private fun getSecurePreferences(context: Context) = try {
        val masterKeyAlias = MasterKeys.getOrCreate(MasterKeys.AES256_GCM_SPEC)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            EncryptedSharedPreferences.create(
                    "${context.packageName}.secure",
                    masterKeyAlias,
                    context,
                    EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
                    EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
            )
        } else {
            getGeneralPreferences(context)
        }
    } catch (cause: Exception) {
        Log.e("FlutterPreferences", "failed initialize preferences", cause)
        getGeneralPreferences(context)
    }

    private fun getGeneralPreferences(context: Context) =
            context.getSharedPreferences(context.packageName, Context.MODE_PRIVATE)
}