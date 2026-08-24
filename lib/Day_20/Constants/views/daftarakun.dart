import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';
import 'package:localmart/Day_20/Constants/models/user_model.dart';
import 'package:localmart/Day_20/Constants/views/registerakun.dart';

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final list = await UserDbHelper.getUsers();
    if (!mounted) return;
    setState(() {
      users = list;
    });
  }

  void _deleteUser(String id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: Text('Apakah Anda yakin ingin menghapus akun "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              await UserDbHelper.deleteUser(id);
              _loadUsers();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Akun "$name" berhasil dihapus.')),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0025A5);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),
      appBar: AppBar(
        title: const Text(
          'Daftar Akun Terdaftar',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        elevation: 0.5,
      ),
      body: users.isEmpty
          ? const Center(
              child: Text(
                'Belum ada akun yang terdaftar.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Avatar Circle
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withValues(alpha: 0.1),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Info User
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A1B24),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEE0FF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      user.role,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.phone,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () => _deleteUser(user.id, user.name),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterAkun()),
          );
          _loadUsers();
        },
        backgroundColor: primaryColor,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('Tambah Akun', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
