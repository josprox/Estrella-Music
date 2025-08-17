package com.zionhuang.music.ui.onboarding

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import androidx.compose.ui.res.stringResource
import com.zionhuang.music.R

private enum class Step { Initial, Hola, Blank, Bienvenido, Carousel }

@Composable
fun OnboardingScreen(
    items: List<CarouselItem>,
    onFinish: () -> Unit
) {
    var step by remember { mutableStateOf(Step.Initial) }

    LaunchedEffect(Unit) {
        delay(500);  step = Step.Hola
        delay(2500); step = Step.Blank
        delay(1000); step = Step.Bienvenido
        delay(3000); step = Step.Carousel
    }

    Surface(modifier = Modifier.fillMaxSize(), color = Color.Transparent) {
        Box(Modifier.fillMaxSize()) {
            AnimatedBlobsBackground(Modifier.fillMaxSize())

            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(horizontal = 24.dp),
                contentAlignment = Alignment.Center
            ) {
                AnimatedContent(
                    targetState = step,
                    transitionSpec = { fadeIn() togetherWith fadeOut() },
                    label = "onboarding"
                ) { s ->
                    when (s) {
                        Step.Hola -> Hola()
                        Step.Bienvenido -> Bienvenido()
                        Step.Carousel -> Carousel(items = items, onFinish = onFinish)
                        Step.Initial, Step.Blank -> Spacer(Modifier.height(1.dp))
                    }
                }
            }
        }
    }
}

@Composable
private fun Hola() {
    Text(
        text = stringResource(R.string.hello),
        style = MaterialTheme.typography.displayLarge.copy(fontWeight = FontWeight.SemiBold),
        color = Color.White
    )
}

@Composable
private fun Bienvenido() {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text = "Joss Red",
            style = MaterialTheme.typography.headlineLarge.copy(fontWeight = FontWeight.Bold),
            color = Color.White
        )
        Spacer(Modifier.height(12.dp))
        Text(
            text = stringResource(R.string.onboarding_brand_subtitle),
            textAlign = TextAlign.Center,
            style = MaterialTheme.typography.bodyLarge,
            color = Color.White.copy(alpha = 0.75f)
        )
    }
}

@Composable
private fun Carousel(
    items: List<CarouselItem>,
    onFinish: () -> Unit
) {
    val pagerState = rememberPagerState { items.size }
    val scope = rememberCoroutineScope()

    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = Modifier.fillMaxSize()) {
        Spacer(Modifier.height(32.dp))

        HorizontalPager(
            state = pagerState,
            modifier = Modifier
                .weight(1f)
                .fillMaxWidth()
        ) { page ->
            val item = items[page]
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center,
                modifier = Modifier.fillMaxSize()
            ) {
                Image(
                    painter = painterResource(item.imageRes),
                    contentDescription = null,
                    modifier = Modifier
                        .size(200.dp)
                        .clip(MaterialTheme.shapes.large)
                )
                Spacer(Modifier.height(32.dp))
                Text(
                    text = item.title,            // <- ya te llega de strings
                    textAlign = TextAlign.Center,
                    style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Bold),
                    color = Color.White
                )
                Spacer(Modifier.height(12.dp))
                Text(
                    text = item.description,      // <- ya te llega de strings
                    textAlign = TextAlign.Center,
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.White.copy(alpha = 0.75f)
                )
            }
        }

        Spacer(Modifier.height(16.dp))

        // Dots
        Row(horizontalArrangement = Arrangement.Center, modifier = Modifier.fillMaxWidth()) {
            repeat(items.size) { i ->
                val selected = i == pagerState.currentPage
                Box(
                    modifier = Modifier
                        .padding(end = 8.dp)
                        .height(8.dp)
                        .width(if (selected) 24.dp else 8.dp)
                        .clip(MaterialTheme.shapes.small)
                        .background(
                            if (selected) MaterialTheme.colorScheme.secondary
                            else Color.White.copy(alpha = 0.25f)
                        )
                )
            }
        }

        Spacer(Modifier.height(28.dp))

        Button(
            onClick = {
                if (pagerState.currentPage == items.lastIndex) {
                    onFinish()
                } else {
                    scope.launch { pagerState.animateScrollToPage(pagerState.currentPage + 1) }
                }
            },
            colors = ButtonDefaults.buttonColors(
                containerColor = MaterialTheme.colorScheme.secondary
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 8.dp)
        ) {
            Text(
                text = if (pagerState.currentPage == items.lastIndex)
                    stringResource(R.string.getStarted)     // "Comenzar"
                else
                    stringResource(R.string.next)      // "Siguiente"
            )
        }
        Spacer(Modifier.height(24.dp))
    }
}
