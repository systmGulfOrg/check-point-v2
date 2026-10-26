package com.systmgulf.checkpoint

import android.content.Context
import android.os.SystemClock
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceClockHandler(private val context: Context) {

    companion object {
        const val CHANNEL = "com.systmgulf.checkpoint/device_clock"
    }

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getClockSnapshot" -> getClockSnapshot(result)
            else -> result.notImplemented()
        }
    }

    private fun getClockSnapshot(result: MethodChannel.Result) {
        try {
            val monotonicMs = SystemClock.elapsedRealtime()
            val bootCount = try {
                Settings.Global.getInt(context.contentResolver, Settings.Global.BOOT_COUNT, -1)
            } catch (e: Exception) {
                -1
            }
            val bootId = if (bootCount != -1) {
                "boot-$bootCount"
            } else {
                val approximateBootTime = System.currentTimeMillis() - monotonicMs
                // Quantize to 10 seconds to tolerate small clock shifts
                "boot-${approximateBootTime / 10000 * 10000}"
            }

            result.success(
                mapOf(
                    "monotonicMs" to monotonicMs,
                    "bootId" to bootId,
                )
            )
        } catch (e: Exception) {
            result.error("DEVICE_CLOCK_ERROR", e.message, null)
        }
    }
}
