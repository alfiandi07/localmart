import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';

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
    const Color primaryColor = Color(0xFF0025A5);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
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
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ubah Foto Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1B24),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.photo_library_outlined,
                      color: primaryColor,
                    ),
                  ),
                  title: const Text(
                    'Pilih dari Galeri',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Ambil foto dari album perangkat'),
                  onTap: () {
                    Navigator.pop(context);
                    _ambilGambar(ImageSource.gallery);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: primaryColor,
                    ),
                  ),
                  title: const Text(
                    'Ambil Foto dari Kamera',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Gunakan kamera perangkat langsung'),
                  onTap: () {
                    Navigator.pop(context);
                    _ambilGambar(ImageSource.camera);
                  },
                ),
                if (_imageFile != null) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil diperbarui!'),
        backgroundColor: Color(0xFF0025A5),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0025A5);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),
      appBar: AppBar(
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                            color: const Color(0xFFF4F2FF),
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
                                : const Icon(
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
                              color: const Color.fromARGB(255, 148, 162, 212),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
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
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: primaryColor,
                    ),
                    label: const Text(
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
            _buildLabel('NAMA LENGKAP'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _namaController,
              hint: 'Masukkan nama lengkap',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 20),

            _buildLabel('EMAIL'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              hint: 'nama@email.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            _buildLabel('NOMOR TELEPON'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _phoneController,
              hint: '+62 8xx-xxxx-xxxx',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            _buildLabel('ALAMAT UTAMA'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _alamatController,
              hint: 'Masukkan alamat lengkap',
              icon: Icons.location_on_outlined,
              maxLines: 3,
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    const Color primaryColor = Color(0xFF0025A5);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(icon, color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
