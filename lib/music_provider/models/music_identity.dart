import 'package:flutter/foundation.dart';

@immutable
class MusicIdentity {
  const MusicIdentity({
    required this.providerId,
    required this.profileId,
    required this.sourceId,
  });

  final String providerId;
  final String profileId;
  final String sourceId;

  String get namespacedId => '${Uri.encodeComponent(providerId)}/'
      '${Uri.encodeComponent(profileId)}/${Uri.encodeComponent(sourceId)}';

  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'profileId': profileId,
        'sourceId': sourceId,
      };

  factory MusicIdentity.fromJson(Map<String, dynamic> json) => MusicIdentity(
        providerId: json['providerId']?.toString() ?? '',
        profileId: json['profileId']?.toString() ?? '',
        sourceId: json['sourceId']?.toString() ?? '',
      );

  @override
  bool operator ==(Object other) =>
      other is MusicIdentity &&
      other.providerId == providerId &&
      other.profileId == profileId &&
      other.sourceId == sourceId;

  @override
  int get hashCode => Object.hash(providerId, profileId, sourceId);
}
