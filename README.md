# 📄 Digital Signature App

Aplikasi mobile untuk membuat, mengimpor, dan mengedit dokumen PDF dengan dukungan tanda tangan digital. Dibuat menggunakan Flutter dengan pendekatan BLoC state management.

## ✨ Fitur Utama

### 🖋️ 1. Membuat Tanda Tangan Digital
- Pengguna dapat menggambar tanda tangan secara langsung pada canvas.
- Tanda tangan disimpan dalam format `Uint8List` (gambar).
- Tanda tangan dapat digunakan berulang kali untuk dokumen yang berbeda.

### 📥 2. Import Dokumen PDF
- Pengguna dapat mengimpor file PDF dari penyimpanan lokal.
- Menampilkan pratinjau isi PDF dalam aplikasi.

### 📝 3. Edit dan Tambah Tanda Tangan ke PDF
- Menempatkan tanda tangan pada halaman PDF dengan drag & drop.
- Mendukung pengubahan ukuran dan posisi tanda tangan.
- Simpan hasil PDF yang telah ditandatangani.

### 📤 4. Share Dokumen PDF
- Bagikan hasil dokumen melalui WhatsApp, email, atau aplikasi lainnya langsung dari aplikasi.
- Mendukung ekspor file hasil edit ke penyimpanan lokal.

---

## 🚀 Cara Penggunaan

1. **Buka aplikasi**
2. Pilih menu **"Buat Tanda Tangan"**
   - Gambar tanda tangan
   - Simpan untuk digunakan nanti
3. Kembali ke beranda, pilih **"Impor PDF"**
   - Pilih dokumen dari perangkatmu
4. Setelah terbuka, pilih posisi halaman
   - Tap area untuk menambahkan tanda tangan
   - Sesuaikan ukuran dan posisi
5. Tekan **"Simpan PDF"**
6. Gunakan fitur **"Bagikan"** untuk mengirim hasilnya ke orang lain

---

## 🛠️ Teknologi yang Digunakan

- **Flutter**: UI cross-platform
- **BLoC**: State management
- **Freezed**: Untuk immutable state
- **PDF package**: Manipulasi dokumen PDF
- **Path Provider & File Picker**: Akses file dari perangkat
- **Share Plus**: Berbagi file ke aplikasi lain

---

## 📷 Cuplikan Layar (Screenshots)

*(Comming soon!)*

---

## 🧪 Rencana Fitur Mendatang

- Penyimpanan Cloud (Google Drive / Dropbox)
- Proteksi PDF dengan password
- Multi-tanda tangan di dokumen berbeda

---

## 📄 Lisensi

Aplikasi ini menggunakan lisensi **MIT**. Silakan gunakan, ubah, dan distribusikan ulang sesuai kebutuhan.

---

## 🙋 Kontribusi

Pull request sangat terbuka! Silakan fork repository ini, buat branch baru, dan ajukan PR jika ingin menyumbang perbaikan atau fitur baru.

---

## 📬 Kontak

Jika ada pertanyaan atau masukan, silakan hubungi via [fartaqab@gmail.com] atau buat [Issue baru](https://github.com/phosnova/signature-mobile/issues/new).

