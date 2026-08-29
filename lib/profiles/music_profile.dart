import 'package:flutter/foundation.dart';

enum MusicProfileAvailability {
  available,
  providerUnavailable,
  initializationFailed
}

@immutable
class MusicProfile {
  const MusicProfile({
    required this.id,
    required this.name,
    required this.providerId,
    this.settings = const {},
    this.metadata = const {},
    this.availability = MusicProfileAvailability.available,
    this.errorMessage,
    this.isFallback = false,
  });

  final String id;
  final String name;
  final String providerId;
  final Map<String, dynamic> settings;
  final Map<String, dynamic> metadata;
  final MusicProfileAvailability availability;
  final String? errorMessage;
  final bool isFallback;

  MusicProfile copyWith({
    String? name,
    String? providerId,
    Map<String, dynamic>? settings,
    Map<String, dynamic>? metadata,
    MusicProfileAvailability? availability,
    String? errorMessage,
    bool clearError = false,
    bool? isFallback,
  }) =>
      MusicProfile(
        id: id,
        name: name ?? this.name,
        providerId: providerId ?? this.providerId,
        settings: settings ?? this.settings,
        metadata: metadata ?? this.metadata,
        availability: availability ?? this.availability,
        errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
        isFallback: isFallback ?? this.isFallback,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'providerId': providerId,
        'settings': settings,
        'metadata': metadata,
        'availability': availability.name,
        'errorMessage': errorMessage,
        'isFallback': isFallback,
      };

  factory MusicProfile.fromJson(Map<String, dynamic> json) => MusicProfile(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? 'Profile',
        providerId: json['providerId']?.toString() ?? '',
        settings: _stringMap(json['settings']),
        metadata: _stringMap(json['metadata']),
        availability: MusicProfileAvailability.values.firstWhere(
          (value) => value.name == json['availability']?.toString(),
          orElse: () => MusicProfileAvailability.available,
        ),
        errorMessage: json['errorMessage']?.toString(),
        isFallback: json['isFallback'] == true,
      );

  static Map<String, dynamic> _stringMap(dynamic value) => value is Map
      ? value.map((key, item) => MapEntry(key.toString(), item))
      : const {};
}
