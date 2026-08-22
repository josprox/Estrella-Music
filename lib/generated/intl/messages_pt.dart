// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(songTitle) => "Baixando: ${songTitle}";

  static String m1(count) => "Álbuns: ${count}";

  static String m2(count) => "Artistas: ${count}";

  static String m3(count) => "Favoritos: ${count}";

  static String m4(count) => "Listas de reprodução: ${count}";

  static String m5(count) => "Músicas: ${count}";

  static String m6(source) => "Migração concluída de ${source}.";

  static String m7(error) => "Ocorreu um erro durante a regeneração: ${error}";

  static String m8(title) => "Semelhante a ${title}";

  static String m9(current) => "Etapa ${current} de 3";

  static String m10(count) => "${count} alterações confirmadas.";

  static String m11(count) => "${count} alterações sincronizadas.";

  static String m12(statusCode) =>
      "Não foi possível pesquisar usuários (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Criar nova playlist",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped (Canalizado)"),
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Adicionar 5 minutos"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Adicionar músicas à playlist",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Adicionar à biblioteca",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Adicionar à playlist",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Álbum"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Álbum salvo!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Álbum não mais salvo!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Álbuns"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage(
      "De acordo com seus gostos",
    ),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Todos os campos são necessários",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Não testado: Ao selecionar a caixa de verificação depois de descarregar mais de 60 ficheiros, o processo pode consumir uma grande quantidade de memória e pode fazer com que o telemóvel ou a aplicação falhe. Proceda por sua conta e risco.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Informações do aplicativo",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artista salvo!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Marcador de artista removido!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Descrição não disponível!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistas"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage(
      "De acordo com seus gostos",
    ),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Codec"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Código de autenticação",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Insira um código válido de 6 dígitos ou faça login novamente.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Insira o código de 6 dígitos do seu aplicativo autenticador. Este acesso expira em 5 minutos.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Autenticação de dois fatores",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Verifique e continue",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Aceito usar meus dados...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Trouxemos o login, cadastro e recuperação de senha do projeto anterior, adaptado para este app de música.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Sua sessão fica em um armazenamento seguro e é validada com o mesmo back-end que você já estava usando.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "O arquivo .env precisa ser configurado para conectar o back-end de autenticação.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Conecte-se"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Cadastre-se"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Enviar e-mail",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirme sua senha",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "E-mail ou senha incorretos.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Insira um e-mail válido.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Falta o back-end de autenticação para ser configurado no arquivo .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Sua conta ainda não foi verificada.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Não foi possível concluir a operação.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Primeiro nome"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "Esqueci minha senha",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Enviaremos as instruções para o e-mail da sua conta.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nome@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Sobrenome"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Login realizado com sucesso",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Não foi possível enviar o e-mail.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-mail enviado.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "A conta não pôde ser criada.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Conta criada com sucesso.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Bem-vindo à Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Bem-vindo à Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Download automático de músicas favoritas",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Baixe músicas favoritas automaticamente quando adicionadas aos favoritos",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Automaticamente abrir tela de reprodução",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Ativar/desativar automaticamente abrir a tela de reprodução em tela cheia em uma seleção de música para tocar",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Retornar"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "bancos de dados encontrados",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Reprodução de música em segundo plano",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Ativar/Desativar reprodução de música em segundo plano (O aplicativo pode ser acessado a partir da bandeja do sistema quando está em execução em segundo plano)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Cópia de segurança"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Fazer cópia de segurança",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Cópia de segurança em curso...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Backup salvo com sucesso!",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Configurações de Backup e Playlists",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Salva todas as configurações, playlists e dados de login em um arquivo de backup",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Você precisa de uma sessão ativa...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Reinicie o aplicativo",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Carregar backup agora",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Quer fazer um backup?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Cópia de segurança excluída.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Ainda não há backups...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Cópia de segurança restaurada. Reinicie o aplicativo.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecione a pasta para backup",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Escolha quais dados fazer backup",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Backup carregado corretamente.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Baseado nas últimas interações",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Bitrate"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista negra da lista de reprodução",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Redefinido com sucesso!",
    ),
    "by": MessageLookupByLibrary.simpleMessage("Por"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Armazenar dados de conteúdo da tela inicial em cache",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Ative o armazenamento em cache dos dados do conteúdo da tela inicial. A tela inicial será carregada instantaneamente se esta opção estiver ativada",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Músicas baixadas"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Baixar músicas para ouvir offline consumirá espaço adicional em seu dispositivo",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "Em cache/Baixadas",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage(
      "Cancelar temporizador",
    ),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "O despertador foi cancelado",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Limpar cache de imagens",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Cache de imagens limpo com sucesso",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Clique aqui para limpar as thumbnails/imagens armazenadas em cache. (Não recomendado a menos que queira atualizar os dados das imagens armazenadas em cache)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fechar"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Fechar App"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Biblioteca na nuvem encontrada.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Uma biblioteca na nuvem foi encontrada. Este dispositivo fará o download sem substituí-lo.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "O modo nuvem está pronto. Este dispositivo funcionará como cache offline.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Faça login com segurança usando sua conta Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Acesse suas playlists, favoritos e histórico de qualquer dispositivo (Windows, Android, etc.) instantaneamente.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync: trabalhe off-line e carregue as alterações automaticamente ao recuperar a Internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Ative a sincronização na nuvem",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronização em tempo real com Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem (recomendado)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução colaborativa",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Selecione os amigos que poderão ver e editar esta playlist:",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Colaboradores atualizados corretamente.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlists da Comunidade",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Conteúdo"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. Licença GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Criar"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Criar e adicionar"),
    "customIns": MessageLookupByLibrary.simpleMessage(
      "Instância personalizada",
    ),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Selecione a Instância Personalizada",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("Descoberta diária"),
    "dark": MessageLookupByLibrary.simpleMessage("Escuro"),
    "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Remover dos downloads",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Removido dos downloads com sucesso!",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Desenvolvido e mantido por Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Desativar animações de transição",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Ative esta opção para desativar a animação de mudança de guias",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Desabilitado"),
    "discover": MessageLookupByLibrary.simpleMessage("Descubra"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Dispensar"),
    "done": MessageLookupByLibrary.simpleMessage("Preparar"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Não mostrar novamente",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "arquivos baixados encontrados",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Baixe músicas do álbum",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Não é possível baixar a música graças a uma restrição do servidor. Você pode tentar novamente",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "O download falhou devido uma falha na conexão/rede! Tente novamente",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Local do download",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Mantém seus downloads de música ativos em segundo plano.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "downloads de música",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Preparando seus downloads…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Baixando música",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Baixar lista de reprodução",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Formato do arquivo baixado",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Selecione o formato do arquivo para baixar. \"Opus\" possui a melhor qualidade",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Baixadas"),
    "duration": MessageLookupByLibrary.simpleMessage("Duração"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dinâmica"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Playlist vazia!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barra de navegação inferior",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Mudar para a barra de navegação inferior",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Ativar gestos",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Ativar gestos no título do som",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Habilitado"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Fim dessa música"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Adicionar músicas do álbum à fila",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("Colocar todas na fila"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Colocar esse som na fila",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Adicionar músicas à fila",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Episódios"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Equalizador"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Abrir equalizador do sistema",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Aconteceu algum erro!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("Ocorreu um erro"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("Erro ao jogar:"),
    "export": MessageLookupByLibrary.simpleMessage("Exportar"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exportar arquivos baixados",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Clique aqui para exportar o arquivo baixado do diretório interno do aplicativo para o diretório externo",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Erro em exportar playlist",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Erro em formatar dados da playlist",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Permissão negada quando exportando",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Espaço de armazenamento insuficiente",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Arquivos exportados com sucesso",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage("Exportar Playlist"),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reprodução como CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Não é possível importar aqui",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exportar lista de reprodução para JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Este formato pode ser importado",
    ),
    "exportToYouTubeMusic": MessageLookupByLibrary.simpleMessage(
      "Exportar para músicas do Youtube",
    ),
    "exportToYouTubeMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ele irá empurrar sua playlist (músicas <50) para a fila atual, não se esqueça de adicioná-la à playlist/salvar após abri-la no YtMusic",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Local de exportação do arquivo baixado",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("Exportando..."),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportando playlist....",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoritos"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlists em Destaque",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Arquivo não encontrado",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Continuar"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("seguido"),
    "following": MessageLookupByLibrary.simpleMessage("Seguindo"),
    "for1": MessageLookupByLibrary.simpleMessage("Para"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "favoritos esquecidos",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Amigo"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Pedido de amizade aceito",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Pedido de amizade enviado",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Amigos"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Faça login para encontrar amigos.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Amizade removida",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Álbum"),
    "genericError": MessageLookupByLibrary.simpleMessage("Erro"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Eletrônica"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip-hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("Latim"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Pop"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Pedra"),
    "gesture": MessageLookupByLibrary.simpleMessage("Gestos"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Veja o código fonte no GitHub\nSe você gosta desse projeto, não esqueça de dar uma ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Ir ao álbum"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Clique aqui para ir à página de download",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Olá mundo"),
    "high": MessageLookupByLibrary.simpleMessage("Alta"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "API URL para instância Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Início"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Quantidade de conteúdo da página Inicial",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Selecione o número de conteúdos da tela inicial (aproximado). Menos resultados carregam mais rápido",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorar otimização da bateria",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Se você está tendo problemas de notificação ou som pausado devido à otimização do sistema, por favor ative essa opção",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Erro em importar playlist",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Erro em salvar no banco de dados",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Não foi possível acessar o arquivo selecionado",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Formato de arquivo inválido",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Nota: Playlists longas pode levar mais tempo para importar",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage("Importar Playlist"),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Selecione um arquivo JSON exportado anteriormente para importar",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importado"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importado de Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Playlist importada",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importando playlist...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Diretório de armazenamento interno",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Incluir ficheiros de músicas transferidas",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informação não disponível",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Estrutura do arquivo de playlist inválida",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Resposta do servidor inválida.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "A sessão não contém um token válido.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("itens"),
    "keepListening": MessageLookupByLibrary.simpleMessage("continue ouvindo"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Manter a tela ligada durante a reprodução",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "Se ativado, a tela do dispositivo permanecerá ligada enquanto a música estiver sendo reproduzida",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Definir Idioma do Aplicativo",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Último lançamento"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Versão mais recente disponível",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Vamos começar..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage("Biblioteca de Álbuns"),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Biblioteca de Artistas",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Biblioteca de Playlists",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage("Biblioteca de Músicas"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução da biblioteca",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Claro"),
    "link": MessageLookupByLibrary.simpleMessage("Vincular"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Vinculado com sucesso!"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Link copiado para a área de transferência",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Vincular as playlist com Piped",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Ouça agora"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "Ouvindo o ambiente...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Não foi possível carregar as informações de atualização",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Funciona sem a necessidade de login.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "Toda a sua biblioteca permanece estritamente neste computador.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Nota: Não há backups manuais na nuvem. Se você perder seu dispositivo ou desinstalar o aplicativo, seus dados não poderão ser recuperados.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Use apenas neste dispositivo",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Privacidade absoluta no seu dispositivo",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Modo local"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Intensidade"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Padronização de volume",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Define o mesmo volume para todas as músicas (Experimental) (Não funcionará em músicas baixadas antes da versão (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Baixa"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Cartas"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Letra não disponível!",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Gerenciar colaboradores (amigos)",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Certifique-se de que a música esteja tocando alto o suficiente perto do microfone.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Álbum migrado"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Biblioteca migrada",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução migrada",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Já existe uma migração em andamento.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analisando a biblioteca local...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Verificando se o EMusic Cloud já possui uma biblioteca...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migração concluída.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Criando um backup local antes de conectar a nuvem...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "A migração falhou. Seus dados locais não foram modificados.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Faça login no Joss Red antes de migrar.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Preparando a migração no EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud não pôde iniciar a migração.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Nem todos os dados puderam ser carregados. Mantemos seu suporte local.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Fazendo upload de playlists, favoritos e histórico...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud não conseguiu validar a migração.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Verificando a integridade no EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Selecione o arquivo e importe",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecione song.db ou um backup .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migração concluída com sucesso.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutos"),
    "misc": MessageLookupByLibrary.simpleMessage("Diversos"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "A música mais ouvida",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musica & Reprodução",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Reconhecimento Musical",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Falha na rede! Verifique sua conexão.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Oops, erro de conexão!",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nova versão disponível!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Aplicativo Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Entendido"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Joss Red Teia"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sincronização 100% com Joss Red, playlists com amigos e muito mais. Toque para ver o que há de novo.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music evoluiu!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Para adicionar amigos, aceitar solicitações ou gerenciar seu perfil de segurança, utilize Joss Red em suas plataformas oficiais:",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Amigos e gerenciamento de contas:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Notícias da música Estrella",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Crie playlists com seus amigos! Ao criar uma playlist, marque a caixa de seleção Colaborativa e escolha seus amigos para editarem juntos.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Listas de reprodução colaborativas",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Suas playlists e favoritos agora são salvos e sincronizados na nuvem automaticamente com sua conta Joss Red principal.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Integração total com Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Você não precisa mais clicar nos botões de sincronização manual; O novo motor é responsável por aumentar e diminuir a marcha automaticamente.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Sincronização Transparente",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Não"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Nenhuma salva!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Você não tem amigos adicionados em Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Você não tem uma biblioteca de playlist!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Não foi possível encontrar nenhuma música no áudio gravado",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Sem correspondências",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Sem músicas offline!",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Não há músicas nesta coleção",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("Sem resultados para"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Não autenticado"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Não é uma música/videoclipe!",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("Link inválido!"),
    "openIn": MessageLookupByLibrary.simpleMessage("Abrir em"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("Operação falhou"),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "password_text": MessageLookupByLibrary.simpleMessage("Senha"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Permissão negada",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music precisa dessas permissões para gerenciar suas músicas e oferecer todos os recursos de reprodução.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Permissões para começar",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Conceda as permissões necessárias",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "É usado apenas quando você escolhe identificar uma música que está tocando ao seu redor.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Microfone",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Mostra controles de reprodução, progresso de download e avisos importantes de aplicativos.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Notificações",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Configurações",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Todas as três licenças são necessárias para continuar. Você pode alterá-los posteriormente nas configurações do sistema.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Ele permite reproduzir músicas, salvar downloads, exportar playlists e preparar atualizações.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Música e armazenamento",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personalização"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução canalizada",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução sincronizada!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Simples"),
    "play": MessageLookupByLibrary.simpleMessage("Jogar"),
    "playNext": MessageLookupByLibrary.simpleMessage("Reproduzir próxima"),
    "playNow": MessageLookupByLibrary.simpleMessage("Jogue agora"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Velocidade de reprodução",
    ),
    "playerUi": MessageLookupByLibrary.simpleMessage("Interface do player"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Tipo de interface do player",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Jogando:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "TOCANDO DO ÁLBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "TOCANDO DO ARTISTA",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "TOCANDO DA LISTA DE REPRODUÇÃO",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "TOCANDO DA SELEÇÃO",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Lista de reprodução"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist adicionada à lista negra!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist salva!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist não mais salva!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Colaboradores da lista de reprodução",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist criada!",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist criada e música adicionada!",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist exportado com sucesso para",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist importado com sucesso",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist removida!",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Renomeado com sucesso!",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Lista de Reprodução"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("Seguinte"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Podcasts"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Faixas populares"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Processando os ficheiros...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Processando o áudio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Perfis"),
    "queueLoop": MessageLookupByLibrary.simpleMessage("Fila de repetição"),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "O modo de ciclo não pode ser desativado quando o modo aleatório está ativado.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "A repetição de fila não pode ser ativado no modo Rádio.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A fila não pode ser misturada quando o modo de mistura está ativo",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "A fila não pode ser reordenada quando o modo aleatório está ativado",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Seleção rápida"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Escolhas rápidas"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Rádio não disponível para esse artista!",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Rádio aleatório"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Seleção aleatória",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Reorganizar playlist",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage("Reordenar músicas"),
    "readMore": MessageLookupByLibrary.simpleMessage("Leia mais"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Pesquisas recentes",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage(
      "Tocadas recentemente",
    ),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Recomendamos ativar o Cloud Mode para uma experiência semelhante à do Spotify: sincronização em tempo real entre todos os seus dispositivos e backup automático sem que você precise fazer nada.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Recomendado"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Recomendado"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("Remover do cache"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Remover da Biblioteca de Músicas",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Excluir da biblioteca",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Remover da playlist",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("Remover da fila"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Remover múltiplas músicas",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("Remover playlist"),
    "rename": MessageLookupByLibrary.simpleMessage("Renomear"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("Renomear Playlist"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproduzido por"),
    "reset": MessageLookupByLibrary.simpleMessage("Redefinir"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restaurar Definições Padrão",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Redefinir Configurações do App para Padrão (Requer Reinicio)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "Configurações Restauradas ao Padrão com sucesso. Por favor, reinicie o app",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Definir playlists da lista negra",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Redefinir todas as playlists da lista negra do Piped",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage("Reiniciar Aplicação"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restaurar dados da aplicação",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurar a última sessão de reprodução",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaure automaticamente a última sessão de reprodução na inicialização do aplicativo",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Restauração concluída com sucesso!\nMudanças são aplicadas no reinício",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Restaurar configurações e playlists",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restaura todas as configurações, dados de login e playlists de um arquivo de backup. Substitui todos os dados atuais",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Selecione o arquivo de backup",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage("Restaurando..."),
    "results": MessageLookupByLibrary.simpleMessage("Resultados"),
    "retry": MessageLookupByLibrary.simpleMessage("Tente novamente!"),
    "save": MessageLookupByLibrary.simpleMessage("Manter"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Salvo"),
    "scanning": MessageLookupByLibrary.simpleMessage("Lendo..."),
    "search": MessageLookupByLibrary.simpleMessage("Procurar"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Músicas,Playlist,Álbum ou Artista",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Pesquisar na Biblioteca",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage("Resultados da pesquisa"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Pesquisas recentes",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Selecionar tudo"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Selecione Instância de Autenticação",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Selecione uma instância de Autenticação!",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage("Selecionar Arquivo"),
    "selectSongs": MessageLookupByLibrary.simpleMessage("Selecionar músicas"),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "O arquivo selecionado não foi encontrado.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Sua sessão expirou. Faça login novamente.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Definir conteúdo sugerido",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Sobre Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Versão, projeto de código aberto e GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Conta e sincronização",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem, backups, lista de amigos e migrações.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Animações de tema, idioma e interface.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Backup na nuvem",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Carregar, restaurar e gerenciar...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Carregue um backup .hmb do aplicativo no servidor e, se necessário, restaure qualquer um dos backups salvos.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Descubra filtros, integração com Piped e caches.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Downloads e armazenamento",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Formatos de áudio, pastas e downloads automáticos.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage(
      "Em geral",
    ),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Escolha, migre ou revise o status de sincronização com Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Modo Local / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Sair"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importe playlists, músicas...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrar do Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("meus amigos"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Gerencie seus amigos Joss Red diretamente.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Qualidade de streaming, normalização, silêncios e bateria.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Gere novamente seu ID do YouTube Music se o conteúdo do Discover não carregar.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Atualizar ID (ID do visitante)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Erro"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Não foi possível gerar um novo identificador. Por favor, tente novamente mais tarde.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identificador atualizado",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Um novo ID de visitante foi gerado com sucesso.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Compartilhar álbum"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Compartilhar lista de reprodução",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage(
      "Compartilhar essa música",
    ),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Procurando correspondências no banco de dados do Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Aleatório"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage(
      "Misturar Enfileirados",
    ),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Pular silêncio"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Silêncio será pulado quando houver",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Seu temporizador de sono está ativado",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Temporizador de Sono"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Música adicionada à playlist!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Música já existe!",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Músicas baixadas já disponíveis para reprodução offline",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Músicas adicionadas à fila!",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Canção encontrada!"),
    "songInfo": MessageLookupByLibrary.simpleMessage("Detalhes"),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Música não pode ser reproduzida devido a restrições do servidor!",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("tom da música"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Removida da/do"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Removido da fila!",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Você não pode remover a música enquanto toca",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Músicas"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Músicas importadas do Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Classificar crescente/decrescente",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Classificar por data"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage(
      "Classificar por duração",
    ),
    "sortByName": MessageLookupByLibrary.simpleMessage("Classificar por nome"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Velocidade e passo"),
    "standard": MessageLookupByLibrary.simpleMessage("Padrão"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Iniciar rádio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Abrir na inicialização",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Escolha a seção que Estrella Music abre primeiro",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status/Situação"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Parar música no gerenciador de tarefas",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "A música será interrompida quando o aplicativo for removido do gerenciador de tarefas",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Qualidade da transmissão",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Qualidade da transmissão das músicas",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("Inscritos"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Deslize para explorar as opções ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem ativado. Baixando a biblioteca existente.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem ativado. Biblioteca migrada.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem ativo",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Modo nuvem ativo. Sincronização pendente.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao baixar a sincronização.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Baixando alterações do EMusic...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Biblioteca sincronizada.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Biblioteca atualizada.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Há novas mudanças locais. Eles serão carregados antes do download.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Seus dados são mantidos apenas neste dispositivo.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Modo local ativo",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Off-line. As alterações estão pendentes.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Off-line. Alterações salvas para nova tentativa.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Sincronizar músicas da lista de reprodução",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic não confirmou todas as alterações. Eles serão tentados novamente.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Não consegui me levantar. Será tentado novamente mais tarde.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "As alterações foram enviadas corretamente.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Alterações carregadas com sucesso (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Não foi possível fazer upload usando WS. Será tentado novamente mais tarde.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Carregando alterações para EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Sincronizado"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Lista de reprodução não disponível!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Padrão do sistema"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Modo do Tema"),
    "title": MessageLookupByLibrary.simpleMessage("Título"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Principais videoclipes",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Principais clipes"),
    "trending": MessageLookupByLibrary.simpleMessage("Populares"),
    "unLink": MessageLookupByLibrary.simpleMessage("Desvincular"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Desvinculado com sucesso!",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Música sem título"),
    "upNext": MessageLookupByLibrary.simpleMessage("Próximos"),
    "updateApp": MessageLookupByLibrary.simpleMessage("Atualizar aplicativo"),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL detectado clique nele para abrir/reproduzir o conteúdo associado",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Usuário bloqueado"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "A resposta não contém uma lista de usuários.",
    ),
    "userSearchFailed": m12,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Usuário desbloqueado",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nome de usuário"),
    "video": MessageLookupByLibrary.simpleMessage("Vídeo"),
    "videos": MessageLookupByLibrary.simpleMessage("Vídeos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Ver todos"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Ver Artista"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Modernizamos nossa plataforma. O antigo sistema de upload de backups manuais foi desativado. Agora você tem duas maneiras claras de gerenciar sua biblioteca de música.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Escolha como deseja experimentar o Estrella Music a partir de agora.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Sua música, do seu jeito",
    ),
  };
}
