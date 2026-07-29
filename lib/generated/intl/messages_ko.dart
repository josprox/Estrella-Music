// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(songTitle) => "다운로드 중: ${songTitle}";

  static String m1(error) => "재생성하는 동안 오류가 발생했습니다: ${error}";

  static String m2(title) => "_${title} 과 유사함";

  static String m3(current) => "3단계 중 ${current} 단계";

  static String m4(count) => "_${count} 변경사항이 커밋되었습니다.";

  static String m5(count) => "_${count} 변경사항이 동기화되었습니다.";

  static String m6(statusCode) => "사용자(${statusCode})를 검색할 수 없습니다.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "CreateNewPlaylist": MessageLookupByLibrary.simpleMessage("새 플레이리스트 만들기"),
    "Piped": MessageLookupByLibrary.simpleMessage("Piped"),
    "about": MessageLookupByLibrary.simpleMessage("에 대한"),
    "add5Minutes": MessageLookupByLibrary.simpleMessage("5분 추가"),
    "addMultipleSongs": MessageLookupByLibrary.simpleMessage("음악을 플레이리스트에 추가"),
    "addToPlaylist": MessageLookupByLibrary.simpleMessage("플레이리스트에 추가"),
    "albumBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "앨범을 즐겨찾기에 추가함!",
    ),
    "albumBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "앨범 즐겨찾기를 제거함!",
    ),
    "albums": MessageLookupByLibrary.simpleMessage("앨범"),
    "albumsByTaste": MessageLookupByLibrary.simpleMessage("당신의 취향에 따라"),
    "allFieldsReqMsg": MessageLookupByLibrary.simpleMessage("모든 항목을 기입해주세요"),
    "artistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "아티스트를 즐겨찾기에 추가함!",
    ),
    "artistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "아티스트를 즐겨찾기에서 제거함!",
    ),
    "artistDesNotAvailable": MessageLookupByLibrary.simpleMessage(
      "설명을 찾지 못했습니다!",
    ),
    "artists": MessageLookupByLibrary.simpleMessage("아티스트"),
    "artistsByTaste": MessageLookupByLibrary.simpleMessage("당신의 취향에 따라"),
    "auth_2fa_code": MessageLookupByLibrary.simpleMessage("인증코드"),
    "auth_2fa_invalid": MessageLookupByLibrary.simpleMessage(
      "유효한 6자리 코드를 입력하거나 다시 로그인하세요.",
    ),
    "auth_2fa_subtitle": MessageLookupByLibrary.simpleMessage(
      "인증 앱의 6자리 코드를 입력하세요. 이 액세스 권한은 5분 후에 만료됩니다.",
    ),
    "auth_2fa_title": MessageLookupByLibrary.simpleMessage("이중 인증"),
    "auth_2fa_verify": MessageLookupByLibrary.simpleMessage("확인하고 계속하세요"),
    "auth_agree_personal_data": MessageLookupByLibrary.simpleMessage(
      "Accepto usar mis datos...",
    ),
    "auth_btn_login": MessageLookupByLibrary.simpleMessage("로그인"),
    "auth_btn_register": MessageLookupByLibrary.simpleMessage("등록하다"),
    "auth_confirm_password": MessageLookupByLibrary.simpleMessage("비밀번호 확인"),
    "auth_first_name": MessageLookupByLibrary.simpleMessage("이름"),
    "auth_forgot_password": MessageLookupByLibrary.simpleMessage(
      "비밀번호를 잊어버렸어요",
    ),
    "auth_last_name": MessageLookupByLibrary.simpleMessage("성"),
    "auth_login_success": MessageLookupByLibrary.simpleMessage(
      "성공적으로 로그인되었습니다",
    ),
    "auth_welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "Estrella Music에 오신 것을 환영합니다.",
    ),
    "auth_welcome_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music에 오신 것을 환영합니다.",
    ),
    "back": MessageLookupByLibrary.simpleMessage("반품"),
    "backgroundPlay": MessageLookupByLibrary.simpleMessage("백그라운드에서 음악 재생"),
    "backgroundPlayDes": MessageLookupByLibrary.simpleMessage(
      "백그라운드 음악 재생을 활성화/비활성화 (백그라운드에서 동작하는 동안은 시스템 트레이에서 접근 가능합니다)",
    ),
    "backup_auth_required": MessageLookupByLibrary.simpleMessage(
      "활성 세션이 필요합니다...",
    ),
    "backup_btn_restart": MessageLookupByLibrary.simpleMessage("앱 다시 시작"),
    "backup_btn_upload": MessageLookupByLibrary.simpleMessage("지금 백업 업로드"),
    "backup_confirm_question": MessageLookupByLibrary.simpleMessage(
      "백업을 수행하시겠습니까?",
    ),
    "backup_delete_success": MessageLookupByLibrary.simpleMessage(
      "백업이 삭제되었습니다.",
    ),
    "backup_no_backups": MessageLookupByLibrary.simpleMessage("아직 백업이 없습니다..."),
    "backup_restore_success": MessageLookupByLibrary.simpleMessage(
      "백업이 복원되었습니다. 앱을 다시 시작하세요.",
    ),
    "backup_selection_prompt": MessageLookupByLibrary.simpleMessage(
      "백업할 데이터 선택",
    ),
    "backup_upload_success": MessageLookupByLibrary.simpleMessage(
      "백업이 올바르게 업로드되었습니다.",
    ),
    "basedOnLast": MessageLookupByLibrary.simpleMessage("당신의 최근 취향에 기반함"),
    "blacklistPlstResetAlert": MessageLookupByLibrary.simpleMessage("초기화 성공!"),
    "by": MessageLookupByLibrary.simpleMessage("창시자"),
    "cacheHomeScreenData": MessageLookupByLibrary.simpleMessage(
      "홈 스크린의 컨텐츠를 캐시에 저장",
    ),
    "cacheHomeScreenDataDes": MessageLookupByLibrary.simpleMessage(
      "홈 스크린의 컨텐츠 데이터를 캐시에 저장하면, 홈 스크린이 즉시 불러와집니다",
    ),
    "cacheSongs": MessageLookupByLibrary.simpleMessage("음악을 캐시에 저장"),
    "cacheSongsDes": MessageLookupByLibrary.simpleMessage(
      "추후/오프라인 재생을 위해 곡을 캐싱하지만, 기기의 공간을 차지할 것입니다",
    ),
    "cachedOrOffline": MessageLookupByLibrary.simpleMessage("캐시됨/오프라인"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "cancelTimer": MessageLookupByLibrary.simpleMessage("타이머 취소"),
    "cancelTimerAlert": MessageLookupByLibrary.simpleMessage("취침 타이머 취소됨"),
    "clearImgCache": MessageLookupByLibrary.simpleMessage("이미지 캐시 비우기"),
    "clearImgCacheAlert": MessageLookupByLibrary.simpleMessage(
      "이미지 캐시를 성공적으로 비웠습니다",
    ),
    "clearImgCacheDes": MessageLookupByLibrary.simpleMessage(
      "클릭하면 캐시된 썸네일과 이미지를 비웁니다. (캐시된 이미지들을 갱신하고 싶은 경우가 아니라면 추천하지 않습니다)",
    ),
    "close": MessageLookupByLibrary.simpleMessage("닫다"),
    "cloudLibraryFound": MessageLookupByLibrary.simpleMessage(
      "클라우드 라이브러리를 찾았습니다.",
    ),
    "cloudLibraryFoundDeviceWillDownload": MessageLookupByLibrary.simpleMessage(
      "클라우드 라이브러리가 발견되었습니다. 이 장치는 덮어쓰지 않고 다운로드합니다.",
    ),
    "cloudModeReadyOfflineCache": MessageLookupByLibrary.simpleMessage(
      "클라우드 모드가 준비되었습니다. 이 장치는 오프라인 캐시로 작동합니다.",
    ),
    "cloud_b1": MessageLookupByLibrary.simpleMessage(
      "Joss Red 계정을 사용하여 안전하게 로그인하세요.",
    ),
    "cloud_b2": MessageLookupByLibrary.simpleMessage(
      "모든 장치(Windows, Android 등)에서 재생 목록, 즐겨찾기 및 기록에 즉시 액세스하세요.",
    ),
    "cloud_b3": MessageLookupByLibrary.simpleMessage(
      "스마트 동기화: 오프라인으로 작업하고 인터넷을 복구하면 자동으로 변경 사항을 업로드합니다.",
    ),
    "cloud_btn": MessageLookupByLibrary.simpleMessage("클라우드 동기화 활성화"),
    "cloud_subtitle": MessageLookupByLibrary.simpleMessage("Joss Red와 실시간 동기화"),
    "cloud_title": MessageLookupByLibrary.simpleMessage("클라우드 모드(권장)"),
    "collaborativePlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "공동 재생 목록",
    ),
    "collaboratorsInstruction": MessageLookupByLibrary.simpleMessage(
      "이 재생목록을 보고 편집할 수 있는 친구를 선택하세요.",
    ),
    "collaboratorsUpdated": MessageLookupByLibrary.simpleMessage(
      "공동작업자가 올바르게 업데이트되었습니다.",
    ),
    "communityplaylists": MessageLookupByLibrary.simpleMessage("커뮤니티 플레이리스트"),
    "create": MessageLookupByLibrary.simpleMessage("생성"),
    "createnAdd": MessageLookupByLibrary.simpleMessage("생성 및 추가"),
    "customIns": MessageLookupByLibrary.simpleMessage("커스텀 인스턴스"),
    "customInsSelectMsg": MessageLookupByLibrary.simpleMessage(
      "커스텀 인스턴스를 선택해주세요",
    ),
    "dailyDiscover": MessageLookupByLibrary.simpleMessage("매일의 발견"),
    "dark": MessageLookupByLibrary.simpleMessage("다크"),
    "deleteDownloadData": MessageLookupByLibrary.simpleMessage("다운로드에서 제거"),
    "deleteDownloadedDataAlert": MessageLookupByLibrary.simpleMessage(
      "다운로드에서 제거했습니다!",
    ),
    "disableTransitionAnimation": MessageLookupByLibrary.simpleMessage(
      "전환 애니메이션 비활성화",
    ),
    "disableTransitionAnimationDes": MessageLookupByLibrary.simpleMessage(
      "이 옵션을 활성화시키면 탭 전환 애니메이션이 비활성화됩니다",
    ),
    "disabled": MessageLookupByLibrary.simpleMessage("비활성화됨"),
    "discover": MessageLookupByLibrary.simpleMessage("탐색"),
    "dismiss": MessageLookupByLibrary.simpleMessage("무시"),
    "done": MessageLookupByLibrary.simpleMessage("준비가 된"),
    "dontShowInfoAgain": MessageLookupByLibrary.simpleMessage("다시 보지 않기"),
    "downFilesFound": MessageLookupByLibrary.simpleMessage("다운로드한 파일이 발견됨"),
    "downloadLocation": MessageLookupByLibrary.simpleMessage("다운로드 위치"),
    "downloadNotificationChannelDescription":
        MessageLookupByLibrary.simpleMessage("백그라운드에서 음악 다운로드를 활성 상태로 유지합니다."),
    "downloadNotificationChannelName": MessageLookupByLibrary.simpleMessage(
      "음악 다운로드",
    ),
    "downloadNotificationPreparing": MessageLookupByLibrary.simpleMessage(
      "다운로드 준비 중…",
    ),
    "downloadNotificationSong": m0,
    "downloadNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "음악 다운로드 중",
    ),
    "downloadingFormat": MessageLookupByLibrary.simpleMessage("다운로드 파일의 형식"),
    "downloadingFormatDes": MessageLookupByLibrary.simpleMessage(
      "다운로드 파일의 형식을 정해주세요. \"Opus\" 형식이 최고 음질입니다",
    ),
    "downloads": MessageLookupByLibrary.simpleMessage("다운로드"),
    "dynamic": MessageLookupByLibrary.simpleMessage("동적"),
    "email": MessageLookupByLibrary.simpleMessage("이메일"),
    "emptyPlaylist": MessageLookupByLibrary.simpleMessage("빈 플레이리스트!"),
    "enableBottomNav": MessageLookupByLibrary.simpleMessage("하단의 네비게이션 바"),
    "enableBottomNavDes": MessageLookupByLibrary.simpleMessage(
      "하단 내비게이션 바로 변경",
    ),
    "enabled": MessageLookupByLibrary.simpleMessage("활성화됨"),
    "endOfThisSong": MessageLookupByLibrary.simpleMessage("이 음악의 끝"),
    "enqueueAll": MessageLookupByLibrary.simpleMessage("모두 대기열에 추가"),
    "enqueueSong": MessageLookupByLibrary.simpleMessage("이 곡을 대기열에 추가"),
    "equalizer": MessageLookupByLibrary.simpleMessage("이퀄라이저"),
    "equalizerDes": MessageLookupByLibrary.simpleMessage("시스템 이퀄라이저 열기"),
    "errorOccuredAlert": MessageLookupByLibrary.simpleMessage(
      "알 수 없는 오류가 생겼습니다!",
    ),
    "errorOccurred": MessageLookupByLibrary.simpleMessage("오류가 발생했습니다"),
    "errorPlayingTrack": MessageLookupByLibrary.simpleMessage("플레이 중 오류:"),
    "export": MessageLookupByLibrary.simpleMessage("내보내기"),
    "exportDowloadedFiles": MessageLookupByLibrary.simpleMessage(
      "다운로드한 파일을 내보내기",
    ),
    "exportDowloadedFilesDes": MessageLookupByLibrary.simpleMessage(
      "인앱 디렉토리에 있는 다운로드한 파일들을 외부 디렉토리로 옮기려면 클릭하세요",
    ),
    "exportMsg": MessageLookupByLibrary.simpleMessage("파일을 성공적으로 내보냈습니다"),
    "exportedFileLocation": MessageLookupByLibrary.simpleMessage(
      "다운로드한 파일을 내보낼 위치",
    ),
    "exporting": MessageLookupByLibrary.simpleMessage("내보내는 중..."),
    "favorites": MessageLookupByLibrary.simpleMessage("즐겨찾기"),
    "featuredplaylists": MessageLookupByLibrary.simpleMessage("인기 플레이리스트"),
    "follow": MessageLookupByLibrary.simpleMessage("계속하다"),
    "followedArtists": MessageLookupByLibrary.simpleMessage("팔로우함"),
    "following": MessageLookupByLibrary.simpleMessage("수행원"),
    "for1": MessageLookupByLibrary.simpleMessage("어구"),
    "forgottenFavorites": MessageLookupByLibrary.simpleMessage("잊혀진 즐겨찾기"),
    "friendFallback": MessageLookupByLibrary.simpleMessage("친구"),
    "friendRequestAccepted": MessageLookupByLibrary.simpleMessage(
      "친구 요청이 수락되었습니다.",
    ),
    "friendRequestSent": MessageLookupByLibrary.simpleMessage("친구 요청이 전송되었습니다"),
    "friends": MessageLookupByLibrary.simpleMessage("친구"),
    "friendsLoginRequired": MessageLookupByLibrary.simpleMessage(
      "친구를 찾으려면 로그인하세요.",
    ),
    "friendshipRemoved": MessageLookupByLibrary.simpleMessage("우정이 제거되었습니다."),
    "genericAlbum": MessageLookupByLibrary.simpleMessage("앨범"),
    "genericError": MessageLookupByLibrary.simpleMessage("실수"),
    "genre_electronic": MessageLookupByLibrary.simpleMessage("전자제품"),
    "genre_hiphop": MessageLookupByLibrary.simpleMessage("힙합"),
    "genre_jazz": MessageLookupByLibrary.simpleMessage("재즈"),
    "genre_latin": MessageLookupByLibrary.simpleMessage("라틴어"),
    "genre_pop": MessageLookupByLibrary.simpleMessage("팝"),
    "genre_rock": MessageLookupByLibrary.simpleMessage("바위"),
    "github": MessageLookupByLibrary.simpleMessage("Github"),
    "githubDes": MessageLookupByLibrary.simpleMessage(
      "Github 소스 코드 보기\n이 프로젝트가 마음에 든다면, ⭐을 남겨주세요",
    ),
    "goToAlbum": MessageLookupByLibrary.simpleMessage("앨범으로 이동"),
    "goToDownloadPage": MessageLookupByLibrary.simpleMessage(
      "다운로드 페이지로 가려면 클릭",
    ),
    "high": MessageLookupByLibrary.simpleMessage("높음"),
    "hintApiUrl": MessageLookupByLibrary.simpleMessage("Piped 인스턴스의 API URL"),
    "home": MessageLookupByLibrary.simpleMessage("홈"),
    "homeContentCount": MessageLookupByLibrary.simpleMessage("홈 컨텐츠 수"),
    "homeContentCountDes": MessageLookupByLibrary.simpleMessage(
      "홈스크린에서 보여줄 컨텐츠의 대략적인 수를 정해주세요. 수가 적을수록 빨리 불러와집니다",
    ),
    "ignoreBatOpt": MessageLookupByLibrary.simpleMessage("배터리 최적화 무시"),
    "ignoreBatOptDes": MessageLookupByLibrary.simpleMessage(
      "만약 배터리 최적화 기능 때문에 푸시 알림이 오지 않거나 음악이 멈춘다면, 이 설정을 활성화해주세요",
    ),
    "importedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlin에서 가져옴",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "서버 응답이 잘못되었습니다.",
    ),
    "invalidSessionToken": MessageLookupByLibrary.simpleMessage(
      "세션에 유효한 토큰이 포함되어 있지 않습니다.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("항목"),
    "keepListening": MessageLookupByLibrary.simpleMessage("계속 들어봐"),
    "keepScreenOnWhilePlaying": MessageLookupByLibrary.simpleMessage(
      "재생 중 화면 켜짐 유지",
    ),
    "keepScreenOnWhilePlayingDes": MessageLookupByLibrary.simpleMessage(
      "활성화하면 음악 재생 중에 기기 화면이 켜진 상태로 유지됩니다",
    ),
    "language": MessageLookupByLibrary.simpleMessage("언어"),
    "languageDes": MessageLookupByLibrary.simpleMessage("앱 언어 설정"),
    "latestRelease": MessageLookupByLibrary.simpleMessage("최신 릴리스"),
    "libAlbums": MessageLookupByLibrary.simpleMessage("라이브러리 앨범"),
    "libArtists": MessageLookupByLibrary.simpleMessage("라이브러리 아티스트"),
    "libPlaylists": MessageLookupByLibrary.simpleMessage("라이브러리 플레이리스트"),
    "libSongs": MessageLookupByLibrary.simpleMessage("라이브러리 음악"),
    "library": MessageLookupByLibrary.simpleMessage("라이브러리"),
    "libraryPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "도서관 재생목록",
    ),
    "light": MessageLookupByLibrary.simpleMessage("라이트"),
    "link": MessageLookupByLibrary.simpleMessage("로그인"),
    "linkAlert": MessageLookupByLibrary.simpleMessage("로그인 성공!"),
    "linkPipedDes": MessageLookupByLibrary.simpleMessage(
      "플레이리스트를 Piped로부터 가져오기",
    ),
    "listenNow": MessageLookupByLibrary.simpleMessage("지금 들어보세요"),
    "listeningToEnvironment": MessageLookupByLibrary.simpleMessage(
      "환경에 귀를 기울이다...",
    ),
    "local": MessageLookupByLibrary.simpleMessage("기기"),
    "local_b1": MessageLookupByLibrary.simpleMessage("로그인할 필요 없이 작동됩니다."),
    "local_b2": MessageLookupByLibrary.simpleMessage(
      "전체 라이브러리는 이 컴퓨터에만 유지됩니다.",
    ),
    "local_b3": MessageLookupByLibrary.simpleMessage(
      "참고: 수동 클라우드 백업은 없습니다. 기기를 분실하거나 앱을 제거한 경우 데이터를 복구할 수 없습니다.",
    ),
    "local_btn": MessageLookupByLibrary.simpleMessage("이 기기에서만 사용하세요"),
    "local_subtitle": MessageLookupByLibrary.simpleMessage(
      "귀하의 장치에 대한 완벽한 개인 정보 보호",
    ),
    "local_title": MessageLookupByLibrary.simpleMessage("로컬 모드"),
    "low": MessageLookupByLibrary.simpleMessage("낮음"),
    "lyricsNotAvailable": MessageLookupByLibrary.simpleMessage("가사를 찾지 못했습니다!"),
    "manageCollaborators": MessageLookupByLibrary.simpleMessage("공동작업자(친구) 관리"),
    "micInstruction": MessageLookupByLibrary.simpleMessage(
      "마이크 근처에서 음악이 충분히 크게 재생되는지 확인하세요.",
    ),
    "migratedAlbum": MessageLookupByLibrary.simpleMessage("이전된 앨범"),
    "migratedLibrary": MessageLookupByLibrary.simpleMessage("마이그레이션된 라이브러리"),
    "migratedPlaylist": MessageLookupByLibrary.simpleMessage("마이그레이션된 재생목록"),
    "migrationAlreadyRunning": MessageLookupByLibrary.simpleMessage(
      "이미 마이그레이션이 진행 중입니다.",
    ),
    "migrationAnalyzingLocal": MessageLookupByLibrary.simpleMessage(
      "지역 도서관을 분석하는 중...",
    ),
    "migrationCheckingCloud": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud에 이미 라이브러리가 있는지 확인하는 중...",
    ),
    "migrationCompleted": MessageLookupByLibrary.simpleMessage(
      "마이그레이션이 완료되었습니다.",
    ),
    "migrationCreatingBackup": MessageLookupByLibrary.simpleMessage(
      "클라우드에 연결하기 전에 로컬 백업 생성 중...",
    ),
    "migrationFailedLocalPreserved": MessageLookupByLibrary.simpleMessage(
      "마이그레이션이 실패했습니다. 로컬 데이터가 수정되지 않았습니다.",
    ),
    "migrationLoginRequired": MessageLookupByLibrary.simpleMessage(
      "마이그레이션하기 전에 Joss Red에 로그인하세요.",
    ),
    "migrationPreparingCloud": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud에서 마이그레이션 준비 중...",
    ),
    "migrationStartFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud가 마이그레이션을 시작할 수 없습니다.",
    ),
    "migrationUploadIncomplete": MessageLookupByLibrary.simpleMessage(
      "모든 데이터를 업로드할 수는 없습니다. 우리는 귀하의 지역 지원을 유지합니다.",
    ),
    "migrationUploadingData": MessageLookupByLibrary.simpleMessage(
      "재생목록, 즐겨찾기, 기록 업로드 중...",
    ),
    "migrationValidationFailed": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud가 마이그레이션을 검증할 수 없습니다.",
    ),
    "migrationVerifyingIntegrity": MessageLookupByLibrary.simpleMessage(
      "EMusic Cloud에서 무결성을 확인하는 중...",
    ),
    "migration_btn_select": MessageLookupByLibrary.simpleMessage(
      "파일을 선택하고 가져오기",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("분"),
    "mostListenedSong": MessageLookupByLibrary.simpleMessage("가장 많이 듣는 노래"),
    "musicRecognition": MessageLookupByLibrary.simpleMessage("음악 인식"),
    "networkError1": MessageLookupByLibrary.simpleMessage("네트워크 에러!"),
    "newVersionAvailable": MessageLookupByLibrary.simpleMessage(
      "새 버전을 이용할 수 있음!",
    ),
    "news_btn_app": MessageLookupByLibrary.simpleMessage("조스 레드 앱(Play 스토어)"),
    "news_btn_dismiss": MessageLookupByLibrary.simpleMessage("이해했다"),
    "news_btn_web": MessageLookupByLibrary.simpleMessage("조스 레드 웹"),
    "news_card_subtitle": MessageLookupByLibrary.simpleMessage(
      "Joss Red와의 100% 동기화, 친구들과의 재생 목록 등. 새로운 소식을 보려면 탭하세요.",
    ),
    "news_card_title": MessageLookupByLibrary.simpleMessage(
      "Estrella Music이 진화했습니다!",
    ),
    "news_dialog_friends_desc": MessageLookupByLibrary.simpleMessage(
      "친구를 추가하고, 요청을 수락하고, 보안 프로필을 관리하려면 공식 플랫폼에서 Joss Red를 사용하세요.",
    ),
    "news_dialog_section_friends": MessageLookupByLibrary.simpleMessage(
      "친구 및 계정 관리:",
    ),
    "news_dialog_title": MessageLookupByLibrary.simpleMessage("Estrella 음악 뉴스"),
    "news_item_collab_desc": MessageLookupByLibrary.simpleMessage(
      "친구들과 함께 재생목록을 만들어보세요! 재생목록을 생성할 때 공동작업 확인란을 선택하고 함께 편집할 친구를 선택하세요.",
    ),
    "news_item_collab_title": MessageLookupByLibrary.simpleMessage("공동 재생 목록"),
    "news_item_sync_desc": MessageLookupByLibrary.simpleMessage(
      "이제 재생 목록과 즐겨찾기가 기본 Joss Red 계정을 통해 자동으로 클라우드에 저장되고 동기화됩니다.",
    ),
    "news_item_sync_title": MessageLookupByLibrary.simpleMessage(
      "Joss Red와의 완전한 통합",
    ),
    "news_item_trans_desc": MessageLookupByLibrary.simpleMessage(
      "더 이상 수동 동기화 버튼을 클릭할 필요가 없습니다. 새 모터는 자동으로 위아래로 변속을 담당합니다.",
    ),
    "news_item_trans_title": MessageLookupByLibrary.simpleMessage("투명한 동기화"),
    "noBookmarks": MessageLookupByLibrary.simpleMessage("북마크 없음!"),
    "noJossRedFriends": MessageLookupByLibrary.simpleMessage(
      "Joss Red에 추가된 친구가 없습니다.",
    ),
    "noLibPlaylist": MessageLookupByLibrary.simpleMessage(
      "라이브러리 플레이리스트가 없습니다!",
    ),
    "noMatchInstruction": MessageLookupByLibrary.simpleMessage(
      "녹음된 오디오에서 노래를 찾을 수 없습니다.",
    ),
    "noMatchesFound": MessageLookupByLibrary.simpleMessage("일치하는 항목 없음"),
    "noOfflineSong": MessageLookupByLibrary.simpleMessage("오프라인 음악이 없습니다!"),
    "noSongsInCollection": MessageLookupByLibrary.simpleMessage(
      "이 컬렉션에는 노래가 없습니다",
    ),
    "nomatch": MessageLookupByLibrary.simpleMessage("검색결과 없음"),
    "notAuthenticated": MessageLookupByLibrary.simpleMessage("인증되지 않음"),
    "notaSongVideo": MessageLookupByLibrary.simpleMessage("음악/뮤직비디오가 아님!"),
    "notaValidLink": MessageLookupByLibrary.simpleMessage("유효한 링크가 아님!"),
    "openIn": MessageLookupByLibrary.simpleMessage("열기"),
    "operationFailed": MessageLookupByLibrary.simpleMessage("동작 실패"),
    "password": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "password_text": MessageLookupByLibrary.simpleMessage("비밀번호"),
    "permissionsAllow": MessageLookupByLibrary.simpleMessage("허용하다"),
    "permissionsConsentDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music은 음악을 관리하고 모든 재생 기능을 제공하려면 이러한 권한이 필요합니다.",
    ),
    "permissionsConsentTitle": MessageLookupByLibrary.simpleMessage(
      "시작하기 위한 권한",
    ),
    "permissionsContinueButton": MessageLookupByLibrary.simpleMessage(
      "필수 권한 부여",
    ),
    "permissionsMicrophoneDescription": MessageLookupByLibrary.simpleMessage(
      "주변에서 재생되는 노래를 식별하기로 선택한 경우에만 사용됩니다.",
    ),
    "permissionsMicrophoneTitle": MessageLookupByLibrary.simpleMessage("마이크로폰"),
    "permissionsNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "재생 제어, 다운로드 진행 상황, 중요한 앱 알림을 표시합니다.",
    ),
    "permissionsNotificationsTitle": MessageLookupByLibrary.simpleMessage("알림"),
    "permissionsOpenSettings": MessageLookupByLibrary.simpleMessage("설정"),
    "permissionsRequiredNotice": MessageLookupByLibrary.simpleMessage(
      "계속하려면 세 가지 허가가 모두 필요합니다. 나중에 시스템 설정에서 변경할 수 있습니다.",
    ),
    "permissionsStorageDescription": MessageLookupByLibrary.simpleMessage(
      "음악을 재생하고, 다운로드를 저장하고, 재생 목록을 내보내고, 업데이트를 준비할 수 있습니다.",
    ),
    "permissionsStorageTitle": MessageLookupByLibrary.simpleMessage(
      "음악 및 저장공간",
    ),
    "pipedPlaylistDescription": MessageLookupByLibrary.simpleMessage(
      "파이프 재생목록",
    ),
    "pipedplstSyncAlert": MessageLookupByLibrary.simpleMessage(
      "Piped 플레이리스트 동기화됨!",
    ),
    "plain": MessageLookupByLibrary.simpleMessage("보통"),
    "playNext": MessageLookupByLibrary.simpleMessage("다음에 재생"),
    "playNow": MessageLookupByLibrary.simpleMessage("지금 플레이"),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("재생 속도"),
    "playingRecognizedTrack": MessageLookupByLibrary.simpleMessage("재생 중:"),
    "playlistBlacklistAlert": MessageLookupByLibrary.simpleMessage(
      "플레이리스트를 블랙리스트에 추가함!",
    ),
    "playlistBookmarkAddAlert": MessageLookupByLibrary.simpleMessage(
      "플레이리스트를 즐겨찾기에 추가함!",
    ),
    "playlistBookmarkRemoveAlert": MessageLookupByLibrary.simpleMessage(
      "플레이리스트 즐겨찾기 제거함!",
    ),
    "playlistCollaboratorsTitle": MessageLookupByLibrary.simpleMessage(
      "재생목록 참여자",
    ),
    "playlistCreatedAlert": MessageLookupByLibrary.simpleMessage("플레이리스트 생성됨!"),
    "playlistCreatednsongAddedAlert": MessageLookupByLibrary.simpleMessage(
      "플레이리스트를 생성하고 음악 추가함!",
    ),
    "playlistRemovedAlert": MessageLookupByLibrary.simpleMessage("플레이리스트 삭제함!"),
    "playlistRenameAlert": MessageLookupByLibrary.simpleMessage("이름 바꾸기 완료!"),
    "playlists": MessageLookupByLibrary.simpleMessage("플레이리스트"),
    "popularTracks": MessageLookupByLibrary.simpleMessage("인기 트랙"),
    "processingAudio": MessageLookupByLibrary.simpleMessage("오디오 처리 중..."),
    "quickpicks": MessageLookupByLibrary.simpleMessage("빠른 추천"),
    "radioNotAvailable": MessageLookupByLibrary.simpleMessage(
      "이 아티스트의 라디오는 없습니다!",
    ),
    "reArrangePlaylist": MessageLookupByLibrary.simpleMessage("플레이리스트 순서 변경"),
    "readMore": MessageLookupByLibrary.simpleMessage("더 읽어보세요"),
    "recentSearches": MessageLookupByLibrary.simpleMessage("최근 검색어"),
    "recentlyPlayed": MessageLookupByLibrary.simpleMessage("최근 재생됨"),
    "recommend_cloud": MessageLookupByLibrary.simpleMessage(
      "Spotify와 같은 경험을 위해서는 클라우드 모드를 활성화하는 것이 좋습니다. 아무 것도 하지 않고도 모든 장치 간의 실시간 동기화와 자동 백업이 가능합니다.",
    ),
    "recommendedAlbums": MessageLookupByLibrary.simpleMessage("추천"),
    "recommendedArtists": MessageLookupByLibrary.simpleMessage("추천"),
    "removeFromLib": MessageLookupByLibrary.simpleMessage("라이브러리 음악에서 제거"),
    "removeFromPlaylist": MessageLookupByLibrary.simpleMessage("플레이리스트에서 제거"),
    "removeFromQueue": MessageLookupByLibrary.simpleMessage("대기열에서 제거"),
    "removeMultiple": MessageLookupByLibrary.simpleMessage("여러 개의 음악을 제거"),
    "removePlaylist": MessageLookupByLibrary.simpleMessage("플레이리스트 삭제"),
    "rename": MessageLookupByLibrary.simpleMessage("이름 바꾸기"),
    "renamePlaylist": MessageLookupByLibrary.simpleMessage("플레이리스트 이름 변경"),
    "reproducedBy": MessageLookupByLibrary.simpleMessage("재생산자:"),
    "reset": MessageLookupByLibrary.simpleMessage("초기화"),
    "resetblacklistedplaylist": MessageLookupByLibrary.simpleMessage(
      "블랙리스트에 추가한 플레이리스트를 초기화",
    ),
    "resetblacklistedplaylistDes": MessageLookupByLibrary.simpleMessage(
      "블랙리스트에 추가한 Piped의 모든 플레이리스트를 초기화",
    ),
    "restoreLastPlaybackSession": MessageLookupByLibrary.simpleMessage(
      "마지막 재생 세션을 복원",
    ),
    "restoreLastPlaybackSessionDes": MessageLookupByLibrary.simpleMessage(
      "앱 시작 시 자동으로 마지막 재생 세션을 복원",
    ),
    "results": MessageLookupByLibrary.simpleMessage("결과"),
    "retry": MessageLookupByLibrary.simpleMessage("재시도!"),
    "save": MessageLookupByLibrary.simpleMessage("유지하다"),
    "savedAlbums": MessageLookupByLibrary.simpleMessage("저장됨"),
    "scanning": MessageLookupByLibrary.simpleMessage("스캔하는 중..."),
    "search": MessageLookupByLibrary.simpleMessage("검색"),
    "searchDes": MessageLookupByLibrary.simpleMessage("음악,플레이리스트,앨범 혹은 아티스트"),
    "searchInLibrary": MessageLookupByLibrary.simpleMessage("도서관에서 검색"),
    "searchRes": MessageLookupByLibrary.simpleMessage("검색 결과"),
    "search_recent_title": MessageLookupByLibrary.simpleMessage("최근 검색어"),
    "selectAuthIns": MessageLookupByLibrary.simpleMessage("인증 인스턴스를 선택"),
    "selectAuthInsMsg": MessageLookupByLibrary.simpleMessage(
      "인증 인스턴스를 선택해주세요!",
    ),
    "selectedFileNotFound": MessageLookupByLibrary.simpleMessage(
      "선택한 파일을 찾을 수 없습니다.",
    ),
    "sessionExpiredLoginAgain": MessageLookupByLibrary.simpleMessage(
      "세션이 만료되었습니다. 다시 로그인하세요.",
    ),
    "setDiscoverContent": MessageLookupByLibrary.simpleMessage("탐색할 컨텐츠를 설정"),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "settings_about_desc": MessageLookupByLibrary.simpleMessage(
      "Estrella Music 소개",
    ),
    "settings_about_sub": MessageLookupByLibrary.simpleMessage(
      "버전, 오픈 소스 프로젝트 및 GitHub.",
    ),
    "settings_account_desc": MessageLookupByLibrary.simpleMessage("계정 및 동기화"),
    "settings_account_sub": MessageLookupByLibrary.simpleMessage(
      "클라우드 모드, 백업, 친구 목록 및 마이그레이션.",
    ),
    "settings_appearance_desc": MessageLookupByLibrary.simpleMessage(
      "테마, 언어 및 인터페이스 애니메이션.",
    ),
    "settings_cloud_backup": MessageLookupByLibrary.simpleMessage("클라우드 백업"),
    "settings_cloud_backup_desc": MessageLookupByLibrary.simpleMessage(
      "업로드, 복원 및 관리...",
    ),
    "settings_content_desc": MessageLookupByLibrary.simpleMessage(
      "필터, Piped 및 캐시와의 통합을 살펴보세요.",
    ),
    "settings_downloads_desc": MessageLookupByLibrary.simpleMessage(
      "다운로드 및 저장",
    ),
    "settings_downloads_sub": MessageLookupByLibrary.simpleMessage(
      "오디오 형식, 폴더 및 자동 다운로드.",
    ),
    "settings_general_section": MessageLookupByLibrary.simpleMessage("일반적인"),
    "settings_local_cloud_desc": MessageLookupByLibrary.simpleMessage(
      "Joss Red와의 동기화 상태를 선택, 마이그레이션 또는 검토하세요.",
    ),
    "settings_local_cloud_title": MessageLookupByLibrary.simpleMessage(
      "로컬 모드 / EMusic Cloud",
    ),
    "settings_logout": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "settings_migration_desc": MessageLookupByLibrary.simpleMessage(
      "재생목록, 노래 가져오기...",
    ),
    "settings_migration_title": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlin에서 마이그레이션",
    ),
    "settings_my_friends": MessageLookupByLibrary.simpleMessage("내 친구들"),
    "settings_my_friends_desc": MessageLookupByLibrary.simpleMessage(
      "Joss Red 친구를 직접 관리하세요.",
    ),
    "settings_playback_desc": MessageLookupByLibrary.simpleMessage(
      "스트리밍 품질, 정규화, 무음 및 배터리.",
    ),
    "settings_refresh_visitor_desc": MessageLookupByLibrary.simpleMessage(
      "Discover 콘텐츠가 로드되지 않으면 YouTube Music ID를 다시 생성하세요.",
    ),
    "settings_refresh_visitor_title": MessageLookupByLibrary.simpleMessage(
      "새로고침 ID(방문자 ID)",
    ),
    "settings_visitor_error": MessageLookupByLibrary.simpleMessage("실수"),
    "settings_visitor_error_desc": MessageLookupByLibrary.simpleMessage(
      "새 식별자를 생성할 수 없습니다. 나중에 다시 시도해 주세요.",
    ),
    "settings_visitor_exception": m1,
    "settings_visitor_updated": MessageLookupByLibrary.simpleMessage(
      "업데이트된 식별자",
    ),
    "settings_visitor_updated_desc": MessageLookupByLibrary.simpleMessage(
      "새 방문자 ID가 성공적으로 생성되었습니다.",
    ),
    "shareSong": MessageLookupByLibrary.simpleMessage("이 곡을 공유"),
    "shazamSearching": MessageLookupByLibrary.simpleMessage(
      "Shazam 데이터베이스에서 일치하는 항목을 검색하는 중...",
    ),
    "similarToTitle": m2,
    "singles": MessageLookupByLibrary.simpleMessage("싱글"),
    "skipSilence": MessageLookupByLibrary.simpleMessage("묵음 건너뛰기"),
    "skipSilenceDes": MessageLookupByLibrary.simpleMessage(
      "음악 재생 중에 묵음이 있는 구간은 건너뛰어집니다",
    ),
    "sleepTimeSetAlert": MessageLookupByLibrary.simpleMessage("취침 타이머가 설정됨"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("취침 타이머"),
    "slide_indicator": m3,
    "songAddedToPlaylistAlert": MessageLookupByLibrary.simpleMessage(
      "플레이리스트에 음악 추가됨!",
    ),
    "songAlreadyExists": MessageLookupByLibrary.simpleMessage("음악이 이미 있습니다!"),
    "songAlreadyOfflineAlert": MessageLookupByLibrary.simpleMessage(
      "음악이 이미 캐시에 있습니다",
    ),
    "songEnqueueAlert": MessageLookupByLibrary.simpleMessage("대기열에 음악 추가됨!"),
    "songFound": MessageLookupByLibrary.simpleMessage("노래 발견!"),
    "songPitch": MessageLookupByLibrary.simpleMessage("노래 톤"),
    "songRemovedAlert": MessageLookupByLibrary.simpleMessage("다음으로부터 제거됨"),
    "songRemovedfromQueue": MessageLookupByLibrary.simpleMessage("대기열에서 제거됨!"),
    "songRemovedfromQueueCurrSong": MessageLookupByLibrary.simpleMessage(
      "지금 재생중인 곡을 제거할 순 없습니다",
    ),
    "songs": MessageLookupByLibrary.simpleMessage("음악"),
    "songsImportedFromJossMusic": MessageLookupByLibrary.simpleMessage(
      "Joss Music Kotlin에서 가져온 노래",
    ),
    "speedAndPitch": MessageLookupByLibrary.simpleMessage("속도와 피치"),
    "startRadio": MessageLookupByLibrary.simpleMessage("라디오 시작"),
    "startupScreen": MessageLookupByLibrary.simpleMessage("시작 시 열기"),
    "startupScreenDescription": MessageLookupByLibrary.simpleMessage(
      "Estrella Music이 먼저 열리는 섹션을 선택하세요.",
    ),
    "status": MessageLookupByLibrary.simpleMessage("상태"),
    "stopMusicOnTaskClear": MessageLookupByLibrary.simpleMessage(
      "작업 관리자에서 종료되면 음악을 끝냄",
    ),
    "stopMusicOnTaskClearDes": MessageLookupByLibrary.simpleMessage(
      "작업 관리자에서 앱이 종료되면 음악이 더이상 재생되지 않습니다",
    ),
    "streamingQuality": MessageLookupByLibrary.simpleMessage("스트리밍 음질"),
    "streamingQualityDes": MessageLookupByLibrary.simpleMessage("음악 스트림의 음질"),
    "subscribers": MessageLookupByLibrary.simpleMessage("구독자"),
    "swipe_prompt": MessageLookupByLibrary.simpleMessage("스와이프하여 옵션 탐색 ➔"),
    "syncChangesConfirmed": m4,
    "syncChangesSynced": m5,
    "syncCloudDownloadingExisting": MessageLookupByLibrary.simpleMessage(
      "클라우드 모드가 활성화되었습니다. 기존 라이브러리를 다운로드합니다.",
    ),
    "syncCloudMigrationComplete": MessageLookupByLibrary.simpleMessage(
      "클라우드 모드가 활성화되었습니다. 마이그레이션된 라이브러리.",
    ),
    "syncCloudModeActive": MessageLookupByLibrary.simpleMessage("클라우드 모드 활성화"),
    "syncCloudPending": MessageLookupByLibrary.simpleMessage(
      "클라우드 모드가 활성화되었습니다. 동기화 대기 중입니다.",
    ),
    "syncDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "동기화를 다운로드하지 못했습니다.",
    ),
    "syncDownloading": MessageLookupByLibrary.simpleMessage(
      "EMusic 변경사항 다운로드 중...",
    ),
    "syncLibrarySynced": MessageLookupByLibrary.simpleMessage("동기화된 라이브러리."),
    "syncLibraryUpToDate": MessageLookupByLibrary.simpleMessage(
      "라이브러리가 최신 상태입니다.",
    ),
    "syncLocalChangesFirst": MessageLookupByLibrary.simpleMessage(
      "새로운 로컬 변경 사항이 있습니다. 다운로드하기 전에 업로드됩니다.",
    ),
    "syncLocalDeviceOnly": MessageLookupByLibrary.simpleMessage(
      "귀하의 데이터는 이 장치에만 보관됩니다.",
    ),
    "syncLocalModeActive": MessageLookupByLibrary.simpleMessage("로컬 모드 활성화"),
    "syncOfflinePending": MessageLookupByLibrary.simpleMessage(
      "오프라인. 변경사항이 보류 중입니다.",
    ),
    "syncOfflineRetry": MessageLookupByLibrary.simpleMessage(
      "오프라인. 재시도를 위해 변경사항이 저장되었습니다.",
    ),
    "syncUnconfirmedRetry": MessageLookupByLibrary.simpleMessage(
      "EMusic은 모든 변경 사항을 확인하지 않았습니다. 재시도될 것입니다.",
    ),
    "syncUploadRetry": MessageLookupByLibrary.simpleMessage(
      "일어날 수 없었다. 나중에 다시 시도됩니다.",
    ),
    "syncUploadSuccess": MessageLookupByLibrary.simpleMessage(
      "변경사항이 올바르게 업로드되었습니다.",
    ),
    "syncUploadSuccessWs": MessageLookupByLibrary.simpleMessage(
      "변경사항이 성공적으로 업로드되었습니다(WS).",
    ),
    "syncUploadWsRetry": MessageLookupByLibrary.simpleMessage(
      "WS를 사용하여 업로드할 수 없습니다. 나중에 다시 시도됩니다.",
    ),
    "syncUploading": MessageLookupByLibrary.simpleMessage(
      "EMusic에 변경사항을 업로드하는 중...",
    ),
    "synced": MessageLookupByLibrary.simpleMessage("동기화됨"),
    "syncedLyricsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "동기화된 가사를 찾지 못했습니다!",
    ),
    "systemDefault": MessageLookupByLibrary.simpleMessage("시스템 기본"),
    "themeMode": MessageLookupByLibrary.simpleMessage("테마 모드"),
    "topmusicvideos": MessageLookupByLibrary.simpleMessage("인기 뮤직 비디오"),
    "trending": MessageLookupByLibrary.simpleMessage("인기 급상승"),
    "unLink": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "unlinkAlert": MessageLookupByLibrary.simpleMessage("로그아웃 성공!"),
    "untitledSong": MessageLookupByLibrary.simpleMessage("제목 없는 노래"),
    "upNext": MessageLookupByLibrary.simpleMessage("재생 예정"),
    "userBlocked": MessageLookupByLibrary.simpleMessage("차단된 사용자"),
    "userListMissing": MessageLookupByLibrary.simpleMessage(
      "응답에는 사용자 목록이 포함되어 있지 않습니다.",
    ),
    "userSearchFailed": m6,
    "userUnblocked": MessageLookupByLibrary.simpleMessage("잠금 해제된 사용자"),
    "username": MessageLookupByLibrary.simpleMessage("사용자 이름"),
    "video": MessageLookupByLibrary.simpleMessage("동영상"),
    "videos": MessageLookupByLibrary.simpleMessage("동영상"),
    "viewAll": MessageLookupByLibrary.simpleMessage("모두 보기"),
    "viewArtist": MessageLookupByLibrary.simpleMessage("아티스트 정보"),
    "welcome_intro": MessageLookupByLibrary.simpleMessage(
      "우리는 플랫폼을 현대화했습니다. 수동 백업을 업로드하는 이전 시스템이 비활성화되었습니다. 이제 음악 라이브러리를 관리하는 두 가지 명확한 방법이 있습니다.",
    ),
    "welcome_subtitle": MessageLookupByLibrary.simpleMessage(
      "지금부터 Estrella Music을 어떻게 경험하고 싶은지 선택하세요.",
    ),
    "welcome_title": MessageLookupByLibrary.simpleMessage("나만의 음악, 나만의 방식"),
  };
}
