// En WrappedScreen.kt, actualiza las páginas:
package com.zionhuang.music.ui.screens

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.zionhuang.music.db.entities.ArtistStats
import com.zionhuang.music.db.entities.SimpleWrappedData
import com.zionhuang.music.db.entities.SongStats
import com.zionhuang.music.ui.component.AlbumArt
import com.zionhuang.music.ui.component.ArtistArt
import com.zionhuang.music.viewmodels.WrappedViewModel
import kotlinx.coroutines.delay
import java.util.concurrent.TimeUnit

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun WrappedScreen(
    navController: NavController,
    viewModel: WrappedViewModel = hiltViewModel()
) {
    val wrappedData by viewModel.wrappedData.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()

    val pagerState = rememberPagerState(pageCount = { 7 }) // Añadimos una página más
    var currentPage by remember { mutableStateOf(0) }

    LaunchedEffect(Unit) {
        viewModel.loadWrappedData()
    }

    LaunchedEffect(pagerState.currentPage) {
        currentPage = pagerState.currentPage
    }

    // Auto-advance pages
    LaunchedEffect(currentPage) {
        if (currentPage < 6) { // Ajustado para 7 páginas
            delay(TimeUnit.SECONDS.toMillis(5))
            pagerState.animateScrollToPage(currentPage + 1)
        }
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(MaterialTheme.colorScheme.background)
    ) {
        if (isLoading || wrappedData == null) {
            // Loading screen
            Text(
                text = "Preparando tu Wrapped...",
                style = MaterialTheme.typography.headlineMedium,
                color = MaterialTheme.colorScheme.onBackground,
                modifier = Modifier.align(Alignment.Center)
            )
        } else {
            HorizontalPager(
                state = pagerState,
                modifier = Modifier.fillMaxSize()
            ) { page ->
                when (page) {
                    0 -> WelcomePage(wrappedData!!.period)
                    1 -> TopArtistPage(wrappedData!!.topArtists.firstOrNull())
                    2 -> TopArtistsPage(wrappedData!!.topArtists.take(5))
                    3 -> TopSongPage(wrappedData!!.topSongs.firstOrNull())
                    4 -> TopSongsPage(wrappedData!!.topSongs.take(5)) // Nueva página
                    5 -> StatsPage(wrappedData!!)
                    6 -> SharePage(wrappedData!!.period)
                }
            }

            // Page indicators
            Row(
                modifier = Modifier
                    .align(Alignment.TopCenter)
                    .padding(top = 32.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                repeat(7) { index -> // Ajustado para 7 páginas
                    Box(
                        modifier = Modifier
                            .size(8.dp)
                            .clip(CircleShape)
                            .background(
                                if (index == currentPage)
                                    MaterialTheme.colorScheme.primary
                                else
                                    MaterialTheme.colorScheme.onBackground.copy(alpha = 0.3f)
                            )
                    )
                }
            }
        }
    }
}

@Composable
private fun WelcomePage(year: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tu Wrapped $year",
            style = MaterialTheme.typography.displayLarge,
            color = MaterialTheme.colorScheme.primary,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )

        Spacer(modifier = Modifier.height(24.dp))

        Text(
            text = "Un viaje por tu música del año",
            style = MaterialTheme.typography.headlineSmall,
            color = MaterialTheme.colorScheme.onBackground,
            textAlign = TextAlign.Center
        )
    }
}

@Composable
private fun TopArtistPage(topArtist: ArtistStats?) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tu artista top",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground
        )

        Spacer(modifier = Modifier.height(32.dp))

        if (topArtist != null) {
            // Mostrar imagen del artista
            ArtistArt(
                thumbnailUrl = topArtist.thumbnailUrl,
                size = 180.dp
            )

            Spacer(modifier = Modifier.height(24.dp))

            Text(
                text = topArtist.name,
                style = MaterialTheme.typography.displayMedium,
                color = MaterialTheme.colorScheme.primary,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "${topArtist.playCount} veces escuchado",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground
            )
        } else {
            Text(
                text = "No hay datos suficientes",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
private fun TopArtistsPage(topArtists: List<ArtistStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tus artistas más escuchados",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground
        )

        Spacer(modifier = Modifier.height(32.dp))

        if (topArtists.isNotEmpty()) {
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                topArtists.forEachIndexed { index, artist ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 8.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        // Imagen del artista
                        ArtistArt(
                            thumbnailUrl = artist.thumbnailUrl,
                            size = 50.dp,
                            modifier = Modifier.weight(0.2f)
                        )

                        // Nombre del artista
                        Text(
                            text = "${index + 1}. ${artist.name}",
                            style = MaterialTheme.typography.titleLarge,
                            color = MaterialTheme.colorScheme.onBackground,
                            modifier = Modifier.weight(0.6f)
                        )

                        // Contador de reproducciones
                        Text(
                            text = "${artist.playCount}",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                            modifier = Modifier.weight(0.2f)
                        )
                    }
                }
            }
        } else {
            Text(
                text = "No hay datos de artistas",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
private fun TopSongPage(topSong: SongStats?) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tu canción del año",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground
        )

        Spacer(modifier = Modifier.height(32.dp))

        if (topSong != null) {
            // Mostrar carátula del álbum
            AlbumArt(
                thumbnailUrl = topSong.thumbnailUrl ?: topSong.getFallbackThumbnail(),
                size = 200.dp
            )

            Spacer(modifier = Modifier.height(24.dp))

            Text(
                text = topSong.title,
                style = MaterialTheme.typography.displaySmall,
                color = MaterialTheme.colorScheme.primary,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(8.dp))

            // Mostrar álbum si está disponible
            topSong.albumName?.let { albumName ->
                Text(
                    text = "Del álbum: $albumName",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.8f),
                    textAlign = TextAlign.Center
                )
            }

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = "${topSong.playCount} veces reproducida",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground
            )

            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = formatDuration(topSong.duration),
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f)
            )
        } else {
            Text(
                text = "No hay datos suficientes",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
    }
}

@Composable
private fun TopSongsPage(topSongs: List<SongStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tus canciones más escuchadas",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground
        )

        Spacer(modifier = Modifier.height(32.dp))

        if (topSongs.isNotEmpty()) {
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                topSongs.forEachIndexed { index, song ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 8.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        // Carátula de la canción/álbum
                        AlbumArt(
                            thumbnailUrl = song.thumbnailUrl ?: song.getFallbackThumbnail(),
                            size = 50.dp,
                            modifier = Modifier.weight(0.2f)
                        )

                        // Información de la canción
                        Column(
                            modifier = Modifier.weight(0.6f)
                        ) {
                            Text(
                                text = "${index + 1}. ${song.title}",
                                style = MaterialTheme.typography.titleMedium,
                                color = MaterialTheme.colorScheme.onBackground,
                                maxLines = 1
                            )
                            song.albumName?.let { albumName ->
                                Text(
                                    text = albumName,
                                    style = MaterialTheme.typography.bodySmall,
                                    color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                                    maxLines = 1
                                )
                            }
                        }

                        // Contador de reproducciones
                        Text(
                            text = "${song.playCount}",
                            style = MaterialTheme.typography.bodyMedium,
                            color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                            modifier = Modifier.weight(0.2f)
                        )
                    }
                }
            }
        } else {
            Text(
                text = "No hay datos de canciones",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
    }
}

// ... (el resto de las funciones StatsPage, SharePage, etc. se mantienen igual)

// Función de extensión para obtener thumbnail por defecto
private fun SongStats.getFallbackThumbnail(): String? {
    // Puedes retornar una imagen por defecto o null
    return this.thumbnailUrl
}

private fun formatListeningTime(millis: Long): String {
    val hours = millis / (1000 * 60 * 60)
    val minutes = (millis % (1000 * 60 * 60)) / (1000 * 60)
    return "${hours}h ${minutes}m"
}

private fun formatDuration(seconds: Int): String {
    val minutes = seconds / 60
    val remainingSeconds = seconds % 60
    return String.format("%d:%02d", minutes, remainingSeconds)
}

// Mantén las funciones StatItem, StatsPage y SharePage igual que antes
@Composable
private fun StatsPage(wrappedData: SimpleWrappedData) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Tus estadísticas",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground
        )

        Spacer(modifier = Modifier.height(32.dp))

        StatItem("Artistas diferentes", wrappedData.uniqueArtistsCount.toString())
        Spacer(modifier = Modifier.height(16.dp))
        StatItem("Canciones diferentes", wrappedData.uniqueSongsCount.toString())
        Spacer(modifier = Modifier.height(16.dp))
        StatItem("Tiempo total", formatListeningTime(wrappedData.totalListeningTime))
        Spacer(modifier = Modifier.height(16.dp))
        StatItem("Artista top", wrappedData.topArtists.firstOrNull()?.name ?: "N/A")
        Spacer(modifier = Modifier.height(16.dp))
        StatItem("Canción top", wrappedData.topSongs.firstOrNull()?.title ?: "N/A")
    }
}

@Composable
private fun SharePage(year: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "¡Comparte tu Wrapped!",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground,
            textAlign = TextAlign.Center
        )

        Spacer(modifier = Modifier.height(32.dp))

        Text(
            text = "#MiWrapped$year",
            style = MaterialTheme.typography.displaySmall,
            color = MaterialTheme.colorScheme.primary,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(24.dp))

        Text(
            text = "Gracias por escuchar música con nosotros",
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
            textAlign = TextAlign.Center
        )
    }
}

@Composable
private fun StatItem(label: String, value: String) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text = value,
            style = MaterialTheme.typography.displaySmall,
            color = MaterialTheme.colorScheme.primary,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )
        Text(
            text = label,
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onBackground,
            textAlign = TextAlign.Center
        )
    }
}