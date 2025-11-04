package com.zionhuang.music.ui.screens

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
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.PagerState
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.SkipNext
import androidx.compose.material.icons.filled.SkipPrevious
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.LocalContentColor
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.State
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.produceState
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.util.lerp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import androidx.palette.graphics.Palette
import coil.imageLoader
import coil.request.ImageRequest
import coil.size.Size
import com.zionhuang.music.R
import com.zionhuang.music.db.entities.ArtistStats
import com.zionhuang.music.db.entities.SimpleWrappedData
import com.zionhuang.music.db.entities.SongStats
import com.zionhuang.music.ui.component.AlbumArt
import com.zionhuang.music.ui.component.ArtistArt
import com.zionhuang.music.viewmodels.WrappedViewModel
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlin.math.absoluteValue

@Composable
fun AnimatedGradientBackground(modifier: Modifier = Modifier) {
    val infiniteTransition = rememberInfiniteTransition(label = "gradient-transition")

    val color1 by infiniteTransition.animateColor(
        initialValue = MaterialTheme.colorScheme.primaryContainer.copy(alpha = 0.5f),
        targetValue = MaterialTheme.colorScheme.secondaryContainer.copy(alpha = 0.6f),
        animationSpec = infiniteRepeatable(
            tween(12000, easing = LinearEasing),
            RepeatMode.Reverse
        ), label = "color1"
    )
    val color2 by infiniteTransition.animateColor(
        initialValue = MaterialTheme.colorScheme.tertiaryContainer.copy(alpha = 0.6f),
        targetValue = MaterialTheme.colorScheme.primary.copy(alpha = 0.4f),
        animationSpec = infiniteRepeatable(
            tween(10000, easing = LinearEasing),
            RepeatMode.Reverse
        ), label = "color2"
    )
    val color3 by infiniteTransition.animateColor(
        initialValue = MaterialTheme.colorScheme.secondary.copy(alpha = 0.5f),
        targetValue = MaterialTheme.colorScheme.tertiary.copy(alpha = 0.5f),
        animationSpec = infiniteRepeatable(
            tween(11000, easing = LinearEasing),
            RepeatMode.Reverse
        ), label = "color3"
    )

    val gradient = Brush.linearGradient(
        colors = listOf(color1, color2, color3, color1),
        start = androidx.compose.ui.geometry.Offset(0f, 0f),
        end = androidx.compose.ui.geometry.Offset(Float.POSITIVE_INFINITY, Float.POSITIVE_INFINITY)
    )

    Box(
        modifier = modifier
            .fillMaxSize()
            .background(brush = gradient)
    )
}

@Composable
fun rememberDominantColor(
    url: String?,
    defaultColor: Color = MaterialTheme.colorScheme.surface
): State<Color> {
    val context = LocalContext.current

    return produceState(initialValue = defaultColor, key1 = url) {
        if (url.isNullOrEmpty()) {
            value = defaultColor
            return@produceState
        }

        val request = ImageRequest.Builder(context)
            .data(url)
            .size(Size(128, 128))
            .allowHardware(false)
            .build()

        try {
            val drawable = context.imageLoader.execute(request).drawable
            if (drawable != null) {
                val bitmap = (drawable as? android.graphics.drawable.BitmapDrawable)?.bitmap
                if (bitmap != null && !bitmap.isRecycled) {
                    val palette = Palette.from(bitmap).generate()
                    val dominantSwatch = palette.dominantSwatch
                        ?: palette.vibrantSwatch
                        ?: palette.mutedSwatch

                    if (dominantSwatch != null) {
                        value = Color(dominantSwatch.rgb)
                    }
                }
            }
        } catch (_: Exception) {
            value = defaultColor
        }
    }
}

fun adjustColorToPastel(color: Color, minBrightness: Float = 0.6f, maxSaturation: Float = 0.5f): Color {
    val hsv = FloatArray(3)

    // Usamos la utilidad estática de android.graphics.Color
    android.graphics.Color.colorToHSV(color.toArgb(), hsv)

    val h = hsv[0] // Hue
    var s = hsv[1] // Saturation
    var v = hsv[2] // Value (Brightness)

    // Asegurarse de que el brillo (Value) sea al menos minBrightness
    v = v.coerceAtLeast(minBrightness)
    // Asegurarse de que la saturación no exceda maxSaturation
    s = s.coerceAtMost(maxSaturation)

    // --- ¡CORRECCIÓN! Reconstruimos usando hsv, no hsl ---
    return androidx.compose.ui.graphics.Color.hsv(h, s, v, color.alpha)
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

    LaunchedEffect(Unit) {
        viewModel.loadWrappedData()
    }

    LaunchedEffect(pagerState.currentPage, pagerState.isScrollInProgress) {
        if (pagerState.isScrollInProgress || pagerState.currentPage == 5) {
            progress.stop()
        } else {
            progress.snapTo(0f)
            try {
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
                            initialOffsetY = { it / 2 },
                            animationSpec = tween(durationMillis = 700, easing = LinearEasing)
                        ) + fadeIn(animationSpec = tween(700)),
                        modifier = Modifier.fillMaxSize()
                    ) {
                        when (page) {
                            0 -> TopArtistPage(wrappedData!!.topArtists.firstOrNull())
                            1 -> TopArtistsPage(wrappedData!!.topArtists.take(5))
                            2 -> TopSongPage(wrappedData!!.topSongs.firstOrNull())
                            3 -> TopSongsPage(wrappedData!!.topSongs.take(5))
                            4 -> StatsPage(wrappedData!!)
                            5 -> SharePage(wrappedData!!.period)
                        }
                    }
                }
            }

            BottomControls(
                modifier = Modifier.align(Alignment.BottomCenter),
                pagerState = pagerState,
                progress = progress.value,
                scope = coroutineScope
            )
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
    Surface(
        modifier = modifier.fillMaxWidth(),
        shadowElevation = 8.dp,
        color = MaterialTheme.colorScheme.surface.copy(alpha = 0.7f)
    ) {
        Column(
            modifier = Modifier.navigationBarsPadding()
        ) {
            LinearProgressIndicator(
                progress = { progress },
                modifier = Modifier.fillMaxWidth(),
                color = MaterialTheme.colorScheme.primary,
                trackColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f)
            )
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(
                    onClick = {
                        scope.launch {
                            pagerState.animateScrollToPage(pagerState.currentPage - 1)
                        }
                    },
                    enabled = pagerState.currentPage > 0
                ) {
                    Icon(
                        Icons.Filled.SkipPrevious,
                        contentDescription = "Página anterior"
                    )
                }

                Text(
                    text = "${pagerState.currentPage + 1} / ${pagerState.pageCount}",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )

                IconButton(
                    onClick = {
                        scope.launch {
                            pagerState.animateScrollToPage(pagerState.currentPage + 1)
                        }
                    },
                    enabled = pagerState.currentPage < pagerState.pageCount - 1
                ) {
                    Icon(
                        Icons.Filled.SkipNext,
                        contentDescription = "Siguiente página"
                    )
                }
            }
        }
    }
}

val PageBottomPadding = 100.dp

@Composable
private fun TopArtistPage(topArtist: ArtistStats?) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceAround
    ) {
        Text(
            text = "Tu artista top",
            style = MaterialTheme.typography.headlineLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            fontWeight = FontWeight.Bold
        )

        if (topArtist != null) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                ArtistArt(
                    thumbnailUrl = topArtist.thumbnailUrl,
                    size = 240.dp,
                    modifier = Modifier.clip(CircleShape)
                )
                Spacer(modifier = Modifier.height(32.dp))
                Text(
                    text = topArtist.name,
                    style = MaterialTheme.typography.displayMedium,
                    color = MaterialTheme.colorScheme.primary,
                    fontWeight = FontWeight.ExtraBold,
                    textAlign = TextAlign.Center
                )
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "${topArtist.playCount} veces escuchado",
                    style = MaterialTheme.typography.titleLarge,
                    color = MaterialTheme.colorScheme.onBackground
                )
            }
        } else {
            Text(
                text = "No hay datos suficientes",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
        Spacer(modifier = Modifier.height(32.dp))
    }
}

@Composable
private fun TopArtistsPage(topArtists: List<ArtistStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 24.dp, vertical = 32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) {
        Text(
            text = "Tus artistas más escuchados",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground,
            modifier = Modifier.padding(top = 32.dp),
            fontWeight = FontWeight.Bold
        )

        Spacer(modifier = Modifier.height(32.dp))

        if (topArtists.isNotEmpty()) {
            LazyColumn(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp),
                contentPadding = PaddingValues(bottom = 16.dp)
            ) {
                itemsIndexed(topArtists, key = { _, artist -> artist.name }) { index, artist ->

                    AnimatedVisibility(
                        visible = true,
                        enter = fadeIn(animationSpec = tween(300, delayMillis = index * 75)) +
                                slideInVertically(
                                    initialOffsetY = { it / 2 },
                                    animationSpec = tween(400, delayMillis = index * 75)
                                ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(bottom = 4.dp)
                    ) {

                        val defaultCardColor = MaterialTheme.colorScheme.secondaryContainer
                        val cardColor by rememberDominantColor(
                            url = artist.thumbnailUrl,
                            defaultColor = defaultCardColor
                        )

                        val adjustedCardColor = remember(cardColor) {
                            adjustColorToPastel(cardColor)
                        }

                        val animatedColor by animateColorAsState(
                            targetValue = adjustedCardColor.copy(alpha = 0.9f),
                            animationSpec = tween(500), label = "cardColor"
                        )

                        Card(
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(24.dp),
                            colors = CardDefaults.cardColors(
                                containerColor = animatedColor
                            )
                        ) {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(16.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(
                                    text = "${index + 1}.",
                                    style = MaterialTheme.typography.titleMedium,
                                    fontWeight = FontWeight.ExtraBold,
                                    modifier = Modifier.padding(end = 8.dp)
                                )
                                ArtistArt(
                                    thumbnailUrl = artist.thumbnailUrl,
                                    size = 56.dp,
                                    modifier = Modifier.clip(CircleShape)
                                )
                                Spacer(modifier = Modifier.width(16.dp))
                                Column(
                                    modifier = Modifier.weight(1f)
                                ) {
                                    Text(
                                        text = artist.name,
                                        style = MaterialTheme.typography.titleLarge,
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis,
                                        fontWeight = FontWeight.Bold
                                    )
                                    Text(
                                        text = "${artist.playCount} plays",
                                        style = MaterialTheme.typography.labelMedium,
                                        color = LocalContentColor.current.copy(alpha = 0.8f)
                                    )
                                }
                            }
                        }
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
            .padding(32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceAround
    ) {
        Text(
            text = "Tu canción del año",
            style = MaterialTheme.typography.headlineLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            fontWeight = FontWeight.Bold
        )

        if (topSong != null) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                AlbumArt(
                    thumbnailUrl = topSong.thumbnailUrl ?: topSong.getFallbackThumbnail(),
                    size = 280.dp,
                    modifier = Modifier.clip(RoundedCornerShape(32.dp))
                )
                Spacer(modifier = Modifier.height(32.dp))
                Text(
                    text = topSong.title,
                    style = MaterialTheme.typography.displaySmall,
                    color = MaterialTheme.colorScheme.primary,
                    fontWeight = FontWeight.ExtraBold,
                    textAlign = TextAlign.Center
                )
                Spacer(modifier = Modifier.height(8.dp))
                topSong.albumName?.let { albumName ->
                    Text(
                        text = albumName,
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        textAlign = TextAlign.Center,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                }
                Spacer(modifier = Modifier.height(24.dp))
                Row(
                    horizontalArrangement = Arrangement.spacedBy(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "${topSong.playCount} plays",
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onBackground
                    )
                    Text(
                        text = "•",
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f)
                    )
                    Text(
                        text = formatDuration(topSong.duration),
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f)
                    )
                }
            }
        } else {
            Text(
                text = "No hay datos suficientes",
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.onBackground.copy(alpha = 0.7f),
                textAlign = TextAlign.Center
            )
        }
        Spacer(modifier = Modifier.height(32.dp))
    }
}

@Composable
private fun TopSongsPage(topSongs: List<SongStats>) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 24.dp, vertical = 32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) {
        Text(
            text = "Tus canciones más escuchadas",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground,
            modifier = Modifier.padding(top = 32.dp),
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(32.dp))
        if (topSongs.isNotEmpty()) {
            LazyColumn(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp),
                contentPadding = PaddingValues(bottom = 16.dp)
            ) {
                itemsIndexed(topSongs, key = { _, song -> song.id }) { index, song ->

                    AnimatedVisibility(
                        visible = true,
                        enter = fadeIn(animationSpec = tween(300, delayMillis = index * 75)) +
                                slideInVertically(
                                    initialOffsetY = { it / 2 },
                                    animationSpec = tween(400, delayMillis = index * 75)
                                ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(bottom = 4.dp)
                    ) {
                        val defaultCardColor = MaterialTheme.colorScheme.tertiaryContainer
                        val cardColor by rememberDominantColor(
                            url = song.thumbnailUrl ?: song.getFallbackThumbnail(),
                            defaultColor = defaultCardColor
                        )

                        val adjustedCardColor = remember(cardColor) {
                            adjustColorToPastel(cardColor)
                        }

                        val animatedColor by animateColorAsState(
                            targetValue = adjustedCardColor.copy(alpha = 0.9f),
                            animationSpec = tween(500), label = "cardColor"
                        )

                        Card(
                            modifier = Modifier.fillMaxWidth(),
                            shape = RoundedCornerShape(24.dp),
                            colors = CardDefaults.cardColors(
                                containerColor = animatedColor
                            )
                        ) {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(16.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                AlbumArt(
                                    thumbnailUrl = song.thumbnailUrl ?: song.getFallbackThumbnail(),
                                    size = 64.dp,
                                    modifier = Modifier.clip(RoundedCornerShape(16.dp))
                                )
                                Spacer(modifier = Modifier.width(16.dp))
                                Column(
                                    modifier = Modifier.weight(1f)
                                ) {
                                    Text(
                                        text = "${index + 1}. ${song.title}",
                                        style = MaterialTheme.typography.titleLarge,
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis,
                                        fontWeight = FontWeight.Bold
                                    )
                                    song.albumName?.let { albumName ->
                                        Text(
                                            text = albumName,
                                            style = MaterialTheme.typography.bodyMedium,
                                            color = LocalContentColor.current.copy(alpha = 0.8f),
                                            maxLines = 1,
                                            overflow = TextOverflow.Ellipsis
                                        )
                                    }
                                }
                                Spacer(modifier = Modifier.width(16.dp))
                                Text(
                                    text = "${song.playCount}",
                                    style = MaterialTheme.typography.titleMedium,
                                    fontWeight = FontWeight.Bold
                                )
                            }
                        }
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

@Composable
private fun StatsPage(wrappedData: SimpleWrappedData) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 24.dp, vertical = 32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) {
        Text(
            text = "Tus estadísticas",
            style = MaterialTheme.typography.headlineMedium,
            color = MaterialTheme.colorScheme.onBackground,
            modifier = Modifier.padding(top = 32.dp),
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(32.dp))
        FlowRow(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            maxItemsInEachRow = 2
        ) {
            StatItem("Artistas diferentes", wrappedData.uniqueArtistsCount.toString(), modifier = Modifier.weight(1f))
            StatItem("Canciones diferentes", wrappedData.uniqueSongsCount.toString(), modifier = Modifier.weight(1f))
            StatItem("Tiempo total", formatListeningTime(wrappedData.totalListeningTime), modifier = Modifier.weight(1f))
            StatItem("Artista top", wrappedData.topArtists.firstOrNull()?.name ?: "N/A", modifier = Modifier.fillMaxWidth())
            StatItem("Canción top", wrappedData.topSongs.firstOrNull()?.title ?: "N/A", modifier = Modifier.fillMaxWidth())
        }
    }
}

@Composable
private fun SharePage(year: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp)
            .padding(bottom = PageBottomPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceEvenly
    ) {
        Icon(
            painterResource(id = R.drawable.joss_music_logo),
            contentDescription = "Icono de la aplicación",
            modifier = Modifier.size(80.dp),
            tint = Color.Unspecified
        )
        Text(
            text = "Tu Wrapped $year",
            style = MaterialTheme.typography.displayLarge,
            color = MaterialTheme.colorScheme.primary,
            fontWeight = FontWeight.ExtraBold,
            textAlign = TextAlign.Center
        )
        Surface(
            shape = RoundedCornerShape(32.dp),
            color = MaterialTheme.colorScheme.primaryContainer,
            tonalElevation = 4.dp
        ) {
            Text(
                text = "#MiWrapped$year",
                style = MaterialTheme.typography.displaySmall,
                color = MaterialTheme.colorScheme.onPrimaryContainer,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(horizontal = 32.dp, vertical = 16.dp)
            )
        }
        Text(
            text = "¡Gracias por este viaje musical con nosotros!",
            style = MaterialTheme.typography.headlineSmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center
        )
    }
}


// --- FUNCIONES HELPER ---

private fun SongStats.getFallbackThumbnail(): String? {
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

@Composable
private fun StatItem(label: String, value: String, modifier: Modifier = Modifier) {
    val originalBgColor = MaterialTheme.colorScheme.secondaryContainer
    val adjustedBgColor = remember(originalBgColor) {
        adjustColorToPastel(originalBgColor, minBrightness = 0.8f, maxSaturation = 0.3f)
    }
    Surface(
        modifier = modifier,
        shape = RoundedCornerShape(
            topStart = 32.dp,
            topEnd = 12.dp,
            bottomStart = 28.dp,
            bottomEnd = 16.dp
        ),
        color = adjustedBgColor.copy(alpha = 0.8f),
        tonalElevation = 2.dp
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.padding(vertical = 24.dp, horizontal = 16.dp)
        ) {
            Text(
                text = value,
                style = MaterialTheme.typography.headlineLarge,
                fontWeight = FontWeight.ExtraBold,
                textAlign = TextAlign.Center,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = label,
                style = MaterialTheme.typography.titleMedium,
                textAlign = TextAlign.Center
            )
        }
    }
}