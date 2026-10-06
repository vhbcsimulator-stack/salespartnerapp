package com.vhbc.broker.vhbc_broker_app

import android.content.ContentValues
import android.content.Intent
import android.media.MediaScannerConnection
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.vhbc.broker/gallery"
    private var lastSavedUri: Uri? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "saveImageToGallery" -> {
                    val bytes = call.argument<ByteArray>("bytes")
                    val filename = call.argument<String>("filename") ?: "map_download.png"
                    val path = call.argument<String>("path")

                    try {
                        val fileBytes = bytes ?: (if (path != null) File(path).readBytes() else null)
                        if (fileBytes == null) {
                            result.error("INVALID_ARGS", "Bytes or path must be provided", null)
                            return@setMethodCallHandler
                        }

                        var savedDownloadUri: Uri? = null
                        var savedImageUri: Uri? = null

                        // 1. Save directly into public Downloads folder via MediaStore (visible in File Manager -> Downloads)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            try {
                                val values = ContentValues().apply {
                                    put(MediaStore.MediaColumns.DISPLAY_NAME, filename)
                                    put(MediaStore.MediaColumns.MIME_TYPE, "image/png")
                                    put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                                    put(MediaStore.MediaColumns.IS_PENDING, 1)
                                }

                                val resolver = applicationContext.contentResolver
                                val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                                if (uri != null) {
                                    resolver.openOutputStream(uri)?.use { os ->
                                        os.write(fileBytes)
                                    }
                                    values.clear()
                                    values.put(MediaStore.MediaColumns.IS_PENDING, 0)
                                    resolver.update(uri, values, null, null)
                                    savedDownloadUri = uri
                                }
                            } catch (e: Exception) {
                                android.util.Log.e("VhbcGallery", "Error saving to Downloads: ${e.message}")
                            }
                        }

                        // 2. Also register in MediaStore Images (Pictures/VHBC) so the phone's Gallery app indexes it instantly
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            try {
                                val picValues = ContentValues().apply {
                                    put(MediaStore.Images.Media.DISPLAY_NAME, filename)
                                    put(MediaStore.Images.Media.MIME_TYPE, "image/png")
                                    put(MediaStore.Images.Media.RELATIVE_PATH, "${Environment.DIRECTORY_PICTURES}/VHBC")
                                    put(MediaStore.Images.Media.IS_PENDING, 1)
                                }
                                val picUri = contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, picValues)
                                if (picUri != null) {
                                    contentResolver.openOutputStream(picUri)?.use { it.write(fileBytes) }
                                    picValues.clear()
                                    picValues.put(MediaStore.Images.Media.IS_PENDING, 0)
                                    contentResolver.update(picUri, picValues, null, null)
                                    savedImageUri = picUri
                                }
                            } catch (e: Exception) {
                                android.util.Log.e("VhbcGallery", "Error saving to Pictures: ${e.message}")
                            }
                        }

                        // 3. Direct write to public Downloads folder for Android 9 and legacy storage
                        try {
                            val downloadDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                            if (downloadDir != null && (downloadDir.exists() || downloadDir.mkdirs())) {
                                val destFile = File(downloadDir, filename)
                                FileOutputStream(destFile).use { it.write(fileBytes) }
                                MediaScannerConnection.scanFile(
                                    applicationContext,
                                    arrayOf(destFile.absolutePath),
                                    arrayOf("image/png")
                                ) { _, uri ->
                                    if (uri != null) {
                                        if (savedImageUri == null) savedImageUri = uri
                                        lastSavedUri = uri
                                    }
                                }
                                if (savedDownloadUri == null) {
                                    savedDownloadUri = Uri.fromFile(destFile)
                                }
                            }
                        } catch (e: Exception) {
                            android.util.Log.e("VhbcGallery", "Legacy download write note: ${e.message}")
                        }

                        val effectiveUri = savedImageUri ?: savedDownloadUri
                        lastSavedUri = effectiveUri
                        result.success(effectiveUri?.toString() ?: "saved")
                    } catch (e: Exception) {
                        result.error("SAVE_FAILED", e.localizedMessage, null)
                    }
                }
                "openGallery" -> {
                    try {
                        val uriStr = call.argument<String>("uri")
                        val targetUri: Uri? = if (!uriStr.isNullOrEmpty() && uriStr != "saved") {
                            Uri.parse(uriStr)
                        } else {
                            lastSavedUri
                        }

                        // Try 1: Open specific image in Gallery with ACTION_VIEW
                        if (targetUri != null) {
                            try {
                                val intent = Intent(Intent.ACTION_VIEW).apply {
                                    setDataAndType(targetUri, "image/*")
                                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                }
                                startActivity(intent)
                                result.success(true)
                                return@setMethodCallHandler
                            } catch (e: Exception) {
                                android.util.Log.w("VhbcGallery", "Direct URI ACTION_VIEW failed: ${e.message}")
                            }
                        }

                        // Try 2: Open Gallery app viewing MediaStore images collection
                        try {
                            val fallbackIntent = Intent(Intent.ACTION_VIEW, MediaStore.Images.Media.EXTERNAL_CONTENT_URI).apply {
                                type = "image/*"
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            startActivity(fallbackIntent)
                            result.success(true)
                            return@setMethodCallHandler
                        } catch (e2: Exception) {
                            android.util.Log.w("VhbcGallery", "MediaStore ACTION_VIEW failed: ${e2.message}")
                        }

                        // Try 3: Launch system Gallery category app
                        try {
                            val galleryIntent = Intent(Intent.ACTION_MAIN).apply {
                                addCategory(Intent.CATEGORY_APP_GALLERY)
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            startActivity(galleryIntent)
                            result.success(true)
                            return@setMethodCallHandler
                        } catch (e3: Exception) {
                            result.error("OPEN_FAILED", e3.localizedMessage, null)
                        }
                    } catch (e: Exception) {
                        result.error("OPEN_FAILED", e.localizedMessage, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
