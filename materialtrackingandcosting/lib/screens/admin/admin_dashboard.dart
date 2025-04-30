import 'package:flutter/material.dart';
import '../auth_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Controls',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Materials Management'),
              onTap: () {
                // Navigate to materials management
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Processes Management'),
              onTap: () {
                // Navigate to processes management
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('User Management'),
              onTap: () {
                // Navigate to user management
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Analytics Dashboard'),
              onTap: () {
                // Navigate to analytics dashboard
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.summarize),
              title: const Text('Reports'),
              onTap: () {
                // Navigate to reports
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'As an admin, you can:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildFeatureCard(
              context,
              'Manage Materials',
              'Add, edit, or delete materials from the inventory',
              Icons.inventory,
              Colors.blue,
            ),
            _buildFeatureCard(
              context,
              'Manage Processes',
              'Configure manufacturing processes and workflows',
              Icons.settings,
              Colors.green,
            ),
            _buildFeatureCard(
              context,
              'Manage Users',
              'Add or remove users, assign roles',
              Icons.people,
              Colors.orange,
            ),
            _buildFeatureCard(
              context,
              'View Analytics',
              'Access comprehensive reports and analytics',
              Icons.bar_chart,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, 
    String title, 
    String description, 
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          // Navigate to the specific feature
        },
      ),
    );
  }
}
