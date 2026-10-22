package com.systmgulf.checkpoint

import android.content.Context
import com.google.android.play.core.integrity.IntegrityManagerFactory
import com.google.android.play.core.integrity.StandardIntegrityManager
import com.google.android.play.core.integrity.StandardIntegrityManager.PrepareIntegrityTokenRequest
import com.google.android.play.core.integrity.StandardIntegrityManager.StandardIntegrityTokenProvider
import com.google.android.play.core.integrity.StandardIntegrityManager.StandardIntegrityTokenRequest
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PlayIntegrityHandler(private val context: Context) {

    companion object {
        const val CHANNEL = "com.systmgulf.checkpoint/play_integrity"
        const val CLOUD_PROJECT_NUMBER = 481143074801L
    }

    private val standardIntegrityManager: StandardIntegrityManager by lazy {
        IntegrityManagerFactory.createStandard(context)
    }

    @Volatile
    private var tokenProvider: StandardIntegrityTokenProvider? = null

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "prepareIntegrityToken" -> prepare(result)
            "requestIntegrityToken" -> {
                val requestHash = call.argument<String>("requestHash")
                requestToken(requestHash, result)
            }
            else -> result.notImplemented()
        }
    }

    fun prepare(result: MethodChannel.Result? = null) {
        val request = PrepareIntegrityTokenRequest.builder()
            .setCloudProjectNumber(CLOUD_PROJECT_NUMBER)
            .build()

        standardIntegrityManager.prepareIntegrityToken(request)
            .addOnSuccessListener { provider ->
                tokenProvider = provider
                result?.success(true)
            }
            .addOnFailureListener { exception ->
                result?.error(
                    "PREPARE_FAILED",
                    exception.message ?: "Failed to prepare integrity token",
                    exception.localizedMessage
                )
            }
    }

    private fun requestToken(requestHash: String?, result: MethodChannel.Result) {
        val currentProvider = tokenProvider
        if (currentProvider != null) {
            fetchTokenFromProvider(currentProvider, requestHash, result)
        } else {
            // If not prepared yet, prepare first then fetch
            val request = PrepareIntegrityTokenRequest.builder()
                .setCloudProjectNumber(CLOUD_PROJECT_NUMBER)
                .build()

            standardIntegrityManager.prepareIntegrityToken(request)
                .addOnSuccessListener { provider ->
                    tokenProvider = provider
                    fetchTokenFromProvider(provider, requestHash, result)
                }
                .addOnFailureListener { exception ->
                    result.error(
                        "PREPARE_FAILED",
                        exception.message ?: "Failed to prepare integrity token",
                        exception.localizedMessage
                    )
                }
        }
    }

    private fun fetchTokenFromProvider(
        provider: StandardIntegrityTokenProvider,
        requestHash: String?,
        result: MethodChannel.Result
    ) {
        val builder = StandardIntegrityTokenRequest.builder()
        if (!requestHash.isNullOrBlank()) {
            builder.setRequestHash(requestHash)
        }

        provider.request(builder.build())
            .addOnSuccessListener { response ->
                result.success(response.token())
            }
            .addOnFailureListener { exception ->
                tokenProvider = null
                result.error(
                    "REQUEST_FAILED",
                    exception.message ?: "Failed to request integrity token",
                    exception.localizedMessage
                )
            }
    }
}
