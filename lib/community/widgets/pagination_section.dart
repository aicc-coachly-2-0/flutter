import 'package:flutter/material.dart';

class PaginationSection extends StatelessWidget {
  final int currentPage;
  final int totalPosts;
  final int postsPerPage;
  final Function(int) onPageChanged;

  const PaginationSection({
    super.key,
    required this.currentPage,
    required this.totalPosts,
    required this.postsPerPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed:
              currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.arrow_back),
        ),
        Text('Page $currentPage'),
        IconButton(
          onPressed: currentPage * postsPerPage < totalPosts
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
