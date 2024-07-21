//
//  AppInfoData.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import Foundation

struct AppInfoData {
    // For Home Screen
    static let myKidneyWelcome: String = """
    Kami senang menyambut Anda di aplikasi kami yang dirancang khusus untuk membantu Anda memahami dan mendeteksi potensi masalah kesehatan pada ginjal, mendapatkan analisa disertai saran dan solusi. Anda juga dapat berkonsultasi dengan dokter spesialis yang bersertifikasi untuk masalah lebih lanjut.
    """
    
    static let aboutMyKidney: String = """
    Selamat datang di \"My Kidney\" sebuah aplikasi kesehatan revolusioner yang dirancang khusus untuk membantu Anda menjaga kesehatan ginjal Anda. Aplikasi ini dikembangkan dengan tujuan utama memberikan diagnosa awal yang cepat dan akurat serta menyediakan akses mudah ke konsultasi profesional dengan dokter ahli ginjal.
    """
    
    static let madeFor: [(String, String)] = [
        ("Pasien", "Pantau dan jaga kesehatan ginjal Anda dengan solusi deteksi awal dan akses mudah ke dokter"),
        ("Dokter", "Jangkau lebih banyak pasien dan berikan konsultasi secara efisien dengan dukungan teknologi AI dan fitur manajemen yang lengkap")
    ]
    
    static let whyChooseUs: [(String, String)] = [
        ("Akurasi dan Kecepatan", "Teknologi AI kami memastikan diagnosa awal yang cepat dan akurat, membantu Anda mengambil tindakan yang tepat sejak dini"),
        ("Akses Mudah ke Profesional Kesehatan", "Semua dokter spesialis ginjal ada di \"My Kidney\", siap membantu Anda kapan saja"),
        ("Informasi Kesehatan yang Komprehensif", "Dapatkan berbagai tips kesehatan, panduan diet, dan informasi penting lainnya untuk menjaga kesehatan ginjal Anda")
    ]
    
    static let features: [(String, [(String, String)])] = [
        ("Beranda", [
            ("Panduan Pengguna", "Pengenalan dan panduan singkat mengenai aplikasi \"My Kidney\""),
            ("Tips Kesehatan", "Menyajikan tips harian untuk menjaga kesehatan ginjal dan juga pengenalan macam-macam penyakit yang bisa terjadi pada ginjal untuk tindakan pencegahan sejak dini"),
            ("Event dan Webinar", "Informasi tentang acara, webinar, atau seminar terkait kesehatan ginjal"),
            ("Berita dan Artikel", "Artikel terbaru terkait kesehatan ginjal dan penelitian medis")
        ]),
        ("Diagnosis Awal", [
            ("Kuesioner Gejala", "Mengumpulkan informasi gejala yang dialami pengguna melalui serangkaian pertanyaan"),
            ("Analisis AI", "Menggunakan metode AI untuk menganalisis gejala dan memberikan diagnosis awal"),
            ("Saran Tindakan Lanjut", "Rekomendasi untuk langkah selanjutnya berdasarkan hasil diagnosis AI, seperti perubahan gaya hidup atau saran untuk konsultasi lebih lanjut")
        ]),
        ("Konsultasi dengan Dokter", [
            ("Daftar Dokter", "Menampilkan daftar dokter yang tersedia untuk konsultasi"),
            ("Profil Dokter", "Informasi lengkap tentang dokter, termasuk spesialisasi, pengalaman, dan jadwal"),
            ("Jadwal Konsultasi", "Fitur untuk membuat janji temu dengan dokter secara online"),
            ("Live Chat", "Fitur chat langsung antara pasien dan dokter untuk konsultasi cepat"),
            ("Riwayat Konsultasi", "Penyimpanan riwayat konsultasi yang dapat diakses kapan saja oleh pengguna"),
        ]),
        ("Live Chat", [
            ("Chat Real-time", "Fitur untuk komunikasi langsung dengan dokter atau tenaga medis"),
            ("Notifikasi Pesan Baru", "Pemberitahuan instan untuk setiap pesan baru yang diterima"),
            ("Penyimpanan Chat", "Riwayat chat tersimpan untuk referensi di masa mendatang")
        ]),
        ("Riwayat Kesehatan", [
            ("Riwayat Diagnosa", "Menyimpan semua hasil diagnosa yang telah dilakukan, baik oleh sistem maupun oleh dokter"),
            ("Catatan Medis", "Penyimpanan catatan medis dan resep yang diberikan oleh dokter")
        ]),
        ("Pengaturan", [
            ("Profil Pengguna", "Mengelola informasi profil pengguna, termasuk data pribadi dan preferensi"),
            ("Keamanan Akun", "Opsi untuk mengubah kata sandi dan pengaturan keamanan lainnya"),
            ("Notifikasi", "Mengatur preferensi notifikasi untuk berbagai aktivitas dalam aplikasi")
        ]),
        ("Admin Panel", [
            ("Manajemen Pengguna", "Mengelola data pengguna, termasuk pasien dan dokter"),
            ("Konten Edukasi", "Menambahkan dan mengedit konten edukasi seperti artikel, tips kesehatan, dan acara"),
            ("Monitoring Aktivitas", "Memantau aktivitas dalam aplikasi untuk mendeteksi perilaku spam atau aktivitas mencurigakan")
        ]),
        ("Fitur Tambahan", [
            ("Integrasi Data Kesehatan", "Integrasi dengan perangkat kesehatan atau aplikasi kesehatan lainnya untuk sinkronisasi data"),
            ("Peringatan Kesehatan", "Notifikasi otomatis jika data menunjukkan adanya risiko atau masalah kesehatan"),
            ("Fitur Komunitas", "Forum diskusi atau grup komunitas untuk pengguna berbagi pengalaman dan tips")
        ]),
    ]
    
    static let guideToGetDiagnosis: [String] = [
        "Buka aplikasi \"My Kidney\" dan masuk dengan akun Anda",
        "Dari beranda, pilih menu \"Diagnosa\"",
        "Klik \"Kuesioner Gejala\"",
        "Jawab semua pertanyaan mengenai gejala yang Anda alami",
        "Setelah mengisi kuesioner, klik tombol \"Analisis\"",
        "Tunggu beberapa saat hingga AI menyelesaikan analisis",
        "Hasil diagnosis awal akan ditampilkan, mencakup kemungkinan penyakit ginjal yang Anda alami",
        "Baca rekomendasi yang diberikan untuk langkah selanjutnya, seperti perubahan gaya hidup atau saran konsultasi",
        "Jika diperlukan, navigasi ke menu \"Konsultasi\"",
        "Pilih dokter dari daftar dan buat jadwal konsultasi atau gunakan fitur \"Live Chat\"",
        "Hasil diagnosa akan otomatis tersimpan di menu \"Riwayat Kesehatan\" untuk referensi di masa mendatang"
    ]
    
    static let problemTips: [String] = [
        "Konsultasi dengan Dokter Spesialis",
        "Lakukan Tes Laboratorium Tambahan",
        "Rencana Diet yang Tepat",
        "Kontrol Kondisi Penyerta",
        "Hindari Obat Nefrotoksik",
        "Tetap Terhidrasi dengan Baik",
        "Pantau dan Kendalikan Tekanan Darah",
        "Latihan Fisik yang Sesuai",
        "Kurangi Konsumsi Alkohol dan Berhenti Merokok",
        "Ikuti Rekomendasi Dokter",
        "Bergabung dengan Kelompok Dukungan",
        "Pantau Gejala dan Kondisi",
        "Siapkan Diri untuk Perawatan Jangka Panjang",
        "Pelajari tentang Penyakit Ginjal"
    ]
}
