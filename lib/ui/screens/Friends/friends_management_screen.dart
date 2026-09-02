import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/sync/sync_service.dart';
import 'package:estrella_music/ui/widgets/snackbar.dart';

class FriendsManagementScreen extends StatefulWidget {
  const FriendsManagementScreen({super.key});

  @override
  State<FriendsManagementScreen> createState() =>
      _FriendsManagementScreenState();
}

class _FriendsManagementScreenState extends State<FriendsManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SyncService _syncService = Get.find<SyncService>();

  List<dynamic> _friends = [];
  List<dynamic> _requests = [];
  List<dynamic> _blocked = [];
  List<dynamic> _searchResults = [];

  bool _isLoadingFriends = false;
  bool _isLoadingRequests = false;
  bool _isLoadingBlocked = false;
  bool _isSearching = false;
  String? _searchError;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadInitialData();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;
    _reloadDataForActiveTab();
  }

  void _reloadDataForActiveTab() {
    switch (_tabController.index) {
      case 0:
        _loadFriends();
        break;
      case 1:
        _loadRequests();
        break;
      case 3:
        _loadBlocked();
        break;
    }
  }

  Future<void> _loadInitialData() async {
    await _loadFriends();
    await _loadRequests();
  }

  Future<void> _loadFriends() async {
    setState(() => _isLoadingFriends = true);
    try {
      final data = await _syncService.fetchFriends();
      setState(() {
        _friends = data;
      });
    } catch (_) {}
    setState(() => _isLoadingFriends = false);
  }

  Future<void> _loadRequests() async {
    setState(() => _isLoadingRequests = true);
    try {
      final data = await _syncService.fetchRequests();
      setState(() {
        _requests = data;
      });
    } catch (_) {}
    setState(() => _isLoadingRequests = false);
  }

  Future<void> _loadBlocked() async {
    setState(() => _isLoadingBlocked = true);
    try {
      final data = await _syncService.fetchBlocked();
      setState(() {
        _blocked = data;
      });
    } catch (_) {}
    setState(() => _isLoadingBlocked = false);
  }

  Future<void> _performSearch(String query) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) return;
    setState(() {
      _isSearching = true;
      _searchError = null;
    });
    try {
      final data = await _syncService.searchUsers(normalizedQuery);
      if (!mounted) return;
      setState(() {
        _searchResults = data;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _searchResults = [];
        _searchError = error.toString().replaceFirst(RegExp(r'^[^:]+:\s*'), '');
      });
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  Future<void> _sendRequest(int friendId) async {
    final result = await _syncService.sendFriendRequest(friendId);
    _showToast(result['message'] ??
        (result['success'] == true ? "Solicitud enviada" : "Error"));
    if (result['success'] == true && _searchController.text.isNotEmpty) {
      _performSearch(_searchController.text);
    }
  }

  Future<void> _acceptRequest(int friendId) async {
    final result = await _syncService.acceptFriendRequest(friendId);
    _showToast(result['message'] ??
        (result['success'] == true ? "Solicitud aceptada" : "Error"));
    if (result['success'] == true) {
      _loadRequests();
      _loadFriends();
    }
  }

  Future<void> _removeFriend(int friendId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Eliminar amigo",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        content: Text(
            "¿Estás seguro de que quieres eliminar a este usuario de tus amigos?",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final result = await _syncService.removeFriendship(friendId);
    _showToast(result['message'] ??
        (result['success'] == true ? "Amigo eliminado" : "Error"));
    if (result['success'] == true) {
      _loadFriends();
      _loadRequests();
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      }
    }
  }

  Future<void> _blockUser(int friendId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("Bloquear usuario",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        content: Text("¿Estás seguro de que deseas bloquear a este usuario?",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text("Bloquear"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final result = await _syncService.blockUser(friendId);
    _showToast(result['message'] ??
        (result['success'] == true ? "Usuario bloqueado" : "Error"));
    if (result['success'] == true) {
      _loadFriends();
      _loadRequests();
      _loadBlocked();
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      }
    }
  }

  Future<void> _unblockUser(int friendId) async {
    final result = await _syncService.unblockUser(friendId);
    _showToast(result['message'] ??
        (result['success'] == true ? "Usuario desbloqueado" : "Error"));
    if (result['success'] == true) {
      _loadBlocked();
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      }
    }
  }

  void _showToast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      snackbar(context, message,
          size: SanckBarSize.MEDIUM, duration: const Duration(seconds: 2)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          "Mis Amigos",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          tabs: [
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.people_alt_rounded),
                  const SizedBox(width: 8),
                  const Text("Amigos"),
                  if (_friends.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Badge(label: Text('${_friends.length}')),
                  ]
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.mail_rounded),
                  const SizedBox(width: 8),
                  const Text("Solicitudes"),
                  if (_requests.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Badge(
                      label: Text('${_requests.length}'),
                      backgroundColor: colorScheme.error,
                    ),
                  ]
                ],
              ),
            ),
            const Tab(
              child: Row(
                children: [
                  Icon(Icons.search_rounded),
                  SizedBox(width: 8),
                  Text("Buscar"),
                ],
              ),
            ),
            Tab(
              child: Row(
                children: [
                  const Icon(Icons.block_rounded),
                  const SizedBox(width: 8),
                  const Text("Bloqueados"),
                  if (_blocked.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Badge(
                      label: Text('${_blocked.length}'),
                      backgroundColor: colorScheme.outline,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFriendsTab(),
          _buildRequestsTab(),
          _buildSearchTab(),
          _buildBlockedTab(),
        ],
      ),
    );
  }

  Widget _buildFriendsTab() {
    if (_isLoadingFriends) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_friends.isEmpty) {
      return _buildEmptyState(
        icon: Icons.people_outline_rounded,
        title: "No tienes amigos agregados aún",
        subtitle:
            "Ve a la pestaña 'Buscar' para encontrar amigos y enviar solicitudes.",
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFriends,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          final friend = _friends[index];
          final String firstName = friend['first_name'] ?? '';
          final String lastName = friend['last_name'] ?? '';
          final String username = friend['username'] ?? '';
          final String initial =
              (firstName.isNotEmpty) ? firstName[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  initial,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(
                "$firstName $lastName".trim(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text("@$username",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.block_rounded,
                        color: Theme.of(context).colorScheme.error),
                    tooltip: "Bloquear",
                    onPressed: () => _blockUser(friend['id']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    tooltip: "Eliminar Amigo",
                    onPressed: () => _removeFriend(friend['id']),
                  ),
                ],
              ),
            ),
          ).animate().fade(delay: (index * 50).ms).slideY(begin: 0.05);
        },
      ),
    );
  }

  Widget _buildRequestsTab() {
    if (_isLoadingRequests) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_requests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.mail_outline_rounded,
        title: "No tienes solicitudes de amistad",
        subtitle:
            "Aquí aparecerán las solicitudes entrantes que te envíen otros usuarios.",
      );
    }

    return RefreshIndicator(
      onRefresh: _loadRequests,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final req = _requests[index];
          final String firstName = req['first_name'] ?? '';
          final String lastName = req['last_name'] ?? '';
          final String username = req['username'] ?? '';
          final String initial =
              (firstName.isNotEmpty) ? firstName[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$firstName $lastName".trim(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Text("@$username",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant)),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.check_rounded),
                    tooltip: "Aceptar",
                    onPressed: () => _acceptRequest(req['user_id']),
                  ),
                  const SizedBox(width: 8),
                  IconButton.outlined(
                    icon: Icon(Icons.close_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    tooltip: "Rechazar",
                    onPressed: () => _removeFriend(req['user_id']),
                  ),
                ],
              ),
            ),
          ).animate().fade(delay: (index * 50).ms).slideY(begin: 0.05);
        },
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SearchBar(
            controller: _searchController,
            hintText: "Buscar usuarios por username...",
            hintStyle: WidgetStateProperty.all(TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
            textStyle: WidgetStateProperty.all(
                TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            leading: Icon(Icons.search_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            trailing: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults = [];
                      _searchError = null;
                    });
                  },
                ),
            ],
            onSubmitted: _performSearch,
            onChanged: (val) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          if (_isSearching)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_searchError != null)
            Expanded(
              child: _buildEmptyState(
                icon: Icons.error_outline_rounded,
                title: "No se pudo buscar",
                subtitle: _searchError!,
              ),
            )
          else if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
            Expanded(
              child: _buildEmptyState(
                icon: Icons.search_off_rounded,
                title: "No se encontraron usuarios",
                subtitle: "Prueba con otro username o correo electrónico.",
              ),
            )
          else if (_searchResults.isEmpty)
            Expanded(
              child: _buildEmptyState(
                icon: Icons.explore_outlined,
                title: "Encuentra nuevos amigos",
                subtitle: "Busca su username o correo de Joss Red arriba.",
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final user = _searchResults[index];
                  final String firstName = user['first_name'] ?? '';
                  final String lastName = user['last_name'] ?? '';
                  final String username = user['username'] ?? '';
                  final String status = user['status'] ?? 'none';
                  final String initial =
                      (firstName.isNotEmpty) ? firstName[0].toUpperCase() : '?';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        child: Text(
                          initial,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                      ),
                      title: Text(
                        "$firstName $lastName".trim(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      subtitle: Text("@$username",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                      trailing: _buildSearchAction(user['id'], status),
                    ),
                  ).animate().fade(delay: (index * 50).ms).slideY(begin: 0.05);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchAction(int friendId, String status) {
    switch (status) {
      case 'accepted':
        return TextButton.icon(
          onPressed: () => _removeFriend(friendId),
          icon: const Icon(Icons.people_rounded),
          label: const Text("Amigo"),
        );
      case 'pending_sent':
        return OutlinedButton.icon(
          onPressed: () => _removeFriend(friendId),
          icon: const Icon(Icons.close_rounded),
          label: const Text("Cancelar"),
        );
      case 'pending_received':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              icon: const Icon(Icons.check_rounded),
              onPressed: () => _acceptRequest(friendId),
            ),
            const SizedBox(width: 4),
            IconButton.outlined(
              icon: Icon(Icons.close_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              onPressed: () => _removeFriend(friendId),
            ),
          ],
        );
      case 'blocked_by_me':
        return FilledButton.tonal(
          onPressed: () => _unblockUser(friendId),
          child: const Text("Desbloquear"),
        );
      case 'blocked_by_them':
        return Text(
          "No disponible",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic),
        );
      default:
        return FilledButton.icon(
          onPressed: () => _sendRequest(friendId),
          icon: const Icon(Icons.person_add_rounded),
          label: const Text("Agregar"),
        );
    }
  }

  Widget _buildBlockedTab() {
    if (_isLoadingBlocked) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_blocked.isEmpty) {
      return _buildEmptyState(
        icon: Icons.block_rounded,
        title: "No tienes usuarios bloqueados",
        subtitle:
            "Los usuarios que bloquees aparecerán listados en esta pestaña.",
      );
    }

    return RefreshIndicator(
      onRefresh: _loadBlocked,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _blocked.length,
        itemBuilder: (context, index) {
          final block = _blocked[index];
          final String firstName = block['first_name'] ?? '';
          final String lastName = block['last_name'] ?? '';
          final String username = block['username'] ?? '';
          final String initial =
              (firstName.isNotEmpty) ? firstName[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Text(
                  initial,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              title: Text(
                "$firstName $lastName".trim(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text("@$username",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              trailing: FilledButton.tonal(
                onPressed: () => _unblockUser(block['id']),
                child: const Text("Desbloquear"),
              ),
            ),
          ).animate().fade(delay: (index * 50).ms).slideY(begin: 0.05);
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 400.ms);
  }
}
