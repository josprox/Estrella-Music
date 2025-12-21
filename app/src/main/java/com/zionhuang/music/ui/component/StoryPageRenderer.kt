package com.zionhuang.music.ui.component

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.zionhuang.music.R
import com.zionhuang.music.db.entities.ArtistStats
import com.zionhuang.music.db.entities.SimpleWrappedData
import com.zionhuang.music.db.entities.SongStats

/**
 * Composables optimizados para renderizar páginas del Wrapped en formato 9:16 (Stories).
 * Diseño: "Vibrant & Glassy"
 */

private val GradientColors = listOf(
    Color(0xFF8E2DE2), // Purple
    Color(0xFF4A00E0), // Deep Purple
    Color(0xFF00C6FF)  // Cyan
)

private val CardBackgroundColor = Color.White.copy(alpha = 0.15f)
private val TextColorPrimary = Color.White
private val TextColorSecondary = Color.White.copy(alpha = 0.8f)

@Composable
fun StoryGradientBackground(
    modifier: Modifier = Modifier
) {
    Box(
        modifier = modifier
            .fillMaxSize()
            .background(
                brush = Brush.verticalGradient(
                    colors = GradientColors
                )
            )
    ) {
        // Overlay de ruido o textura sutil si fuera posible, por ahora un overlay oscuro muy suave
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Black.copy(alpha = 0.1f))
        )
    }
}

@Composable
fun TopArtistStoryPage(topArtist: ArtistStats?) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Spacer(modifier = Modifier.weight(1f))
            
            Text(
                text = stringResource(R.string.yourTopArtist).uppercase(),
                style = MaterialTheme.typography.titleMedium,
                color = TextColorSecondary,
                letterSpacing = 2.sp,
                fontWeight = FontWeight.Bold
            )
            
            Spacer(modifier = Modifier.height(32.dp))

            if (topArtist != null) {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier = Modifier
                        .size(340.dp)
                ) {
                    // Glow effect
                    Box(
                        modifier = Modifier
                            .size(320.dp)
                            .clip(CircleShape)
                            .background(Color.White.copy(alpha = 0.2f))
                    )
                    
                    ArtistArt(
                        thumbnailUrl = topArtist.thumbnailUrl,
                        size = 300.dp,
                        modifier = Modifier
                            .clip(CircleShape)
                            .background(MaterialTheme.colorScheme.surfaceVariant)
                    )
                }
                
                Spacer(modifier = Modifier.height(48.dp))
                
                Text(
                    text = topArtist.name,
                    style = MaterialTheme.typography.displayLarge.copy(
                        fontSize = 48.sp,
                        lineHeight = 52.sp
                    ),
                    color = TextColorPrimary,
                    fontWeight = FontWeight.Black,
                    textAlign = TextAlign.Center
                )
                
                Spacer(modifier = Modifier.height(16.dp))
                
                Surface(
                    color = CardBackgroundColor,
                    shape = RoundedCornerShape(100.dp)
                ) {
                    Text(
                        text = "${topArtist.playCount} ${stringResource(R.string.timesHeard)}",
                        style = MaterialTheme.typography.titleMedium,
                        color = TextColorPrimary,
                        modifier = Modifier.padding(horizontal = 24.dp, vertical = 12.dp)
                    )
                }
            } else {
                Text(
                    text = stringResource(R.string.library_artist_empty),
                    color = TextColorSecondary
                )
            }

            Spacer(modifier = Modifier.weight(1f))
            
            JossLogo()
        }
    }
}

@Composable
fun TopSongStoryPage(topSong: SongStats?) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.weight(0.8f))
            
            Text(
                text = stringResource(R.string.yourSongTheYear).uppercase(),
                style = MaterialTheme.typography.titleMedium,
                color = TextColorSecondary,
                letterSpacing = 2.sp,
                fontWeight = FontWeight.Bold
            )

            Spacer(modifier = Modifier.height(48.dp))

            if (topSong != null) {
                // Estilo "Vinilo" o portada grande
                Card(
                    shape = RoundedCornerShape(16.dp),
                    elevation = CardDefaults.cardElevation(defaultElevation = 12.dp),
                    modifier = Modifier.size(320.dp)
                ) {
                    AlbumArt(
                        thumbnailUrl = topSong.thumbnailUrl,
                        size = 320.dp,
                        modifier = Modifier.fillMaxSize()
                    )
                }

                Spacer(modifier = Modifier.height(48.dp))

                Text(
                    text = topSong.title,
                    style = MaterialTheme.typography.displayMedium.copy(fontWeight = FontWeight.Black),
                    color = TextColorPrimary,
                    textAlign = TextAlign.Center,
                    maxLines = 3,
                    overflow = TextOverflow.Ellipsis
                )
                
                Spacer(modifier = Modifier.height(8.dp))
                
                topSong.albumName?.let {
                    Text(
                        text = it,
                        style = MaterialTheme.typography.titleLarge,
                        color = TextColorSecondary,
                        textAlign = TextAlign.Center,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                }
                
                Spacer(modifier = Modifier.height(24.dp))
                
                Surface(
                    color = CardBackgroundColor,
                    shape = RoundedCornerShape(16.dp)
                ) {
                    Text(
                        text = "${topSong.playCount} plays",
                        style = MaterialTheme.typography.headlineSmall,
                        color = TextColorPrimary,
                        modifier = Modifier.padding(horizontal = 24.dp, vertical = 12.dp),
                        fontWeight = FontWeight.Bold
                    )
                }
            } else {
                Text(text = stringResource(R.string.library_song_empty), color = TextColorSecondary)
            }

            Spacer(modifier = Modifier.weight(1f))
            
            JossLogo()
        }
    }
}

@Composable
fun TopArtistsStoryPage(topArtists: List<ArtistStats>) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(64.dp))
            
            Text(
                text = stringResource(R.string.mostListArtists),
                style = MaterialTheme.typography.displaySmall,
                color = TextColorPrimary,
                fontWeight = FontWeight.Black,
                textAlign = TextAlign.Center,
                lineHeight = 40.sp
            )
            
            Spacer(modifier = Modifier.height(48.dp))
            
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier.fillMaxWidth()
            ) {
                topArtists.take(5).forEachIndexed { index, artist ->
                    GlassArtistItem(index = index + 1, artist = artist)
                }
            }
            
            Spacer(modifier = Modifier.weight(1f))
            
            JossLogo()
        }
    }
}

@Composable
fun TopSongsStoryPage(topSongs: List<SongStats>) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(64.dp))
            
            Text(
                text = stringResource(R.string.yourMostListenedSongs),
                style = MaterialTheme.typography.displaySmall,
                color = TextColorPrimary,
                fontWeight = FontWeight.Black,
                textAlign = TextAlign.Center,
                lineHeight = 40.sp
            )
            
            Spacer(modifier = Modifier.height(48.dp))
            
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp),
                modifier = Modifier.fillMaxWidth()
            ) {
                topSongs.take(5).forEachIndexed { index, song ->
                    GlassSongItem(index = index + 1, song = song)
                }
            }
            
            Spacer(modifier = Modifier.weight(1f))
            
            JossLogo()
        }
    }
}

@Composable
fun StatsStoryPage(wrappedData: SimpleWrappedData) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = stringResource(R.string.stats).uppercase(),
                style = MaterialTheme.typography.headlineLarge,
                color = TextColorPrimary,
                fontWeight = FontWeight.Black,
                letterSpacing = 4.sp
            )
            
            Spacer(modifier = Modifier.height(64.dp))
            
            GlassStatCard(
                label = stringResource(R.string.artists),
                value = wrappedData.uniqueArtistsCount.toString()
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            GlassStatCard(
                label = stringResource(R.string.songs),
                value = wrappedData.uniqueSongsCount.toString()
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            GlassStatCard(
                label = stringResource(R.string.sort_by_play_time),
                value = formatListeningTime(wrappedData.totalListeningTime)
            )
            
            Spacer(modifier = Modifier.height(64.dp))
            
            JossLogo()
        }
    }
}

@Composable
fun ShareStoryPage(year: String) {
    Box(modifier = Modifier.fillMaxSize()) {
        StoryGradientBackground()
        
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Icon(
                painterResource(id = R.drawable.joss_music_logo),
                contentDescription = null,
                modifier = Modifier.size(140.dp),
                tint = TextColorPrimary
            )
            
            Spacer(modifier = Modifier.height(24.dp))
            
            Text(
                text = "ESTRELLA MUSIC",
                style = MaterialTheme.typography.titleMedium,
                color = TextColorSecondary,
                fontWeight = FontWeight.Bold,
                letterSpacing = 4.sp
            )
            
            Spacer(modifier = Modifier.height(64.dp))
            
            Text(
                text = "${stringResource(R.string.yourWrapped)}",
                style = MaterialTheme.typography.displayMedium,
                color = TextColorPrimary,
                fontWeight = FontWeight.Light
            )
            
            Text(
                text = year,
                style = MaterialTheme.typography.displayLarge.copy(fontSize = 90.sp),
                color = TextColorPrimary,
                fontWeight = FontWeight.Black
            )
            
            Spacer(modifier = Modifier.height(48.dp))
            
            Surface(
                color = Color.White,
                shape = RoundedCornerShape(100.dp)
            ) {
                Text(
                    text = "#MiWrapped$year",
                    style = MaterialTheme.typography.headlineSmall,
                    color = Color.Black,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(horizontal = 48.dp, vertical = 16.dp)
                )
            }
            
            Spacer(modifier = Modifier.height(64.dp))
            
            Text(
                text = stringResource(R.string.tUThisMusicaWUS),
                style = MaterialTheme.typography.bodyLarge,
                color = TextColorSecondary,
                textAlign = TextAlign.Center,
                modifier = Modifier.padding(horizontal = 24.dp)
            )
        }
    }
}

// --- Componentes Visuales ---

@Composable
fun JossLogo(modifier: Modifier = Modifier) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = modifier.padding(bottom = 48.dp)
    ) {
        Icon(
            painterResource(id = R.drawable.joss_music_logo),
            contentDescription = null,
            modifier = Modifier.size(48.dp),
            tint = TextColorPrimary.copy(alpha = 0.9f)
        )
        Text(
            text = "Estrella Music",
            style = MaterialTheme.typography.labelMedium,
            color = TextColorSecondary,
            modifier = Modifier.padding(top = 8.dp),
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
fun GlassArtistItem(index: Int, artist: ArtistStats) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(CardBackgroundColor, RoundedCornerShape(16.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = "$index",
            style = MaterialTheme.typography.headlineMedium,
            color = TextColorSecondary,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.width(40.dp)
        )
        
        ArtistArt(
            thumbnailUrl = artist.thumbnailUrl,
            size = 56.dp,
            modifier = Modifier.clip(CircleShape)
        )
        
        Spacer(modifier = Modifier.width(16.dp))
        
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = artist.name,
                style = MaterialTheme.typography.titleMedium,
                color = TextColorPrimary,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
            Text(
                text = "${artist.playCount} plays",
                style = MaterialTheme.typography.bodySmall,
                color = TextColorSecondary
            )
        }
    }
}

@Composable
fun GlassSongItem(index: Int, song: SongStats) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(CardBackgroundColor, RoundedCornerShape(16.dp))
            .padding(12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = "$index",
            style = MaterialTheme.typography.headlineSmall,
            color = TextColorSecondary,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.width(32.dp)
        )
        
        AlbumArt(
            thumbnailUrl = song.thumbnailUrl,
            size = 56.dp,
            modifier = Modifier.clip(RoundedCornerShape(8.dp))
        )
        
        Spacer(modifier = Modifier.width(16.dp))
        
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = song.title,
                style = MaterialTheme.typography.titleMedium,
                color = TextColorPrimary,
                fontWeight = FontWeight.Bold,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )
        }
        
        Text(
            text = "${song.playCount}",
            style = MaterialTheme.typography.bodyMedium,
            color = TextColorPrimary,
            fontWeight = FontWeight.Bold
        )
    }
}

@Composable
fun GlassStatCard(label: String, value: String) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(CardBackgroundColor, RoundedCornerShape(24.dp))
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = value,
            style = MaterialTheme.typography.displayMedium,
            color = TextColorPrimary,
            fontWeight = FontWeight.Bold
        )
        Text(
            text = label.uppercase(),
            style = MaterialTheme.typography.labelLarge,
            color = TextColorSecondary,
            letterSpacing = 1.sp
        )
    }
}

private fun formatListeningTime(millis: Long): String {
    val hours = millis / (1000 * 60 * 60)
    val minutes = (millis % (1000 * 60 * 60)) / (1000 * 60)
    return "${hours}h ${minutes}m"
}
