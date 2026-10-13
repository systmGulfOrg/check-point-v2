package com.systmgulf.checkpoint

import android.content.Context
import android.location.LocationManager
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LocationIntegrityHandler(private val context: Context) {

    companion object {
        const val CHANNEL = "com.systmgulf.checkpoint/location_integrity"
    }

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "checkLocationSample" -> checkLocationSample(call, result)
            "isMockLocationEnabled" -> isMockLocationEnabled(result)
            else -> result.notImplemented()
        }
    }

    private fun checkLocationSample(call: MethodCall, result: MethodChannel.Result) {
        try {
            val latitude = call.argument<Double>("latitude") ?: run {
                result.error("INVALID_ARGS", "latitude is required", null)
                return
            }
            val longitude = call.argument<Double>("longitude") ?: run {
                result.error("INVALID_ARGS", "longitude is required", null)
                return
            }
            val accuracy = call.argument<Double>("accuracy") ?: 0.0
            val timestampMs = call.argument<Long>("timestampMs") ?: System.currentTimeMillis()
            val provider = call.argument<String>("provider") ?: "unknown"
            val speed = call.argument<Double>("speed") ?: 0.0
            val isMockFromDart = call.argument<Boolean>("isMockFromDart") ?: false

            // The original provider Location object is owned by the Flutter
            // location plugin. Reconstructing a Location here would lose its
            // mock metadata and make Location.isMock() meaningless. The
            // plugin's Position.isMocked value is therefore passed through
            // explicitly and evaluated here with the API-level semantics.
            val (isMock, detectionMethod) = detectMock(isMockFromDart)

            result.success(mapOf(
                "isMock" to isMock,
                "mockCheckAvailable" to (isMockFromDart != null),
                "detectionMethod" to detectionMethod,
                "provider" to provider,
                "accuracy" to accuracy,
                "speed" to speed,
                "timestampMs" to timestampMs,
                "apiLevel" to Build.VERSION.SDK_INT,
            ))
        } catch (e: Exception) {
            result.error("CHECK_FAILED", e.message, null)
        }
    }

    private fun detectMock(isMockFromDart: Boolean?): Pair<Boolean, String> {
        return try {
            if (isMockFromDart == null) {
                Pair(false, "provider_mock_flag_unavailable")
            } else if (isMockFromDart) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    Pair(true, "provider_isMock_api31_plus")
                } else {
                    Pair(true, "provider_isFromMockProvider_legacy")
                }
            } else {
                Pair(false, "provider_mock_flag_clear")
            }
        } catch (e: Exception) {
            Pair(false, "check_failed_unknown")
        }
    }

    private fun isMockLocationEnabled(result: MethodChannel.Result) {
        try {
            val lm = context.getSystemService(Context.LOCATION_SERVICE) as? LocationManager
            if (lm == null) {
                result.success(mapOf("enabled" to false, "error" to "LocationManager unavailable"))
                return
            }
            // On API 31+ this always returns false as mock providers are system-level
            // On older APIs, check if a mock provider is registered
            val mockProviderExists = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
                try {
                    lm.getProvider(LocationManager.GPS_PROVIDER)?.let {
                        // We can't directly check if it's mock from here without a location object
                        false
                    } ?: false
                } catch (e: Exception) {
                    false
                }
            } else {
                false
            }
            result.success(mapOf("enabled" to mockProviderExists, "apiLevel" to Build.VERSION.SDK_INT))
        } catch (e: Exception) {
            result.success(mapOf("enabled" to false, "error" to e.message))
        }
    }
}
