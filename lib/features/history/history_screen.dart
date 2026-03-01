import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/extensions.dart';
import '../../services/history_service.dart';
import '../../widgets/glass_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _historyService = HistoryService();
  String _selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Calculation History'),
        elevation: 0,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: ['All', 'BMI', 'Currency', 'Metals'].map((type) {
                  final isSelected = _selectedType == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            type,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    final allHistory = _historyService.history;
    final filteredHistory = _selectedType == 'All'
        ? allHistory
        : allHistory.where((item) => item.type == _selectedType).toList();

    if (filteredHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No history yet',
              style: AppTextStyles.heading4.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your calculations will appear here',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        final item = filteredHistory[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            _historyService.removeCalculation(item.id);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deleted')),
            );
          },
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: AppColors.error),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              child: Row(
                children: [
                  _TypeIcon(type: item.type),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: AppTextStyles.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          item.timestamp.formattedDateTime,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item.value, style: AppTextStyles.heading4),
                      if (item.details != null)
                        Text(
                          item.details!,
                          style: AppTextStyles.caption,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to delete all history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _historyService.clearHistory();
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _TypeIcon extends StatelessWidget {
  final String type;

  const _TypeIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    final iconData = switch (type) {
      'BMI' => Icons.fitness_center,
      'Currency' => Icons.currency_exchange,
      'Metals' => Icons.diamond,
      _ => Icons.calculate,
    };

    final colors = switch (type) {
      'BMI' => const Color(0xFF3B82F6),
      'Currency' => const Color(0xFF8B5CF6),
      'Metals' => const Color(0xFFFCD34D),
      _ => AppColors.primary,
    };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: colors, size: 20),
    );
  }
}
