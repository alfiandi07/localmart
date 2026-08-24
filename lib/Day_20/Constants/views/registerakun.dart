import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';
import 'package:localmart/Day_20/Constants/views/login.dart';

class RegisterAkun extends StatefulWidget {
  const RegisterAkun({super.key});

  @override
  State<RegisterAkun> createState() => _RegisterAkunState();
}

class _RegisterAkunState extends State<RegisterAkun> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObscurePass = true;
  bool _isObscureConfirm = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPass = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      _showSnackBar('Harap isi semua kolom formulir!', isError: true);
      return;
    }

    if (password != confirmPass) {
      _showSnackBar('Konfirmasi kata sandi tidak cocok!', isError: true);
      return;
    }

    if (!_agreeTerms) {
      _showSnackBar(
        'Anda harus menyetujui Syarat dan Ketentuan!',
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 600));

      bool success = await UserDbHelper.registerUser(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('Pendaftaran berhasil! Silakan masuk ke akun Anda.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        _showSnackBar(
          'Email sudah terdaftar. Gunakan email lain!',
          isError: true,
        );
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Terjadi kesalahan: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF0025A5),
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
          'LocalMart',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor.withValues(alpha: 0.08)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F002892),
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buat Akun Baru',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1B24),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bergabunglah dengan pasar produk UMKM lokal kami.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),

                  // Nama Lengkap
                  _buildLabel('NAMA LENGKAP'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _nameController,
                    hint: 'Masukkan nama lengkap Anda',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildLabel('EMAIL'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'nama@email.com',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Nomor Telepon
                  _buildLabel('NOMOR TELEPON'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _phoneController,
                    hint: '0812xxxxxx',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Kata Sandi
                  _buildLabel('KATA SANDI'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _passwordController,
                    hint: '••••••••',
                    icon: Icons.lock_outline,
                    obscureText: _isObscurePass,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscurePass
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscurePass = !_isObscurePass;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Konfirmasi Kata Sandi
                  _buildLabel('KONFIRMASI KATA SANDI'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _confirmPasswordController,
                    hint: 'Ulangi kata sandi',
                    icon: Icons.lock_outline,
                    obscureText: _isObscureConfirm,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscureConfirm = !_isObscureConfirm;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Checkbox Syarat dan Ketentuan
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreeTerms,
                          activeColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _agreeTerms = !_agreeTerms;
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Saya setuju dengan ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'Syarat & Ketentuan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'DAFTAR AKUN',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Link Sudah punya akun
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    const Color primaryColor = Color(0xFF0025A5);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey.shade600, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF8F9FE),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
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
