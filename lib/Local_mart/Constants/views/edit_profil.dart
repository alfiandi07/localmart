import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localmart/Local_mart/Constants/database/db_helper_user.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  File? _imageFile;
  bool _isPhotoRemoved = false;

  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _alamatController;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = UserDbHelper.currentUser;
    _namaController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _alamatController = TextEditingController(text: user?.address ?? '');

    if (user?.photoPath != null && user!.photoPath!.isNotEmpty) {
      File savedFile = File(user.photoPath!);
      if (savedFile.existsSync()) {
        _imageFile = savedFile;
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengambil foto dari Galeri atau Kamera
  Future<void> _ambilGambar(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _isPhotoRemoved = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Modal Bottom Sheet Pilihan Sumber Foto
  void _pilihSumberFoto() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showModalBottomSheet(
      context: context,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ubah Foto Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: primaryColor,
                    ),
                  ),
                  title: Text(
                    'Pilih dari Galeri',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Ambil foto dari album perangkat',
                    style: TextStyle(color: subtextColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _ambilGambar(ImageSource.gallery);
                  },
                ),
                Divider(height: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: primaryColor,
                    ),
                  ),
                  title: Text(
                    'Ambil Foto dari Kamera',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Gunakan kamera perangkat langsung',
                    style: TextStyle(color: subtextColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _ambilGambar(ImageSource.camera);
                  },
                ),
                if (_imageFile != null) ...[
                  Divider(height: 1, color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF3D1F1F) : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    title: const Text(
                      'Hapus Foto Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _imageFile = null;
                        _isPhotoRemoved = true;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _simpanPerubahan() async {
    String name = _namaController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String address = _alamatController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi kolom Nama, Email, dan No Telepon!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await UserDbHelper.updateCurrentUser(
      name: name,
      email: email,
      phone: phone,
      address: address,
      photoPath: _imageFile?.path,
      isClearPhoto: _isPhotoRemoved,
    );

    if (!mounted) return;

    const Color primaryColor = Color(0xFF0025A5);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Profil berhasil diperbarui!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFCF9F8);
    final Color appBarBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: appBarBg,
        foregroundColor: primaryColor,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Foto Profil + Tombol Kamera Interaktif
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pilihSumberFoto,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
                            border: Border.all(color: primaryColor, width: 2.5),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.15),
                                blurRadius: 15,
                                offset: const Offset(1, 6),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 75,
                                    color: primaryColor,
                                  ),
                          ),
                        ),

                        // Badge Icon Kamera di Pojok Kanan Bawah
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF354184) : const Color.fromARGB(255, 148, 162, 212),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 6),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _pilihSumberFoto,
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: primaryColor,
                    ),
                    label: Text(
                      'Ubah Foto Profil',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Formulir Input Data
            _buildLabel('NAMA LENGKAP', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _namaController,
              hint: 'Masukkan nama lengkap',
              icon: Icons.person_outline,
              isDark: isDark,
              primaryColor: primaryColor,
            ),

            const SizedBox(height: 20),

            _buildLabel('EMAIL', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'nama@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              isDark: isDark,
              primaryColor: primaryColor,
            ),

            const SizedBox(height: 20),

            _buildLabel('NOMOR TELEPON', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _phoneController,
              hint: '+62 8xx-xxxx-xxxx',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              isDark: isDark,
              primaryColor: primaryColor,
            ),

            const SizedBox(height: 20),

            _buildLabel('ALAMAT UTAMA', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _alamatController,
              hint: 'Masukkan alamat lengkap',
              icon: Icons.location_on_outlined,
              maxLines: 3,
              isDark: isDark,
              primaryColor: primaryColor,
            ),

            const SizedBox(height: 36),

            // Tombol Simpan Perubahan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _simpanPerubahan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isDark,
    required Color primaryColor,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
        ),
        prefixIcon: Icon(
          icon,
          color: isDark ? primaryColor : Colors.grey.shade600,
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
