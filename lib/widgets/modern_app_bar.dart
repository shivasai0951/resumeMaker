import 'package:flutter/material.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModernAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 64,
      backgroundColor: colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: showBack
          ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
                tooltip: 'Back',
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
      actions: actions,
    );
  }
}
