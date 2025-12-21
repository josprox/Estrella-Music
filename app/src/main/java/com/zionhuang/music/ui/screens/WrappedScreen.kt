package com.zionhuang.music.ui.screens

import android.widget.Toast
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.animateColor
import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.slideInVertically
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.PagerState
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Share
import androidx.compose.material.icons.filled.SkipNext
import androidx.compose.material.icons.filled.SkipPrevious
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.util.lerp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.zionhuang.music.R
import com.zionhuang.music.db.entities.ArtistStats
import com.zionhuang.music.db.entities.SimpleWrappedData
import com.zionhuang.music.db.entities.SongStats
import com.zionhuang.music.ui.component.AlbumArt
import com.zionhuang.music.ui.component.ArtistArt
import com.zionhuang.music.ui.component.ShareStoryPage
import com.zionhuang.music.ui.component.StatsStoryPage
import com.zionhuang.music.ui.component.TopArtistStoryPage
import com.zionhuang.music.ui.component.TopArtistsStoryPage
import com.zionhuang.music.ui.component.TopSongStoryPage
import com.zionhuang.music.ui.component.TopSongsStoryPage
import com.zionhuang.music.utils.WrappedImageGenerator
import com.zionhuang.music.utils.isInstagramInstalled
import com.zionhuang.music.utils.isWhatsAppInstalled
import com.zionhuang.music.utils.saveBitmapToCache
import com.zionhuang.music.utils.shareBitmapGenerically
import com.zionhuang.music.utils.shareToInstagramStory
import com.zionhuang.music.utils.shareToWhatsAppStatus
import com.zionhuang.music.viewmodels.WrappedViewModel
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.math.absoluteValue

// Design Tokens for consistency
private val GradientColorsStart = Color(0xFF8E2DE2)
private val GradientColorsEnd = Color(0xFF4A00E0)
private val GradientColorsAccent = Color(0xFF00C6FF)
private val CardBack = Color.White.copy(alpha = 0.15f)
private val TextPrimary = Color.White
private val TextSecondary = Color.White.copy(alpha = 0.8f)

@Composable
fun AnimatedGradientBackground(modifier: Modifier = Modifier) {
    val infiniteTransition = rememberInfiniteTransition(label = "gradient-transition")

    val color1 by infiniteTransition.animateColor(
        initialValue = GradientColorsStart,
        targetValue = GradientColorsEnd,
        animationSpec = infiniteRepeatable(
            tween(6000, easing = LinearEasing),
            RepeatMode.Reverse
        ), label = "color1"
    )
    val color2 by infiniteTransition.animateColor(
        initialValue = GradientColorsAccent, // Cyan punch
        targetValue = GradientColorsStart, // Back to purple
        animationSpec = infiniteRepeatable(
            tween(5000, easing = LinearEasing),
            RepeatMode.Reverse
        ), label = "color2"
    )
    
    // Un gradiente diagonal más dinámico
    val gradient = Brush.linearGradient(
        colors = listOf(color1, color2, color1),
        start = androidx.compose.ui.geometry.Offset(0f, 0f),
        end = androidx.compose.ui.geometry.Offset(Float.POSITIVE_INFINITY, Float.POSITIVE_INFINITY)
    )

    Box(
        modifier = modifier
            .fillMaxSize()
            .background(brush = gradient)
    ) {
         // Capa de opacidad para asegurar legibilidad
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Black.copy(alpha = 0.2f))
        )
    }
}

@Composable
fun WrappedScreen(
    navController: NavController,
    viewModel: WrappedViewModel = hiltViewModel()
) {
    val wrappedData by viewModel.wrappedData.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()

    val pagerState = rememberPagerState(pageCount = { 6 })
    val coroutineScope = rememberCoroutineScope()

    val progress = remember { Animatable(0f) }

    // --- LÓGICA PARA COMPARTIR EN STORIES ---
    val context = LocalContext.current
    var isGeneratingStory by remember { mutableStateOf(false) }
    var showShareMenu by remember { mutableStateOf(false) }
    
    val hasInstagram = remember { isInstagramInstalled(context) }
    val hasWhatsApp = remember { isWhatsAppInstalled(context) }
    
    suspend fun shareCurrentPageAsStory(
        shareAction: (android.net.Uri) -> Unit
    ) {
        try {
            try {
                Toast.makeText(context, R.string.startingShare , Toast.LENGTH_SHORT).show()
            } catch (e: Exception) {}
        } catch (e: Exception) { e.printStackTrace() }

        showShareMenu = false
        delay(500) 

        isGeneratingStory = true
        
        try {
            val bitmap = when (pagerState.currentPage) {
                0 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    TopArtistStoryPage(wrappedData?.topArtists?.firstOrNull())
                }
                1 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    TopArtistsStoryPage(wrappedData?.topArtists?.take(5) ?: emptyList())
                }
                2 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    TopSongStoryPage(wrappedData?.topSongs?.firstOrNull())
                }
                3 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    TopSongsStoryPage(wrappedData?.topSongs?.take(5) ?: emptyList())
                }
                4 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    StatsStoryPage(wrappedData!!)
                }
                5 -> WrappedImageGenerator.generateStoryBitmap(context) {
                    ShareStoryPage(wrappedData?.period ?: "2025")
                }
                else -> return
            }
            
            val uri = saveBitmapToCache(context, bitmap)
            if (uri != null) {
                shareAction(uri)
            } else {
                try {
                    Toast.makeText(context, R.string.errorSavingImage, Toast.LENGTH_SHORT).show()
                } catch(e: Exception){}
            }
        } catch (e: Exception) {
            e.printStackTrace()
            try {
                Toast.makeText(context, "Error: ${e.message}", Toast.LENGTH_LONG).show()
            } catch (e: Exception) {}
        } finally {
            isGeneratingStory = false
            showShareMenu = false
        }
    }

    LaunchedEffect(Unit) {
        viewModel.loadWrappedData()
    }

    LaunchedEffect(pagerState.currentPage, pagerState.isScrollInProgress) {
        if (pagerState.isScrollInProgress || pagerState.currentPage == 5) {
            progress.stop()
        } else {
            progress.snapTo(0f)
            try {
                // 10 Segundos por página para apreciar el contenido
                progress.animateTo(
                    targetValue = 1f,
                    animationSpec = tween(durationMillis = 10000, easing = LinearEasing)
                )

                coroutineScope.launch {
                    if (pagerState.currentPage < 5) {
                        pagerState.animateScrollToPage(pagerState.currentPage + 1)
                    }
                }
            } catch (e: CancellationException) {
                progress.snapTo(0f)
            }
        }
    }

    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        AnimatedGradientBackground(modifier = Modifier.matchParentSize())

        if (isLoading || wrappedData == null) {
            Text(
                text = stringResource(R.string.preparingWrapped),
                style = MaterialTheme.typography.displaySmall,
                color = TextPrimary,
                modifier = Modifier.align(Alignment.Center)
            )
        } else {
            HorizontalPager(
                state = pagerState,
                modifier = Modifier.fillMaxSize()
            ) { page ->
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .graphicsLayer {
                            val pageOffset = (pagerState.currentPage - page) + pagerState.currentPageOffsetFraction
                            val scale = lerp(
                                start = 0.85f,
                                stop = 1f,
                                fraction = 1f - pageOffset.absoluteValue.coerceIn(0f, 1f)
                            )
                            scaleX = scale
                            scaleY = scale
                            alpha = lerp(
                                start = 0.4f,
                                stop = 1f,
                                fraction = 1f - pageOffset.absoluteValue.coerceIn(0f, 1f)
                            )
                        }
                ) {
                    AnimatedVisibility(
                        visible = pagerState.currentPage == page,
                        enter = slideInVertically(
                            initialOffsetY = { it / 4 }, // Entrada más suave
                            animationSpec = tween(durationMillis = 800, easing = LinearEasing)
                        ) + fadeIn(animationSpec = tween(800)),
                        modifier = Modifier.fillMaxSize()
                    ) {
                        when (page) {
                            0 -> ScreenTopArtistPage(wrappedData!!.topArtists.firstOrNull())
                            1 -> ScreenTopArtistsPage(wrappedData!!.topArtists.take(5))
                            2 -> ScreenTopSongPage(wrappedData!!.topSongs.firstOrNull())
                            3 -> ScreenTopSongsPage(wrappedData!!.topSongs.take(5))
                            4 -> ScreenStatsPage(wrappedData!!)
                            5 -> ScreenSharePage(wrappedData!!.period)
                        }
                    }
                }
            }

            // --- MENÚ DE COMPARTIR FLOTANTE Y ESTILIZADO ---
            if (!isGeneratingStory) {
                Box(
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .statusBarsPadding()
                        .padding(24.dp)
                ) {
                    // Botón con efecto Glass
                    IconButton(
                        onClick = { showShareMenu = true },
                        modifier = Modifier
                            .background(CardBack, CircleShape)
                            .size(48.dp)
                    ) {
                        Icon(
                            Icons.Filled.Share,
                            contentDescription = stringResource(R.string.share),
                            tint = TextPrimary
                        )
                    }

                    DropdownMenu(
                        expanded = showShareMenu,
                        onDismissRequest = { showShareMenu = false },
                        modifier = Modifier.background(MaterialTheme.colorScheme.surface)
                    ) {
                        if (hasInstagram) {
                            DropdownMenuItem(
                                text = { Text("Instagram Story") },
                                onClick = {
                                    coroutineScope.launch {
                                        shareCurrentPageAsStory { uri ->
                                            shareToInstagramStory(context, uri)
                                        }
                                    }
                                }
                            )
                        }
                        if (hasWhatsApp) {
                            DropdownMenuItem(
                                text = { Text("WhatsApp Status") },
                                onClick = {
                                    coroutineScope.launch {
                                        shareCurrentPageAsStory { uri ->
                                            shareToWhatsAppStatus(context, uri)
                                        }
                                    }
                                }
                            )
                        }
                        DropdownMenuItem(
                            text = { Text(stringResource(R.string.share)) },
                            onClick = {
                                coroutineScope.launch {
                                    shareCurrentPageAsStory { uri ->
                                        shareBitmapGenerically(context, uri)
                                    }
                                }
                            }
                        )
                    }
                }
            } else {
                Box(
                    modifier = Modifier
                        .align(Alignment.Center)
                        .background(
                            Color.Black.copy(alpha = 0.8f),
                            RoundedCornerShape(24.dp)
                        )
                        .padding(32.dp)
                ) {
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally,
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        androidx.compose.material3.CircularProgressIndicator(color = GradientColorsAccent)
                        Text(
                            "Creando magia...",
                            style = MaterialTheme.typography.titleMedium,
                            color = TextPrimary
                        )
                    }
                }
            }

            if (!isGeneratingStory) {
                BottomControls(
                    modifier = Modifier.align(Alignment.BottomCenter),
                    pagerState = pagerState,
                    progress = progress.value,
                    scope = coroutineScope
                )
            }
        }
    }
}

@Composable
private fun BottomControls(
    modifier: Modifier = Modifier,
    pagerState: PagerState,
    progress: Float,
    scope: CoroutineScope
) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .navigationBarsPadding()
            .padding(bottom = 16.dp)
    ) {
        LinearProgressIndicator(
            progress = { progress },
            modifier = Modifier
                .fillMaxWidth()
                .height(4.dp), // Más delgado y elegante
            color = TextPrimary,
            trackColor = TextPrimary.copy(alpha = 0.3f)
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = { scope.launch { pagerState.animateScrollToPage(pagerState.currentPage - 1) } },
                enabled = pagerState.currentPage > 0
            ) {
                Icon(
                    Icons.Filled.SkipPrevious,
                    contentDescription = "Anterior",
                    tint = TextPrimary.copy(alpha = if (pagerState.currentPage > 0) 1f else 0.3f),
                    modifier = Modifier.size(32.dp)
                )
            }

            // Indicador de página discreto
            Surface(
                color = CardBack,
                shape = CircleShape
            ) {
                Text(
                    text = "${pagerState.currentPage + 1} / ${pagerState.pageCount}",
                    style = MaterialTheme.typography.labelLarge,
                    color = TextPrimary,
                    modifier = Modifier.padding(horizontal = 12.dp, vertical = 6.dp)
                )
            }

            IconButton(
                onClick = { scope.launch { pagerState.animateScrollToPage(pagerState.currentPage + 1) } },
                enabled = pagerState.currentPage < pagerState.pageCount - 1
            ) {
                Icon(
                    Icons.Filled.SkipNext,
                    contentDescription = "Siguiente",
                    tint = TextPrimary.copy(alpha = if (pagerState.currentPage < pagerState.pageCount - 1) 1f else 0.3f),
                    modifier = Modifier.size(32.dp)
                )
            }
        }
    }
}

// --- SCREEN VERSIONS OF PAGES (Adapted for in-app viewing) ---
// These are similar to Story versions but optimized for the app screen layout (padding, interactive elements if any)

val ScreenPagePadding = 100.dp 

@Composable
private fun ScreenTopArtistPage(topArtist: ArtistStats?) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Spacer(modifier = Modifier.weight(1f))
        
        Text(
            text = stringResource(R.string.yourTopArtist).uppercase(),
            style = MaterialTheme.typography.titleMedium,
            color = TextSecondary,
            letterSpacing = 2.sp,
            fontWeight = FontWeight.Bold
        )
        
        Spacer(modifier = Modifier.height(32.dp))

        if (topArtist != null) {
            Box(contentAlignment = Alignment.Center) {
                // Glow bg
                Box(
                    modifier = Modifier
                        .size(260.dp)
                        .clip(CircleShape)
                        .background(Color.White.copy(alpha = 0.1f))
                )
                ArtistArt(
                    thumbnailUrl = topArtist.thumbnailUrl,
                    size = 240.dp,
                    modifier = Modifier
                        .clip(CircleShape)
                        .background(CardBack)
                )
            }
            Spacer(modifier = Modifier.height(40.dp))
            Text(
                text = topArtist.name,
                style = MaterialTheme.typography.displayMedium.copy(fontSize = 42.sp),
                color = TextPrimary,
                fontWeight = FontWeight.Black,
                textAlign = TextAlign.Center
            )
            Spacer(modifier = Modifier.height(16.dp))
            Surface(color = CardBack, shape = RoundedCornerShape(100.dp)) {
                Text(
                    text = "${topArtist.playCount} ${stringResource(R.string.timesHeard)}",
                    style = MaterialTheme.typography.titleMedium,
                    color = TextPrimary,
                    modifier = Modifier.padding(horizontal = 24.dp, vertical = 12.dp)
                )
            }
        } else {
             Text(text = stringResource(R.string.library_artist_empty), color = TextSecondary)
        }
        Spacer(modifier = Modifier.weight(1f))
    }
}

@Composable
private fun ScreenTopSongPage(topSong: SongStats?) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Spacer(modifier = Modifier.weight(0.5f))
        
        Text(
            text = stringResource(R.string.yourSongTheYear).uppercase(),
            style = MaterialTheme.typography.titleMedium,
            color = TextSecondary,
            letterSpacing = 2.sp,
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(48.dp))

        if (topSong != null) {
            Card(
                shape = RoundedCornerShape(16.dp),
                elevation = CardDefaults.cardElevation(defaultElevation = 12.dp),
                modifier = Modifier.size(280.dp)
            ) {
                AlbumArt(
                    thumbnailUrl = topSong.thumbnailUrl,
                    size = 280.dp,
                    modifier = Modifier.fillMaxSize()
                )
            }

            Spacer(modifier = Modifier.height(40.dp))

            Text(
                text = topSong.title,
                style = MaterialTheme.typography.displaySmall.copy(fontWeight = FontWeight.Black),
                color = TextPrimary,
                textAlign = TextAlign.Center,
                maxLines = 3,
                overflow = TextOverflow.Ellipsis
            )
            
            Spacer(modifier = Modifier.height(8.dp))
            topSong.albumName?.let {
                Text(
                    text = it,
                    style = MaterialTheme.typography.titleLarge,
                    color = TextSecondary,
                    textAlign = TextAlign.Center,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
            }
            Spacer(modifier = Modifier.height(24.dp))
            Surface(color = CardBack, shape = RoundedCornerShape(16.dp)) {
                Text(
                    text = "${topSong.playCount} plays",
                    style = MaterialTheme.typography.headlineSmall,
                    color = TextPrimary,
                    modifier = Modifier.padding(horizontal = 24.dp, vertical = 12.dp),
                    fontWeight = FontWeight.Bold
                )
            }
        } else {
            Text(text = stringResource(R.string.library_song_empty), color = TextSecondary)
        }
        Spacer(modifier = Modifier.weight(1f))
    }
}

@Composable
private fun ScreenTopArtistsPage(topArtists: List<ArtistStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Spacer(modifier = Modifier.height(48.dp))
        Text(
            text = stringResource(R.string.mostListArtists),
            style = MaterialTheme.typography.headlineLarge,
            color = TextPrimary,
            fontWeight = FontWeight.Black,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(32.dp))

        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(16.dp),
            contentPadding = PaddingValues(bottom = 16.dp)
        ) {
            itemsIndexed(topArtists) { index, artist ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(CardBack, RoundedCornerShape(16.dp))
                        .padding(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "${index + 1}",
                        style = MaterialTheme.typography.headlineSmall,
                        color = TextSecondary,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.width(32.dp)
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
                            color = TextPrimary,
                            fontWeight = FontWeight.Bold,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                        Text(
                            text = "${artist.playCount} plays",
                            style = MaterialTheme.typography.bodyMedium,
                            color = TextSecondary
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun ScreenTopSongsPage(topSongs: List<SongStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Spacer(modifier = Modifier.height(48.dp))
        Text(
            text = stringResource(R.string.yourMostListenedSongs),
            style = MaterialTheme.typography.headlineLarge,
            color = TextPrimary,
            fontWeight = FontWeight.Black,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(32.dp))

        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(16.dp),
            contentPadding = PaddingValues(bottom = 16.dp)
        ) {
            itemsIndexed(topSongs) { index, song ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(CardBack, RoundedCornerShape(16.dp))
                        .padding(12.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "${index + 1}",
                        style = MaterialTheme.typography.headlineSmall,
                        color = TextSecondary,
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
                            color = TextPrimary,
                            fontWeight = FontWeight.Bold,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    }
                    Text(
                        text = "${song.playCount}",
                        style = MaterialTheme.typography.bodyMedium,
                        color = TextPrimary,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
}

@Composable
private fun ScreenStatsPage(wrappedData: SimpleWrappedData) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = stringResource(R.string.stats).uppercase(),
            style = MaterialTheme.typography.displayMedium,
            color = TextPrimary,
            fontWeight = FontWeight.Black,
            letterSpacing = 4.sp
        )
        
        Spacer(modifier = Modifier.height(48.dp))
        
        ScreenStatCard(stringResource(R.string.artists), wrappedData.uniqueArtistsCount.toString())
        Spacer(modifier = Modifier.height(16.dp))
        ScreenStatCard(stringResource(R.string.songs), wrappedData.uniqueSongsCount.toString())
        Spacer(modifier = Modifier.height(16.dp))
        ScreenStatCard(stringResource(R.string.sort_by_play_time), formatDuration(wrappedData.totalListeningTime))
    }
}

@Composable
private fun ScreenStatCard(label: String, value: String) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .background(CardBack, RoundedCornerShape(24.dp))
            .padding(24.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = value,
            style = MaterialTheme.typography.displaySmall,
            color = TextPrimary,
            fontWeight = FontWeight.Bold
        )
        Text(
            text = label.uppercase(),
            style = MaterialTheme.typography.labelMedium,
            color = TextSecondary,
            letterSpacing = 1.sp
        )
    }
}

@Composable
private fun ScreenSharePage(period: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = ScreenPagePadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Icon(
            painterResource(id = R.drawable.joss_music_logo),
            contentDescription = null,
            modifier = Modifier.size(120.dp),
            tint = TextPrimary
        )
        
        Spacer(modifier = Modifier.height(24.dp))
        
        Text(
            text = "ESTRELLA MUSIC",
            style = MaterialTheme.typography.titleMedium,
            color = TextSecondary,
            fontWeight = FontWeight.Bold,
            letterSpacing = 4.sp
        )
        
        Spacer(modifier = Modifier.height(48.dp))
        
        Text(
            text = stringResource(R.string.yourWrapped),
            style = MaterialTheme.typography.displaySmall,
            color = TextPrimary,
            fontWeight = FontWeight.Light
        )
        
        Text(
            text = period,
            style = MaterialTheme.typography.displayLarge.copy(fontSize = 80.sp),
            color = TextPrimary,
            fontWeight = FontWeight.Black
        )
        
        Spacer(modifier = Modifier.height(32.dp))
        
        Surface(
            color = Color.White,
            shape = RoundedCornerShape(100.dp)
        ) {
            Text(
                text = "#MiWrapped$period",
                style = MaterialTheme.typography.headlineSmall,
                color = Color.Black,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(horizontal = 48.dp, vertical = 16.dp)
            )
        }
        
        Spacer(modifier = Modifier.height(48.dp))
        
        Text(
             text = stringResource(R.string.tUThisMusicaWUS),
             style = MaterialTheme.typography.bodyLarge,
             color = TextSecondary,
             textAlign = TextAlign.Center
        )
    }
}

private fun formatDuration(millis: Long): String {
    val hours = millis / (1000 * 60 * 60)
    val minutes = (millis % (1000 * 60 * 60)) / (1000 * 60)
    return "${hours}h ${minutes}m"
}