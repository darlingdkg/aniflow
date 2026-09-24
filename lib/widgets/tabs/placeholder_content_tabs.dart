import 'package:flutter/material.dart';

import '../../language.dart';
import '../../theme.dart';

class PlaceholderHomeTab extends StatelessWidget {
  const PlaceholderHomeTab({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    key: const ValueKey('placeholder-home-tab'),
    controller: scrollController,
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AniFlowSpacing.pageHorizontal,
            12,
            AniFlowSpacing.pageHorizontal,
            28,
          ),
          child: _HeroPlaceholder(
            title: context.l10n.placeholderContentTitle,
            caption: context.l10n.placeholderContentCaption,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: _LandscapePlaceholderSection(
          title: context.l10n.continueWatching,
        ),
      ),
      SliverToBoxAdapter(
        child: _LandscapePlaceholderSection(title: context.l10n.todaySchedule),
      ),
      SliverToBoxAdapter(
        child: _PosterPlaceholderSection(title: context.l10n.newest),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 120)),
    ],
  );
}

class PlaceholderSearchTab extends StatelessWidget {
  const PlaceholderSearchTab({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    key: const ValueKey('placeholder-search-tab'),
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AniFlowSpacing.pageHorizontal,
            18,
            AniFlowSpacing.pageHorizontal,
            16,
          ),
          child: Text(
            context.l10n.search,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AniFlowSpacing.pageHorizontal,
          ),
          child: IgnorePointer(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: context.l10n.searchAnime,
                prefixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AniFlowSpacing.pageHorizontal,
            18,
            AniFlowSpacing.pageHorizontal,
            12,
          ),
          child: _PlaceholderMessage(),
        ),
      ),
      const SliverPadding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 120),
        sliver: _PosterPlaceholderGrid(),
      ),
    ],
  );
}

class PlaceholderLibraryTab extends StatelessWidget {
  const PlaceholderLibraryTab({
    super.key,
    required this.showingWatchLater,
    required this.onShowFavorites,
    required this.onShowWatchLater,
  });

  final bool showingWatchLater;
  final VoidCallback onShowFavorites;
  final VoidCallback onShowWatchLater;

  @override
  Widget build(BuildContext context) => Column(
    key: const ValueKey('placeholder-library-tab'),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(
          AniFlowSpacing.pageHorizontal,
          18,
          AniFlowSpacing.pageHorizontal,
          14,
        ),
        child: Text(
          context.l10n.library,
          key: const ValueKey('library-title'),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AniFlowSpacing.pageHorizontal,
        ),
        child: Row(
          children: [
            _PlaceholderCollectionTab(
              selected: !showingWatchLater,
              label: context.l10n.favorites,
              onTap: onShowFavorites,
            ),
            const SizedBox(width: 28),
            _PlaceholderCollectionTab(
              selected: showingWatchLater,
              label: context.l10n.watchLater,
              onTap: onShowWatchLater,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
          AniFlowSpacing.pageHorizontal,
          18,
          AniFlowSpacing.pageHorizontal,
          12,
        ),
        child: _PlaceholderMessage(),
      ),
      const Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 100),
          child: _PosterPlaceholderGridBox(),
        ),
      ),
    ],
  );
}

class PlaceholderContentScreen extends StatelessWidget {
  const PlaceholderContentScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(
        AniFlowSpacing.pageHorizontal,
        24,
        AniFlowSpacing.pageHorizontal,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PlaceholderMessage(),
          const SizedBox(height: 20),
          Expanded(child: _PosterPlaceholderGridBox()),
        ],
      ),
    ),
  );
}

class _HeroPlaceholder extends StatelessWidget {
  const _HeroPlaceholder({required this.title, required this.caption});

  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      key: const ValueKey('placeholder-hero'),
      height: 250,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AniFlowRadii.landscapeCard),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surfaceContainerHighest,
            colors.surfaceContainer,
            colors.surface,
          ],
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(AniFlowRadii.pill),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              caption,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderMessage extends StatelessWidget {
  const _PlaceholderMessage();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(
        Icons.hourglass_empty_rounded,
        size: 18,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          context.l10n.placeholderContentCaption,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    ],
  );
}

class _LandscapePlaceholderSection extends StatelessWidget {
  const _LandscapePlaceholderSection({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AniFlowSpacing.sectionGap),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title),
        const SizedBox(height: 12),
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AniFlowSpacing.pageHorizontal,
            ),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, _) => const _LandscapeSkeleton(),
          ),
        ),
      ],
    ),
  );
}

class _PosterPlaceholderSection extends StatelessWidget {
  const _PosterPlaceholderSection({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AniFlowSpacing.sectionGap),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title),
        const SizedBox(height: 12),
        SizedBox(
          height: 205,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AniFlowSpacing.pageHorizontal,
            ),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, _) => const _PosterSkeleton(),
          ),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AniFlowSpacing.pageHorizontal,
    ),
    child: Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
  );
}

class _LandscapeSkeleton extends StatelessWidget {
  const _LandscapeSkeleton();

  @override
  Widget build(BuildContext context) => Container(
    width: 190,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(AniFlowRadii.landscapeCard),
    ),
  );
}

class _PosterSkeleton extends StatelessWidget {
  const _PosterSkeleton();

  @override
  Widget build(BuildContext context) => Container(
    width: 128,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(AniFlowRadii.posterCard),
    ),
  );
}

class _PosterPlaceholderGrid extends StatelessWidget {
  const _PosterPlaceholderGrid();

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: .67,
    ),
    itemCount: 9,
    itemBuilder: (_, _) => const _PosterSkeleton(),
  );
}

class _PosterPlaceholderGridBox extends StatelessWidget {
  const _PosterPlaceholderGridBox();

  @override
  Widget build(BuildContext context) => GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: .67,
    ),
    itemCount: 9,
    itemBuilder: (_, _) => const _PosterSkeleton(),
  );
}

class _PlaceholderCollectionTab extends StatelessWidget {
  const _PlaceholderCollectionTab({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: selected ? colors.primary : colors.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: selected ? 32 : 0,
              height: 2,
              decoration: BoxDecoration(
                color: selected ? colors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(AniFlowRadii.pill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
