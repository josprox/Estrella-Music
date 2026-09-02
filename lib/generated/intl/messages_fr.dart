// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(songTitle) => "Téléchargement : ${songTitle}";

  static String m1(count) => "Albums : ${count}";

  static String m2(count) => "Artistes : ${count}";

  static String m3(count) => "Favoris : ${count}";

  static String m4(count) => "Listes de lecture : ${count}";

  static String m5(count) => "Chansons : ${count}";

  static String m6(source) => "Migration terminée à partir du ${source}.";

  static String m7(error) =>
      "Une erreur s\'est produite lors de la régénération : ${error}";

  static String m8(title) => "Semblable à ${title}";

  static String m9(current) => "Étape ${current} sur 3";

  static String m10(count) => "${count} modifications validées.";

  static String m11(count) => "${count} modifications synchronisées.";

  static String m12(path) => "Sauvegarde de récupération: ${path}";

  static String m13(statusCode) =>
      "Impossible de rechercher des utilisateurs (${statusCode}).";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage(
      "Créer une nouvelle playlist",
    ),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("À propos"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("Ajouter 5 minutes"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage(
      "Ajouter des titres à la playlist",
    ),
    "addToLibrary": MessageLookupByLibrary.simpleMessage(
      "Ajouter à la bibliothèque",
    ),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage(
      "Ajouter à la playlist",
    ),
    "album": MessageLookupByLibrary.simpleMessage("Album"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Album ajouté aux favoris !",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Album retiré des favoris !",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("Albums"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("Selon vos goûts"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage(
      "Tous les champs sont obligatoires",
    ),
    "androidBackupWarning": MessageLookupByLibrary.simpleMessage(
      "Non testé : si vous cochez la case après avoir téléchargé plus de 60 fichiers, le processus peut consommer une grande quantité de mémoire et provoquer le blocage du téléphone ou de l\'application. Procédez à vos propres risques.",
    ),
    "appInfo": MessageLookupByLibrary.simpleMessage(
      "Informations sur l\'application",
    ),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Artiste ajouté aux favoris !",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Artiste retiré des favoris !",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Description indisponible !",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("Artistes"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("Selon vos goûts"),
    "audioCodec": MessageLookupByLibrary.simpleMessage("Codec Audio"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage(
      "Code d\'authentification",
    ),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "Entrez un code valide à 6 chiffres ou connectez-vous à nouveau.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "Saisissez le code à 6 chiffres de votre application d\'authentification. Cet accès expire dans 5 minutes.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage(
      "Authentification à deux facteurs",
    ),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage(
      "Vérifiez et continuez",
    ),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Accepter d\'utiliser mes données...",
    ),
    "auth_brand_description_1": MessageLookupByLibrary.simpleMessage(
      "Nous avons apporté le login, l\'enregistrement et la récupération du mot de passe du projet précédent, adaptés pour cette application musicale.",
    ),
    "auth_brand_description_2": MessageLookupByLibrary.simpleMessage(
      "Votre session réside dans un stockage sécurisé et est validée avec le même backend que vous utilisiez déjà.",
    ),
    "auth_brand_not_configured": MessageLookupByLibrary.simpleMessage(
      "Le fichier .env doit être configuré pour connecter le backend d\'authentification.",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("Registre"),
    "auth_btn_send_email": MessageLookupByLibrary.simpleMessage(
      "Envoyer un courrier",
    ),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirmez le mot de passe",
    ),
    "auth_error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
      "Email ou mot de passe incorrect.",
    ),
    "auth_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "Entrez un email valide.",
    ),
    "auth_error_not_configured": MessageLookupByLibrary.simpleMessage(
      "Le backend d\'authentification ne doit pas être configuré dans le fichier .env.",
    ),
    "auth_error_not_verified": MessageLookupByLibrary.simpleMessage(
      "Votre compte n\'est pas encore vérifié.",
    ),
    "auth_error_unknown": MessageLookupByLibrary.simpleMessage(
      "Il n\'a pas été possible de terminer l\'opération.",
    ),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("Prénom"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "J\'ai oublié mon mot de passe",
    ),
    "auth_forgot_password_subtitle": MessageLookupByLibrary.simpleMessage(
      "Nous vous enverrons les instructions par e-mail sur votre compte.",
    ),
    "auth_hint_email": MessageLookupByLibrary.simpleMessage("nom@mail.com"),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("Nom de famille"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "Connecté avec succès",
    ),
    "auth_recovery_email_error": MessageLookupByLibrary.simpleMessage(
      "Il n\'a pas été possible d\'envoyer l\'e-mail.",
    ),
    "auth_recovery_email_sent": MessageLookupByLibrary.simpleMessage(
      "E-mail envoyé.",
    ),
    "auth_register_error": MessageLookupByLibrary.simpleMessage(
      "Le compte n\'a pas pu être créé.",
    ),
    "auth_register_success": MessageLookupByLibrary.simpleMessage(
      "Compte créé avec succès.",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Estrella Music",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Estrella Music",
    ),
    "autoDownFavSong": MessageLookupByLibrary.simpleMessage(
      "Téléchargement automatique des titres préférés",
    ),
    "autoDownFavSongDes": MessageLookupByLibrary.simpleMessage(
      "Télécharger automatiquement les titres préférés lorsqu\'ils sont ajoutés aux favoris",
    ),
    "autoOpenPlayer": MessageLookupByLibrary.simpleMessage(
      "Ouverture automatique de l\'écran du lecteur",
    ),
    "autoOpenPlayerDes": MessageLookupByLibrary.simpleMessage(
      "Activer / Désactiver l\'ouverture automatique du plein écran du lecteur lors de la sélection du titre à lire",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Retour"),
    "backFilesFound": MessageLookupByLibrary.simpleMessage(
      "Bases de données trouvées",
    ),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage(
      "Lecture de musique en arrière-plan",
    ),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "Activer / Désactiver la lecture de musique en arrière-plan (l’application est accessible depuis la barre d’état système lorsqu\'elle s’exécute en arrière-plan)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sauvegarde"),
    "backupAppData": MessageLookupByLibrary.simpleMessage(
      "Sauvegarder les données de l\'application",
    ),
    "backupInProgress": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde en cours...",
    ),
    "backupMsg": MessageLookupByLibrary.simpleMessage(
      "Fichier de sauvegarde créé avec succès !",
    ),
    "backupSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Musique",
    ),
    "backupSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Sauvegarder tous vos paramètres, playlists et données de connexion dans un fichier de récupération",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "Vous avez besoin d\'une séance active...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage(
      "Redémarrer l\'application",
    ),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage(
      "Téléchargez la sauvegarde maintenant",
    ),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "Voulez-vous effectuer une sauvegarde ?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde supprimée.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage(
      "Il n\'y a pas encore de sauvegardes...",
    ),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde restaurée. Redémarrez l\'application.",
    ),
    "backup_select_folder_dialog": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez le dossier pour la sauvegarde",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "Choisissez les données à sauvegarder",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde téléchargée correctement.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage(
      "Basée sur la dernière interaction",
    ),
    "bitrate": MessageLookupByLibrary.simpleMessage("Débit Binaire"),
    "blacklistPipedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Liste noire de la playlist",
    ),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage(
      "Réinitialisé avec succès !",
    ),
    "by": MessageLookupByLibrary.simpleMessage("par"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "Mettre en cache le contenu de la page d\'accueil",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "Activer la mise en cache du menu principal. Son chargement sera instantané si cette option est activée",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("Titres en cache"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "Mettre en cache des titres pendant la lecture pour une lecture ultérieure / hors ligne. Cela nécessitera de l\'espace supplémentaire sur votre appareil",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage(
      "En Cache / Hors Ligne",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("Annuler la minuterie"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage(
      "Minuteur de veille désactivé",
    ),
    "clearImgCache": MessageLookupByLibrary.simpleMessage(
      "Nettoyer le cache des images",
    ),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "Nettoyage du cache des images réalisé avec succès",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "Cliquez ici pour vider le cache des images / miniatures. (Non recommandé sauf si vous voulez rafraîchir le cache des images)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "closeApp": MessageLookupByLibrary.simpleMessage("Fermer l\'application"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque cloud trouvée.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "Une bibliothèque cloud a été trouvée. Cet appareil le téléchargera sans l\'écraser.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "Cloud mode is ready. Cet appareil fonctionnera comme un cache hors ligne.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous en toute sécurité en utilisant votre compte Joss Red.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "Accédez instantanément à vos playlists, favoris et historique depuis n’importe quel appareil (Windows, Android, etc.).",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "Smart Sync : travaillez hors ligne et téléchargez automatiquement les modifications lorsque vous récupérez Internet.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage(
      "Activer la synchronisation Cloud",
    ),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage(
      "Synchronisation en temps réel avec Joss Red",
    ),
    "cloud_title": MessageLookupByLibrary.simpleMessage(
      "Mode Cloud (recommandé)",
    ),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Liste de lecture collaborative",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez les amis qui pourront voir et modifier cette playlist :",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "Collaborateurs mis à jour correctement.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlists de la Communauté",
    ),
    "content": MessageLookupByLibrary.simpleMessage("Contenu"),
    "copyrightNotice": MessageLookupByLibrary.simpleMessage(
      "© 2026 JOSPROX. Licence GPL v3.0",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Créer"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("Créer et Ajouter"),
    "customIns": MessageLookupByLibrary.simpleMessage("Instance Personnalisée"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "Veuillez sélectionner une instance personnalisée",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage(
      "Découverte quotidienne",
    ),
    "dark": MessageLookupByLibrary.simpleMessage("Sombre"),
    "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage(
      "Supprimer des téléchargements",
    ),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "Supprimé avec succès des téléchargements !",
    ),
    "developedBy": MessageLookupByLibrary.simpleMessage(
      "Développé et maintenu par Joss Estrada (JOSPROX)",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "Désactiver les animations de transition",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "Activer cette option pour désactiver les animations de changement d\'onglets",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "discover": MessageLookupByLibrary.simpleMessage("Découvrir"),
    "dismiss": MessageLookupByLibrary.simpleMessage("Rejeter"),
    "done": MessageLookupByLibrary.simpleMessage("Prêt"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage(
      "Ne plus afficher cette information",
    ),
    "downFilesFound": MessageLookupByLibrary.simpleMessage(
      "fichiers téléchargés trouvés",
    ),
    "download": MessageLookupByLibrary.simpleMessage("Téléchargement"),
    "downloadAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Télécharger des chansons de l\'album",
    ),
    "downloadError2": MessageLookupByLibrary.simpleMessage(
      "Le titre demandé n\'est pas téléchargeable en raison d\'une restriction du serveur. Vous devriez réessayer",
    ),
    "downloadError3": MessageLookupByLibrary.simpleMessage(
      "Le téléchargement a échoué en raison d\'une erreur de réseau / flux ! Veuillez réessayer",
    ),
    "downloadLocation": MessageLookupByLibrary.simpleMessage(
      "Emplacement du Téléchargement",
    ),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage(
          "Maintient vos téléchargements de musique actifs en arrière-plan.",
        ),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "téléchargements de musique",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "Préparation de vos téléchargements…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Télécharger de la musique",
    ),
    "downloadPlaylist": MessageLookupByLibrary.simpleMessage(
      "Télécharger la liste de lecture",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage(
      "Format de fichier téléchargé",
    ),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez le format de fichier de téléchargé. \"Opus\" offrira la meilleure qualité",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("Téléchargements"),
    "duration": MessageLookupByLibrary.simpleMessage("Durée"),
    "dynamic": MessageLookupByLibrary.simpleMessage("Dynamique"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("Playlist vide !"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage(
      "Barre de navigation inférieure",
    ),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "Passer à la barre de navigation inférieure",
    ),
    "enableSlidableAction": MessageLookupByLibrary.simpleMessage(
      "Activer les actions coulissantes",
    ),
    "enableSlidableActionDes": MessageLookupByLibrary.simpleMessage(
      "Activer les actions coulissantes sur la mosaïque de titres",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("Activé"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("Fin de ce titre"),
    "enqueueAlbumSongs": MessageLookupByLibrary.simpleMessage(
      "Ajouter des chansons d\'album à la file d\'attente",
    ),
    "enqueueAll": MessageLookupByLibrary.simpleMessage(
      "Mettre tout en file d\'attente",
    ),
    "enqueueSong": MessageLookupByLibrary.simpleMessage(
      "Mettre ce titre en file d\'attente",
    ),
    "enqueueSongs": MessageLookupByLibrary.simpleMessage(
      "Ajouter des chansons à la file d\'attente",
    ),
    "episodes": MessageLookupByLibrary.simpleMessage("Épisodes"),
    "equalizer": MessageLookupByLibrary.simpleMessage("Égaliseur"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage(
      "Ouvrir l\'égaliseur du système",
    ),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite !",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Une erreur s\'est produite",
    ),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de la lecture :",
    ),
    "export": MessageLookupByLibrary.simpleMessage("Exporter"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Exporter les fichiers téléchargés",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "Cliquez ici pour exporter les fichiers téléchargés du dossier de l\'application vers un dossier externe",
    ),
    "exportError": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de l\'exportation de la playlist",
    ),
    "exportErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du formatage des données de la playlist",
    ),
    "exportErrorPermission": MessageLookupByLibrary.simpleMessage(
      "Autorisation refusée lors de l\'exportation",
    ),
    "exportErrorStorage": MessageLookupByLibrary.simpleMessage(
      "Espace de stockage insuffisant",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage(
      "Fichiers exportés avec succès",
    ),
    "exportPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exporter la playlist",
    ),
    "exportPlaylistCsv": MessageLookupByLibrary.simpleMessage(
      "Exporter la playlist au format CSV",
    ),
    "exportPlaylistCsvSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ne peut pas être importé ici",
    ),
    "exportPlaylistJson": MessageLookupByLibrary.simpleMessage(
      "Exporter la playlist au format JSON",
    ),
    "exportPlaylistJsonSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ce format peut être importé",
    ),
    "exportToOnlineMusic": MessageLookupByLibrary.simpleMessage(
      "Exporter vers Online Music",
    ),
    "exportToOnlineMusicSubtitle": MessageLookupByLibrary.simpleMessage(
      "Cela poussera votre playlist (titres < 50) vers la file d\'attente actuelle. N\'oubliez pas de l\'ajouter à la playlist/de l\'enregistrer après l\'ouverture dans Online Music",
    ),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "Emplacement d\'exportation du fichier téléchargé",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage(
      "Exportation en cours...",
    ),
    "exportingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Exportation de la playlist...",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favoris"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage(
      "Playlists Mises en Avant",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Fichier introuvable"),
    "follow": MessageLookupByLibrary.simpleMessage("Continuer"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("suivi"),
    "following": MessageLookupByLibrary.simpleMessage("Suivant"),
    "for1": MessageLookupByLibrary.simpleMessage("pour"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage(
      "favoris oubliés",
    ),
    "friendFallback": MessageLookupByLibrary.simpleMessage("Ami"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "Demande d\'ami acceptée",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage(
      "Demande d\'ami envoyée",
    ),
    "friends": MessageLookupByLibrary.simpleMessage("Amis"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour trouver des amis.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage(
      "Amitié supprimée",
    ),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("Album"),
    "genericError": MessageLookupByLibrary.simpleMessage("Erreur"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("Électronique"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("hip hop"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("Jazz"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("latin"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("Populaire"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("Rocher"),
    "gesture": MessageLookupByLibrary.simpleMessage("Geste"),
    "github": MessageLookupByLibrary.simpleMessage("GitHub"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Voir le code source GitHub\nSi vous aimez ce projet, n\'oubliez pas de donner une ⭐",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("Voir l\'album"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "Cliquez ici pour accéder à la page de téléchargement",
    ),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Bonjour tout le monde"),
    "high": MessageLookupByLibrary.simpleMessage("Élevée"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage(
      "URL API de l\'instance Piped",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Accueil"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage(
      "Nombre de contenus de l\'accueil",
    ),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "Choisir le nombre de contenus sur l\'écran d\'accueil (approx.). Moins de résultats pour un chargement plus rapide",
    ),
    "id": MessageLookupByLibrary.simpleMessage("Identifiant"),
    "identifySongMetadata": MessageLookupByLibrary.simpleMessage(
      "Identifier les métadonnées",
    ),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage(
      "Ignorer l\'optimisation de la batterie",
    ),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "Si vous rencontrez des problèmes de notification ou si la lecture est arrêtée par l\'optimisation du système, veuillez activer cette option",
    ),
    "importError": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de l\'importation de la playlist",
    ),
    "importErrorDatabase": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de l\'enregistrement dans la base de données",
    ),
    "importErrorFileAccess": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'accéder au fichier sélectionné",
    ),
    "importErrorFormat": MessageLookupByLibrary.simpleMessage(
      "Format de fichier invalide",
    ),
    "importLargeFileNote": MessageLookupByLibrary.simpleMessage(
      "Remarque : l’importation de playlists volumineuses peut prendre plus de temps",
    ),
    "importPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importer une playlist",
    ),
    "importPlaylistDesc": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez un fichier JSON de playlist précédemment exporté à importer",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importé"),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Importé de Joss Music Kotlin",
    ),
    "importedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Liste de lecture importée",
    ),
    "importingPlaylist": MessageLookupByLibrary.simpleMessage(
      "Importation de la playlist...",
    ),
    "in_app_storage": MessageLookupByLibrary.simpleMessage(
      "Répertoire de stockage interne",
    ),
    "includeDownloadedFiles": MessageLookupByLibrary.simpleMessage(
      "Inclure les fichiers de titres téléchargés",
    ),
    "infoNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Informations non disponibles",
    ),
    "invalidPlaylistFile": MessageLookupByLibrary.simpleMessage(
      "Structure de fichier de playlist non valide",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Réponse du serveur invalide.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "La session ne contient pas de jeton valide.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("éléments"),
    "keepListening": MessageLookupByLibrary.simpleMessage("continue à écouter"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "Garder l\'écran allumé pendant la lecture",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "S\'il est activé, l\'écran restera allumé pendant la lecture de la musique",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Langue"),
    "languageDes": MessageLookupByLibrary.simpleMessage(
      "Définir la langue de l\'application",
    ),
    "latestRelease": MessageLookupByLibrary.simpleMessage("Dernière version"),
    "latestVersion": MessageLookupByLibrary.simpleMessage(
      "Dernière version disponible",
    ),
    "letsStrart": MessageLookupByLibrary.simpleMessage("Commençons..."),
    "libAlbums": MessageLookupByLibrary.simpleMessage(
      "Albums de la Bibliothèque",
    ),
    "libArtists": MessageLookupByLibrary.simpleMessage(
      "Artistes de la Bibliothèque",
    ),
    "libPlaylists": MessageLookupByLibrary.simpleMessage(
      "Playlists de la Bibliothèque",
    ),
    "libSongs": MessageLookupByLibrary.simpleMessage(
      "Titres de la Bibliothèque",
    ),
    "library": MessageLookupByLibrary.simpleMessage("Bibliothèque"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Liste de lecture de la bibliothèque",
    ),
    "light": MessageLookupByLibrary.simpleMessage("Clair"),
    "link": MessageLookupByLibrary.simpleMessage("Lien"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("Lié avec succès !"),
    "linkCopied": MessageLookupByLibrary.simpleMessage(
      "Lien copié dans le presse-papiers",
    ),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "Lien avec piped pour les playlists",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("Écoute maintenant"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "A l\'écoute de l\'environnement...",
    ),
    "loadInfoUpdate": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les informations de mise à jour",
    ),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "local_b1": MessageLookupByLibrary.simpleMessage(
      "Cela fonctionne sans avoir besoin de vous connecter.",
    ),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "L\'intégralité de votre bibliothèque reste strictement sur cet ordinateur.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "Remarque : Aucune sauvegarde manuelle dans le cloud. Si vous perdez votre appareil ou désinstallez l\'application, vos données ne pourront pas être récupérées.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage(
      "Utiliser uniquement sur cet appareil",
    ),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "Confidentialité absolue sur votre appareil",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("Mode local"),
    "loudnessDb": MessageLookupByLibrary.simpleMessage("Niveau Sonore Db"),
    "loudnessNormalization": MessageLookupByLibrary.simpleMessage(
      "Normalisation du niveau sonore",
    ),
    "loudnessNormalizationDes": MessageLookupByLibrary.simpleMessage(
      "Définit le même niveau de volume pour tous les titres (expérimental) (Cela ne fonctionnera pas sur les titres téléchargés sur la version précédente (< v1.10.0))",
    ),
    "low": MessageLookupByLibrary.simpleMessage("Basse"),
    "lyrics": MessageLookupByLibrary.simpleMessage("Lettres"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Paroles indisponibles !",
    ),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage(
      "Gérer les collaborateurs (amis)",
    ),
    "metadataApplySuccess": MessageLookupByLibrary.simpleMessage(
      "Les métadonnées étaient intégrées dans le fichier local.",
    ),
    "metadataNoResults": MessageLookupByLibrary.simpleMessage(
      "Aucune correspondance trouvée. Essayez une autre recherche.",
    ),
    "metadataOperationFailed": MessageLookupByLibrary.simpleMessage(
      "L\'opération de métadonnées a échoué.",
    ),
    "metadataOverwriteWarning": MessageLookupByLibrary.simpleMessage(
      "Cela écrasera le titre intégré, l\'artiste, l\'album et la couverture tout en préservant les champs que le match ne fournit pas.",
    ),
    "metadataSearchDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la bonne correspondance pour intégrer son titre, son artiste, son album et sa couverture dans le fichier local.",
    ),
    "metadataSearchHint": MessageLookupByLibrary.simpleMessage(
      "Chanson ou nom d\'artiste",
    ),
    "metadataSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Identifier la chanson",
    ),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "Assurez-vous que la musique est suffisamment forte à proximité de votre microphone.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("Album migré"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque migrée",
    ),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage(
      "Liste de lecture migrée",
    ),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "Une migration est déjà en cours.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "Analyse de la bibliothèque locale...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "Vérifier si EMusic Cloud dispose déjà d\'une bibliothèque...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "Migration terminée.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Création d\'une sauvegarde locale avant de connecter le cloud...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "La migration a échoué. Vos données locales n\'ont pas été modifiées.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous à Joss Red avant de migrer.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "Préparation de la migration dans EMusic Cloud...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud n\'a pas pu démarrer la migration.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "Toutes les données n\'ont pas pu être téléchargées. Nous gardons votre soutien local.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "Téléchargement de listes de lecture, de favoris et d\'historique...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud n\'a pas pu valider la migration.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "Vérification de l\'intégrité dans EMusic Cloud...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez le fichier et importez",
    ),
    "migration_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez song.db ou une sauvegarde .backup",
    ),
    "migration_success": MessageLookupByLibrary.simpleMessage(
      "Migration terminée avec succès.",
    ),
    "migration_summary_albums": m1,
    "migration_summary_artists": m2,
    "migration_summary_favorites": m3,
    "migration_summary_playlists": m4,
    "migration_summary_songs": m5,
    "migration_summary_start": m6,
    "minutes": MessageLookupByLibrary.simpleMessage("minutes"),
    "misc": MessageLookupByLibrary.simpleMessage("Divers"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage(
      "La chanson la plus écoutée",
    ),
    "musicAndPlayback": MessageLookupByLibrary.simpleMessage(
      "Musique et Lecture",
    ),
    "musicRecognition": MessageLookupByLibrary.simpleMessage(
      "Reconnaissance musicale",
    ),
    "networkError": MessageLookupByLibrary.simpleMessage(
      "Erreur de réseau ! Vérifiez votre connexion réseau.",
    ),
    "networkError1": MessageLookupByLibrary.simpleMessage(
      "Oups erreur réseau !",
    ),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "Nouvelle version disponible !",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage(
      "Application Joss Red (Play Store)",
    ),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("Compris"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("Toile rouge Joss"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Synchronisation à 100% avec Joss Red, playlists avec amis et bien plus encore. Appuyez pour voir les nouveautés.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "¡Estrella Music ha evolucionado!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Pour ajouter des amis, accepter des demandes ou gérer votre profil de sécurité, veuillez utiliser Joss Red sur ses plateformes officielles :",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "Amis et gestion des comptes :",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage(
      "Actualités musicales Estrella",
    ),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "Créez des playlists avec vos amis ! Lors de la création d\'une liste de lecture, cochez la case Collaborative et choisissez vos amis à modifier ensemble.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage(
      "Listes de lecture collaboratives",
    ),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "Vos playlists et favoris sont désormais enregistrés et synchronisés automatiquement dans le cloud avec votre compte Joss Red principal.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Intégration complète avec Joss Red",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez plus besoin de cliquer sur les boutons de synchronisation manuelle ; Le nouveau moteur est chargé de monter et descendre automatiquement les vitesses.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage(
      "Synchronisation transparente",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Non"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("Aucun élément !"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas d\'amis ajoutés sur Joss Red.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas de playlist !",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "Impossible de trouver des chansons dans l\'audio enregistré",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage(
      "Aucune correspondance",
    ),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage(
      "Pas de titre hors ligne !",
    ),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "Il n\'y a aucune chanson dans cette collection",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage(
      "Aucune correspondance trouvée pour",
    ),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("Non authentifié"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage(
      "Pas de Titre / Vidéo !",
    ),
    "notaValidLink": MessageLookupByLibrary.simpleMessage(
      "Ce n\'est pas un lien valide !",
    ),
    "openIn": MessageLookupByLibrary.simpleMessage("Ouvrir avec"),
    "operationFailed": MessageLookupByLibrary.simpleMessage(
      "L\'opération a échoué",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "password_text": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "Autorisation refusée",
    ),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("Permettre"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music a besoin de ces autorisations pour gérer votre musique et offrir toutes les fonctionnalités de lecture.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Autorisations pour commencer",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "Accorder les autorisations requises",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "Il n\'est utilisé que lorsque vous choisissez d\'identifier une chanson qui joue autour de vous.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage(
      "Microphone",
    ),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "Affiche les commandes de lecture, la progression du téléchargement et les notifications importantes sur les applications.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage(
      "Paramètres",
    ),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "Les trois permis sont nécessaires pour continuer. Vous pourrez les modifier ultérieurement dans les paramètres système.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "Il vous permet d\'écouter de la musique, d\'enregistrer des téléchargements, d\'exporter des listes de lecture et de préparer des mises à jour.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "Musique et stockage",
    ),
    "personalisation": MessageLookupByLibrary.simpleMessage("Personnalisation"),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "Liste de lecture diffusée",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist piped synchronisée !",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("Entier"),
    "play": MessageLookupByLibrary.simpleMessage("Jouer"),
    "playNext": MessageLookupByLibrary.simpleMessage("Lecture suivante"),
    "playNow": MessageLookupByLibrary.simpleMessage("Jouez maintenant"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Vitesse de lecture"),
    "playerUi": MessageLookupByLibrary.simpleMessage("Interface du lecteur"),
    "playerUiDes": MessageLookupByLibrary.simpleMessage(
      "Sélectionner l\'interface du lecteur",
    ),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("Jouant:"),
    "playingfromAlbum": MessageLookupByLibrary.simpleMessage(
      "LECTURE DE L\'ALBUM",
    ),
    "playingfromArtist": MessageLookupByLibrary.simpleMessage(
      "LECTURE DE L\'ARTISTE",
    ),
    "playingfromPlaylist": MessageLookupByLibrary.simpleMessage(
      "LECTURE DE LA PLAYLIST",
    ),
    "playingfromSelection": MessageLookupByLibrary.simpleMessage(
      "LECTURE DE LA SÉLECTION",
    ),
    "playlist": MessageLookupByLibrary.simpleMessage("Liste de lecture"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist sur liste noire !",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist ajoutée aux favoris !",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist retirée des favoris !",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "Contributeurs à la playlist",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist créée !",
    ),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist créée et titre ajouté !",
    ),
    "playlistExportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist exportée avec succès vers",
    ),
    "playlistImportedMsg": MessageLookupByLibrary.simpleMessage(
      "Playlist importée avec succès",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage(
      "Playlist supprimée !",
    ),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage(
      "Renommé avec succès !",
    ),
    "playlists": MessageLookupByLibrary.simpleMessage("Playlists"),
    "playnextMsg": MessageLookupByLibrary.simpleMessage("À suivre"),
    "podcasts": MessageLookupByLibrary.simpleMessage("Baladodiffusions"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("Pistes populaires"),
    "processFiles": MessageLookupByLibrary.simpleMessage(
      "Traitement des fichiers...",
    ),
    "processingAudio": MessageLookupByLibrary.simpleMessage(
      "Traitement de l\'audio...",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profils"),
    "queueLoop": MessageLookupByLibrary.simpleMessage(
      "Lecture en boucle de la file d\'attente",
    ),
    "queueLoopNotDisMsg1": MessageLookupByLibrary.simpleMessage(
      "La lecture en boucle de la file d\'attente ne peut pas être désactivée lorsque le mode aléatoire est activé.",
    ),
    "queueLoopNotDisMsg2": MessageLookupByLibrary.simpleMessage(
      "La lecture en boucle de la file d\'attente ne peut pas être activée lorsque le mode radio est activé.",
    ),
    "queueShufflingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "La file d\'attente ne peut pas être mélangée lorsque le mode aléatoire est activé",
    ),
    "queuerearrangingDeniedMsg": MessageLookupByLibrary.simpleMessage(
      "La file d\'attente ne peut pas être réorganisée lorsque le mode aléatoire est activé",
    ),
    "quickPics": MessageLookupByLibrary.simpleMessage("Sélection rapide"),
    "quickpicks": MessageLookupByLibrary.simpleMessage("Sélection Rapide"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Radio non disponible pour cet artiste !",
    ),
    "randomRadio": MessageLookupByLibrary.simpleMessage("Radio Aléatoire"),
    "randomSelection": MessageLookupByLibrary.simpleMessage(
      "Sélection Aléatoire",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage(
      "Réarranger la playlist",
    ),
    "reArrangeSongs": MessageLookupByLibrary.simpleMessage(
      "Réorganiser les titres",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("En savoir plus"),
    "recentSearches": MessageLookupByLibrary.simpleMessage(
      "Recherches récentes",
    ),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("Joués Récemment"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Nous vous recommandons d\'activer le Mode Cloud pour une expérience à la Spotify : synchronisation en temps réel entre tous vos appareils et sauvegarde automatique sans que vous ayez à faire quoi que ce soit.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("Recommandé"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("Recommandé"),
    "removeFromCache": MessageLookupByLibrary.simpleMessage("Retirer du cache"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage(
      "Supprimer de la bibliothèque",
    ),
    "removeFromLibrary": MessageLookupByLibrary.simpleMessage(
      "Supprimer de la bibliothèque",
    ),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage(
      "Supprimer de la playlist",
    ),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage(
      "Retirer de la file d\'attente",
    ),
    "removeMultiple": MessageLookupByLibrary.simpleMessage(
      "Supprimer plusieurs titres",
    ),
    "removePlaylist": MessageLookupByLibrary.simpleMessage(
      "Supprimer la playlist",
    ),
    "rename": MessageLookupByLibrary.simpleMessage("Renommer"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage(
      "Renommer la playlist",
    ),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("Reproduit par"),
    "reset": MessageLookupByLibrary.simpleMessage("Réinitialiser"),
    "resetToDefault": MessageLookupByLibrary.simpleMessage(
      "Restaurer les paramètres par défaut",
    ),
    "resetToDefaultDes": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser les paramètres de l\'application aux valeurs par défaut (redémarrage requis)",
    ),
    "resetToDefaultMsg": MessageLookupByLibrary.simpleMessage(
      "La réinitialisation des paramètres par défaut est terminée. Veuillez redémarrer l\'application",
    ),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser les playlists sur liste noire",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser toutes les playlists de la liste noire de Piped",
    ),
    "restartApp": MessageLookupByLibrary.simpleMessage(
      "Redémarrer l\'application",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restauration"),
    "restoreAppData": MessageLookupByLibrary.simpleMessage(
      "Restaurer les données de l\'application",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "Restaurer la dernière session de lecture",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "Restaurer automatiquement la dernière session de lecture au démarrage de l\'application",
    ),
    "restoreMsg": MessageLookupByLibrary.simpleMessage(
      "Restauration réussie !\nLes modifications seront appliquées au redémarrage",
    ),
    "restoreSettingsAndPlaylists": MessageLookupByLibrary.simpleMessage(
      "Restaurer les paramètres et les listes de lecture",
    ),
    "restoreSettingsAndPlaylistsDes": MessageLookupByLibrary.simpleMessage(
      "Restaurer tous les paramètres, données de connexion et playlists depuis un fichier de récupération. Supprime toutes les données actuelles",
    ),
    "restore_select_file_dialog": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez le fichier de sauvegarde",
    ),
    "restoring": MessageLookupByLibrary.simpleMessage(
      "Récupération en cours...",
    ),
    "results": MessageLookupByLibrary.simpleMessage("Résultats"),
    "retry": MessageLookupByLibrary.simpleMessage("Réessayez !"),
    "save": MessageLookupByLibrary.simpleMessage("Garder"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("Enregistré"),
    "scanning": MessageLookupByLibrary.simpleMessage("Analyse en cours..."),
    "search": MessageLookupByLibrary.simpleMessage("Recherche"),
    "searchDes": MessageLookupByLibrary.simpleMessage(
      "Titres, Playlist, Album ou Artiste",
    ),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage(
      "Rechercher dans la bibliothèque",
    ),
    "searchRes": MessageLookupByLibrary.simpleMessage(
      "Résultats de la Recherche",
    ),
    "search_recent_title": MessageLookupByLibrary.simpleMessage(
      "Recherches récentes",
    ),
    "selectAll": MessageLookupByLibrary.simpleMessage("Tout sélectionner"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez une instance d\'authentification",
    ),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "Veuillez sélectionner une instance d\'authentification !",
    ),
    "selectFile": MessageLookupByLibrary.simpleMessage(
      "Sélectionner un fichier",
    ),
    "selectSongs": MessageLookupByLibrary.simpleMessage(
      "Sélectionner des titres",
    ),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "Le fichier sélectionné n\'a pas été trouvé.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Votre session a expiré. Connectez-vous à nouveau.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage(
      "Définir le contenu",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "À propos de Estrella Music",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "Version, projet open source et GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage(
      "Compte et synchronisation",
    ),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "Mode cloud, sauvegardes, liste d\'amis et migrations.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "Animations de thème, de langage et d\'interface.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde dans le cloud",
    ),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "Téléchargez, restaurez et gérez...",
    ),
    "settings_cloud_backup_dialog_desc": MessageLookupByLibrary.simpleMessage(
      "Téléchargez une sauvegarde .hmb de l\'application sur le serveur et, si nécessaire, restaurez l\'une des sauvegardes enregistrées.",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "Découvrez les filtres, l\'intégration avec Piped et les caches.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "Téléchargements et stockage",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "Formats audio, dossiers et téléchargements automatiques.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("Général"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Choisissez, migrez ou révisez l\'état de synchronisation avec Joss Red.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "Mode Local / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "Importez des playlists, des chansons...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Migrer depuis Joss Music Kotlin",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("mes amis"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Gérez directement vos amis Joss Red.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "Qualité du streaming, normalisation, silences et batterie.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Régénérez votre identifiant Online Music si le contenu Discover ne se charge pas.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "Actualiser l\'ID (ID visiteur)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("Erreur"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "Un nouvel identifiant n\'a pas pu être généré. Veuillez réessayer plus tard.",
    ),
    "settings_visitor_exception": m7,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "Identifiant mis à jour",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "Un nouvel ID visiteur a été généré avec succès.",
    ),
    "shareAlbum": MessageLookupByLibrary.simpleMessage("Partager l\'album"),
    "sharePlaylist": MessageLookupByLibrary.simpleMessage(
      "Partager la playlist",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("Partager ce titre"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Recherche de correspondances dans la base de données Shazam...",
    ),
    "shuffle": MessageLookupByLibrary.simpleMessage("Aléatoire"),
    "shuffleQueue": MessageLookupByLibrary.simpleMessage(
      "Lecture aléatoire de la file d\'attente",
    ),
    "similarToTitle": m8,
    "singles": MessageLookupByLibrary.simpleMessage("Singles"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("Ignorer le silence"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "Le silence sera ignoré lors de la lecture de la musique",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage(
      "Minuteur de veille activé",
    ),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Minuterie de veille"),
    "slide_indicator": m9,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "Titre ajouté à la playlist !",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Le titre existe déjà !",
    ),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "Titre déjà hors ligne dans le cache",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage(
      "Titre en file d\'attente !",
    ),
    "songFound": MessageLookupByLibrary.simpleMessage("Chanson trouvée !"),
    "songInfo": MessageLookupByLibrary.simpleMessage(
      "Informations sur le titre",
    ),
    "songNotPlayable": MessageLookupByLibrary.simpleMessage(
      "Le titre n\'est pas jouable en raison d\'une restriction du serveur !",
    ),
    "songPitch": MessageLookupByLibrary.simpleMessage("ton de la chanson"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("Supprimé de"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage(
      "Supprimé de la file d\'attente !",
    ),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "Vous ne pouvez pas supprimer le titre en cours de lecture",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("Titres"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Chansons importées de Joss Music Kotlin",
    ),
    "sortAscendNDescend": MessageLookupByLibrary.simpleMessage(
      "Trier par ordre croissant/décroissant",
    ),
    "sortByDate": MessageLookupByLibrary.simpleMessage("Trier par date"),
    "sortByDuration": MessageLookupByLibrary.simpleMessage("Trier par durée"),
    "sortByName": MessageLookupByLibrary.simpleMessage("Trier par nom"),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("Vitesse et pitch"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startRadio": MessageLookupByLibrary.simpleMessage("Démarrer la radio"),
    "startupScreen": MessageLookupByLibrary.simpleMessage(
      "Ouvert au démarrage",
    ),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la section qu\'Estrella Music ouvre en premier",
    ),
    "status": MessageLookupByLibrary.simpleMessage("État"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "Arrêter la musique",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "La lecture de la musique s\'arrête lorsque l\'application est retirée du gestionnaire de tâches",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage(
      "Qualité de diffusion",
    ),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage(
      "Qualité du flux de musique",
    ),
    "subscribers": MessageLookupByLibrary.simpleMessage("abonnés"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage(
      "Faites glisser votre doigt pour explorer les options ➔",
    ),
    "syncChangesConfirmed": m10,
    "syncChangesSynced": m11,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "Mode cloud activé. Téléchargement de la bibliothèque existante.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "Mode cloud activé. Bibliothèque migrée.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage(
      "Mode cloud actif",
    ),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "Mode cloud actif. En attente de synchronisation.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Échec du téléchargement de la synchronisation.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "Téléchargement des modifications d\'EMusic...",
    ),
    "syncForceReplaceBackupSaved": m12,
    "syncForceReplaceConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Reemplazar y subir",
    ),
    "syncForceReplaceConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Primero se creará un respaldo de recuperación. Después, las playlists, favoritos, historial, álbumes, artistas y ajustes musicales de EMusic Cloud se reemplazarán con los datos actuales de este dispositivo. No se puede deshacer desde el servidor.",
    ),
    "syncForceReplaceConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "¿Reemplazar la biblioteca musical remota ?",
    ),
    "syncForceReplaceCountMismatch": MessageLookupByLibrary.simpleMessage(
      "Les chiffres téléchargés ne correspondent pas à la bibliothèque locale. Le remplacement à distance n\'a pas pu être confirmé.",
    ),
    "syncForceReplaceCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "Créer une sauvegarde de récupération avant de remplacer les données du cloud...",
    ),
    "syncForceReplaceDescription": MessageLookupByLibrary.simpleMessage(
      "Pausa la sincronización pendiente y reemplaza a la fuerza tu biblioteca musical remota con los datos actuales de este dispositivo. Las descargas permanecen locales.",
    ),
    "syncForceReplaceFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud ne pouvait pas remplacer la bibliothèque distante.",
    ),
    "syncForceReplaceFailedLocalPreserved":
        MessageLookupByLibrary.simpleMessage(
          "Le remplacement à distance a échoué. Vos données locales et sauvegarde de récupération ont été conservées.",
        ),
    "syncForceReplaceFailedTitle": MessageLookupByLibrary.simpleMessage(
      "Téléchargement non terminé",
    ),
    "syncForceReplaceInProgress": MessageLookupByLibrary.simpleMessage(
      "Synchroniser, créer une sauvegarde et télécharger la bibliothèque locale...",
    ),
    "syncForceReplacePauseFailed": MessageLookupByLibrary.simpleMessage(
      "La synchronisation actuelle ne pouvait pas être interrompue en toute sécurité. Essaie encore dans un moment.",
    ),
    "syncForceReplaceSuccess": MessageLookupByLibrary.simpleMessage(
      "La bibliothèque de musique distante a été remplacée par les données actuelles de cet appareil.",
    ),
    "syncForceReplaceSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Téléchargement terminé",
    ),
    "syncForceReplaceTitle": MessageLookupByLibrary.simpleMessage(
      "Cancelar sincronización y subir ESTA base",
    ),
    "syncForceReplaceValidating": MessageLookupByLibrary.simpleMessage(
      "Valider la bibliothèque téléchargée avant de remplacer les données du cloud...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque synchronisée.",
    ),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "Bibliothèque à jour.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "Il y a de nouveaux changements locaux. Ils seront téléchargés avant le téléchargement.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "Vos données sont conservées uniquement sur cet appareil.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage(
      "Mode local actif",
    ),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "Hors ligne. Des changements sont en attente.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "Hors ligne. Modifications enregistrées pour une nouvelle tentative.",
    ),
    "syncPlaylistSongs": MessageLookupByLibrary.simpleMessage(
      "Synchroniser les chansons de la liste de lecture",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic n\'a pas confirmé tous les changements. Ils seront rejugés.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "Je ne pouvais pas me lever. Il sera réessayé plus tard.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "Modifications téléchargées correctement.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "Modifications téléchargées avec succès (WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "Impossible de télécharger à l\'aide de WS. Il sera réessayé plus tard.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "Téléchargement des modifications vers EMusic...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("Synchronisé"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Les paroles synchronisées ne sont pas disponibles !",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("Système par défaut"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Mode du thème"),
    "title": MessageLookupByLibrary.simpleMessage("Titre"),
    "topMusicVid": MessageLookupByLibrary.simpleMessage(
      "Palmarès des vidéoclips",
    ),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("Top Vidéos"),
    "trending": MessageLookupByLibrary.simpleMessage("Tendance"),
    "unLink": MessageLookupByLibrary.simpleMessage("Dissocier"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage(
      "Dissociation réussie !",
    ),
    "untitledSong": MessageLookupByLibrary.simpleMessage("Chanson sans titre"),
    "upNext": MessageLookupByLibrary.simpleMessage("À suivre"),
    "updateApp": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour l\'application",
    ),
    "urlSearchDes": MessageLookupByLibrary.simpleMessage(
      "URL détectée. Cliquez dessus pour ouvrir / lire le contenu associé",
    ),
    "useThisMetadata": MessageLookupByLibrary.simpleMessage(
      "Utiliser ces métadonnées",
    ),
    "userBlocked": MessageLookupByLibrary.simpleMessage("Utilisateur bloqué"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "La réponse ne contient pas de liste d\'utilisateurs.",
    ),
    "userSearchFailed": m13,
    "userUnblocked": MessageLookupByLibrary.simpleMessage(
      "Utilisateur débloqué",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur"),
    "video": MessageLookupByLibrary.simpleMessage("Vidéo"),
    "videos": MessageLookupByLibrary.simpleMessage("Vidéos"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Tout Voir"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("Voir l\'artiste"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "Nous avons modernisé notre plateforme. L\'ancien système de téléchargement de sauvegardes manuelles a été désactivé. Vous disposez désormais de deux manières claires de gérer votre bibliothèque musicale.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Choisissez désormais comment vous souhaitez découvrir Estrella Music.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage(
      "Votre musique, à votre façon",
    ),
  };
}
