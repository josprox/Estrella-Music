package com.josprox.jossredconnect.models

data class BackupFileDto(
    val id: Long?,
    val app_name: String,
    val file_name: String,
    val file_id: String,
    val name: String,
    val created_at: String?,
    val updated_at: String?
)

data class ListBackupsResponse(
    val files: List<BackupFileDto> = emptyList()
)

data class UploadBackupResponse(
    val message: String?,
    val file_path: String?
)
