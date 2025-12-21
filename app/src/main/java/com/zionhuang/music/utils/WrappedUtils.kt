package com.zionhuang.music.utils

import java.time.LocalDate
import java.time.Month

object WrappedUtils {
    /**
     * Verifica si el Wrapped está disponible.
     * Solo disponible del 4 de Diciembre al 5 de Enero.
     */
    fun isWrappedAvailable(): Boolean {
        val today = LocalDate.now()
        val month = today.month
        val day = today.dayOfMonth

        // Diciembre 4 - 31
        if (month == Month.DECEMBER && day >= 4) {
            return true
        }

        // Enero 1 - 5
        if (month == Month.JANUARY && day <= 5) {
            return true
        }

        return false
    }
}
