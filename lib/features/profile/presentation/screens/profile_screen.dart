import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: userProfile.when(
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profile?.profileImageUrl != null
                            ? NetworkImage(profile!.profileImageUrl!)
                            : null,
                        child: profile?.profileImageUrl == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile?.name ?? currentUser?.displayName ?? 'User',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        profile?.email ?? currentUser?.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            context,
                            'Recipes Cooked',
                            '${profile?.totalRecipesCooked ?? 0}',
                          ),
                          _buildStatItem(
                            context,
                            'Favorites',
                            '${profile?.favoriteRecipesCount ?? 0}',
                          ),
                          _buildStatItem(
                            context,
                            'Skill Level',
                            profile?.skillLevel.displayName ?? 'Beginner',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Menu Items
              _buildMenuItem(
                context,
                Icons.book_outlined,
                'My Recipes',
                'View your saved recipes',
                () {
                  // TODO: Navigate to my recipes
                },
              ),
              _buildMenuItem(
                context,
                Icons.favorite_outline,
                'Favorites',
                'Your favorite recipes',
                () {
                  // TODO: Navigate to favorites
                },
              ),
              _buildMenuItem(
                context,
                Icons.analytics_outlined,
                'Cooking Analytics',
                'View your cooking statistics',
                () {
                  // TODO: Navigate to analytics
                },
              ),
              _buildMenuItem(
                context,
                Icons.group_outlined,
                'Community',
                'Connect with other cooks',
                () {
                  // TODO: Navigate to community
                },
              ),
              _buildMenuItem(
                context,
                Icons.school_outlined,
                'Cooking School',
                'Learn new techniques',
                () {
                  // TODO: Navigate to cooking school
                },
              ),
              _buildMenuItem(
                context,
                Icons.kitchen_outlined,
                'Kitchen Tools',
                'Timers, converters, and more',
                () {
                  // TODO: Navigate to kitchen tools
                },
              ),
              
              const SizedBox(height: 20),
              
              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showSignOutDialog(context, ref);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading profile: $error'),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authControllerProvider.notifier).signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}