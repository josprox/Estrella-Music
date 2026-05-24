package com.zionhuang.innertube.models

import kotlinx.serialization.Serializable

@Serializable
data class MusicResponsiveHeaderRenderer(
    val thumbnail: ThumbnailRenderer?,
    val buttons: List<Button>,
    val title: Runs,
    val subtitle: Runs,
    val secondSubtitle: Runs?,
    val straplineTextOne: Runs?,
    val description: DescriptionWrapper? = null,
    val facepile: FacepileWrapper? = null,
) {
    @Serializable
    data class Button(
        val musicPlayButtonRenderer: MusicPlayButtonRenderer?,
        val menuRenderer: Menu.MenuRenderer?,
        val toggleButtonRenderer: ToggleButtonRenderer?,
    ) {
        @Serializable
        data class MusicPlayButtonRenderer(
            val playNavigationEndpoint: NavigationEndpoint?,
        )

        @Serializable
        data class ToggleButtonRenderer(
            val defaultIcon: Icon?,
            val defaultServiceEndpoint: DefaultServiceEndpoint?,
            val toggledServiceEndpoint: ToggledServiceEndpoint?,
        )
    }
}

@Serializable
data class AvatarStackViewModel(
    val avatars: List<Avatar>?,
    val text: AvatarText?,
    val rendererContext: RendererContext?,
) {
    @Serializable
    data class Avatar(
        val avatarViewModel: AvatarViewModel?,
    )

    @Serializable
    data class AvatarViewModel(
        val image: AvatarImage?,
    )

    @Serializable
    data class AvatarImage(
        val sources: List<ImageSource>?,
    )

    @Serializable
    data class ImageSource(
        val url: String?,
    )

    @Serializable
    data class AvatarText(
        val content: String?,
    )

    @Serializable
    data class RendererContext(
        val commandContext: CommandContext?,
    )

    @Serializable
    data class CommandContext(
        val onTap: OnTap?,
    )

    @Serializable
    data class OnTap(
        val innertubeCommand: InnerTubeBrowseCommand?,
    )

    @Serializable
    data class InnerTubeBrowseCommand(
        val browseEndpoint: BrowseEndpoint?,
    )

    @Serializable
    data class BrowseEndpoint(
        val browseId: String?,
    )
}

@Serializable
data class DescriptionWrapper(
    val musicDescriptionShelfRenderer: MusicDescriptionShelfRenderer?,
)

@Serializable
data class FacepileWrapper(
    val avatarStackViewModel: AvatarStackViewModel?,
)
