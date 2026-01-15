
fun compareVersions(v1: String, v2: String): Int {
    val v1Parts = v1.removePrefix("v").removePrefix("V").split(".")
    val v2Parts = v2.removePrefix("v").removePrefix("V").split(".")
    
    val length = maxOf(v1Parts.size, v2Parts.size)
    
    for (i in 0 until length) {
        val part1 = if (i < v1Parts.size) v1Parts[i].toIntOrNull() ?: 0 else 0
        val part2 = if (i < v2Parts.size) v2Parts[i].toIntOrNull() ?: 0 else 0
        
        if (part1 > part2) return 1
        if (part1 < part2) return -1
    }
    return 0
}

val remote = "V2.2.5"
val local = "2.2.7"

println("Comparing Remote '$remote' vs Local '$local'")
if (compareVersions(remote, local) > 0) {
    println("Update Available!")
} else {
    println("No Update Needed.")
}

val remote2 = "2.3.0"
println("Comparing Remote '$remote2' vs Local '$local'")
if (compareVersions(remote2, local) > 0) {
    println("Update Available!")
} else {
    println("No Update Needed.")
}
