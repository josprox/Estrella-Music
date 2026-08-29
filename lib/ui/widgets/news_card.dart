import 'package:flutter/material.dart';
import 'package:estrella_music/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A00E0).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showNewsDetailsDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.campaign_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).news_card_title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        S.of(context).news_card_subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNewsDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F1B26),
        title: Row(
          children: [
            const Icon(Icons.campaign_rounded, color: Color(0xFFFF9F1C)),
            const SizedBox(width: 10),
            Text(S.of(context).news_dialog_title,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNewsItem(
                context,
                Icons.cloud_done_rounded,
                S.of(context).news_item_sync_title,
                S.of(context).news_item_sync_desc,
              ),
              const SizedBox(height: 12),
              _buildNewsItem(
                context,
                Icons.people_alt_rounded,
                S.of(context).news_item_collab_title,
                S.of(context).news_item_collab_desc,
              ),
              const SizedBox(height: 12),
              _buildNewsItem(
                context,
                Icons.sync_rounded,
                S.of(context).news_item_trans_title,
                S.of(context).news_item_trans_desc,
              ),
              const Divider(color: Colors.white24, height: 24),
              Text(
                S.of(context).news_dialog_section_friends,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              const SizedBox(height: 8),
              Text(
                S.of(context).news_dialog_friends_desc,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 12.5, height: 1.4),
              ),
              const SizedBox(height: 14),
              _buildLinkButton(
                S.of(context).news_btn_app,
                "https://play.google.com/store/apps/details?id=com.josprox.jossestrada",
              ),
              const SizedBox(height: 8),
              _buildLinkButton(
                S.of(context).news_btn_web,
                "https://app.joss.red/",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).news_btn_dismiss,
                style: const TextStyle(
                    color: Color(0xFFFF9F1C), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(
      BuildContext context, IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF2EC4B6), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 12.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkButton(String label, String url) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.open_in_new_rounded, size: 16),
        label: Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E2E3C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
