import SwiftUI

enum MockData {
    static let budi = User(name: "Budi Santoso", email: "budi@edutara.id", password: "Budi@2024!", educationLevel: "SMA", grade: "11", favoriteSubject: .matematika, joinedAt: Date(timeIntervalSinceNow: -86400*120))
    static let siti = User(name: "Siti Aisyah", email: "siti@edutara.id", password: "Siti#Pass9", educationLevel: "SMP", grade: "8", favoriteSubject: .english, joinedAt: Date(timeIntervalSinceNow: -86400*90))
    static let andi = User(name: "Andi Pratama Putra", email: "andi@edutara.id", password: "Andi$1234x", educationLevel: "SD", grade: "5", favoriteSubject: .matematika, joinedAt: Date(timeIntervalSinceNow: -86400*60))
    static let dewi = User(name: "Dewi Lestari", email: "dewi@edutara.id", password: "Dewi!2025a", educationLevel: "SMA", grade: "12", favoriteSubject: .kimia, joinedAt: Date(timeIntervalSinceNow: -86400*200))
    static let rizky = User(name: "Rizky Ramadhan", email: "rizky@edutara.id", password: "Rizky&8899", educationLevel: "SMP", grade: "9", favoriteSubject: .kimia, joinedAt: Date(timeIntervalSinceNow: -86400*45))
    static let nadia = User(name: "Nadia Putri", email: "nadia@edutara.id", password: "Nadia*Pass7", educationLevel: "SMA", grade: "13", favoriteSubject: .english, joinedAt: Date(timeIntervalSinceNow: -86400*150))
    static let users: [User] = [budi, siti, andi, dewi, rizky, nadia]

    static let statsDewi = Stats(userID: dewi.id, xp: 4820, streakDays: 21, quizzesCompleted: 34, averageScore: 91.5)
    static let statsBudi = Stats(userID: budi.id, xp: 4310, streakDays: 14, quizzesCompleted: 29, averageScore: 86.0)
    static let statsNadia = Stats(userID: nadia.id, xp: 3975, streakDays: 9, quizzesCompleted: 26, averageScore: 88.2)
    static let statsSiti = Stats(userID: siti.id, xp: 3120, streakDays: 6, quizzesCompleted: 19, averageScore: 79.4)
    static let statsRizky = Stats(userID: rizky.id, xp: 2540, streakDays: 3, quizzesCompleted: 15, averageScore: 74.8)
    static let statsAndi = Stats(userID: andi.id, xp: 1890, streakDays: 5, quizzesCompleted: 11, averageScore: 82.0)
    static let stats: [Stats] = [statsDewi, statsBudi, statsNadia, statsSiti, statsRizky, statsAndi]

    static let pecahanDasar = Material(title: "Pecahan Dasar", subject: .matematika, educationLevel: "SD", grade: "4", difficulty: .beginner, estimatedMinutes: 10, summary: "Mengenal pecahan, pembilang dan penyebut dengan visual yang menyenangkan.", content: "Pecahan adalah bagian dari keseluruhan. Pembilang menunjukkan berapa bagian yang diambil, sedangkan penyebut menunjukkan total bagian.\n\nContoh: 1/2 artinya satu dari dua bagian yang sama besar. Kita bisa membayangkan sebuah pizza yang dipotong menjadi 4 bagian; jika kita makan 1 potong, maka kita makan 1/4 pizza.\n\nUntuk membandingkan pecahan, samakan penyebutnya terlebih dahulu. Pecahan 1/2 lebih besar dari 1/4 karena 2/4 > 1/4.\n\nLatihan: ubah 3/4 menjadi persentase dengan mengalikan 100, hasilnya 75%. Pecahan senilai diperoleh dengan mengalikan pembilang dan penyebut dengan bilangan yang sama.", publishedAt: Date(timeIntervalSinceNow: -86400*30), isPremium: false)
    static let perkalianPembagian = Material(title: "Perkalian & Pembagian", subject: .matematika, educationLevel: "SD", grade: "3", difficulty: .beginner, estimatedMinutes: 12, summary: "Operasi perkalian dan pembagian bilangan cacah dengan contoh sehari-hari.", content: "Perkalian adalah penjumlahan berulang. 3 x 4 berarti 4 + 4 + 4 = 12.\n\nPembagian adalah kebalikan dari perkalian. 12 : 3 = 4 karena 4 x 3 = 12. Bayangkan 12 permen dibagi rata untuk 3 anak, masing-masing mendapat 4 permen.\n\nSifat komutatif berlaku pada perkalian: 2 x 5 = 5 x 2. Namun tidak pada pembagian.\n\nHafalkan tabel perkalian 1-10 untuk mempercepat hitungan. Gunakan jari atau gambar untuk membantu visualisasi.", publishedAt: Date(timeIntervalSinceNow: -86400*25), isPremium: false)
    static let aljabarSatuVariabel = Material(title: "Aljabar Satu Variabel", subject: .matematika, educationLevel: "SMP", grade: "7", difficulty: .intermediate, estimatedMinutes: 15, summary: "Persamaan linear satu variabel dan cara menyelesaikannya langkah demi langkah.", content: "Variabel adalah simbol (biasanya x) yang mewakili bilangan yang belum diketahui. Persamaan linear satu variabel berbentuk ax + b = c.\n\nContoh: 2x + 3 = 11. Kurangi kedua sisi dengan 3, diperoleh 2x = 8, lalu bagi 2, x = 4.\n\nPeriksa jawaban dengan substitusi: 2(4)+3 = 11 benar.\n\nAljabar membantu menyelesaikan masalah sehari-hari seperti menghitung harga barang jika diketahui total dan diskon.", publishedAt: Date(timeIntervalSinceNow: -86400*22), isPremium: false)
    static let turunanFungsi = Material(title: "Turunan Fungsi", subject: .matematika, educationLevel: "SMA", grade: "11", difficulty: .advanced, estimatedMinutes: 25, summary: "Konsep turunan, aturan rantai, dan aplikasi untuk kemiringan garis singgung.", content: "Turunan mengukur laju perubahan fungsi. Definisi formal: f'(x) = lim h->0 (f(x+h)-f(x))/h.\n\nAturan pangkat: jika f(x)=x^n maka f'(x)=n x^(n-1). Contoh: turunan x^3 adalah 3x^2.\n\nAturan rantai untuk fungsi komposisi: (f o g)' = f'(g) * g'. Misal y=(2x+1)^3 maka y'=3(2x+1)^2 *2.\n\nAplikasi: turunan digunakan untuk mencari gradien garis singgung, kecepatan sesaat, dan optimasi (nilai maksimum/minimum).", publishedAt: Date(timeIntervalSinceNow: -86400*18), isPremium: true)
    static let integralTentu = Material(title: "Integral Tentu", subject: .matematika, educationLevel: "SMA", grade: "12", difficulty: .advanced, estimatedMinutes: 30, summary: "Integral tentu, teorema dasar kalkulus, dan perhitungan luas daerah.", content: "Integral tentu adalah limit jumlah Riemann yang menghitung luas di bawah kurva. Notasi: [integral][a,b] f(x) dx.\n\nTeorema Dasar Kalkulus: jika F antiturunan f, maka [integral][a,b] f(x) dx = F(b)-F(a). Contoh: [integral][0,2] 2x dx = x^2 |0..2 =4.\n\nSifat linearitas memungkinkan penjumlahan integral. Luas antara dua kurva dihitung dengan mengintegralkan selisih fungsi.\n\nTeknik substitusi dan parsial sering diperlukan. Latihan rutin membantu menguasai pola.", publishedAt: Date(timeIntervalSinceNow: -86400*15), isPremium: true)
    static let statistikaDasar = Material(title: "Statistika Dasar", subject: .matematika, educationLevel: "SMP", grade: "8", difficulty: .intermediate, estimatedMinutes: 18, summary: "Mean, median, modus, dan interpretasi data dengan diagram.", content: "Statistika mempelajari pengumpulan dan analisis data. Mean adalah rata-rata: jumlah data dibagi banyak data.\n\nMedian adalah nilai tengah setelah diurutkan. Modus adalah nilai yang paling sering muncul.\n\nContoh data: 5,7,7,8,9. Mean=7.2, median=7, modus=7.\n\nDiagram batang dan lingkaran membantu visualisasi. Pahami kapan menggunakan masing-masing ukuran pemusatan.", publishedAt: Date(timeIntervalSinceNow: -86400*20), isPremium: false)
    static let simplePresentTense = Material(title: "Simple Present Tense", subject: .english, educationLevel: "SD", grade: "6", difficulty: .beginner, estimatedMinutes: 10, summary: "Pola kalimat simple present untuk kebiasaan dan fakta umum.", content: "Simple present digunakan untuk kebiasaan, fakta, dan jadwal. Pola: S + V1 (s/es) + O.\n\nContoh: She drinks coffee every morning. They play football on Sunday.\n\nTambahkan s/es untuk subjek he/she/it: he goes, she watches.\n\nKalimat negatif: do/does + not. Tanya: Do/Does + S + V1? Latihan membuat 10 kalimat tentang rutinitas harian.", publishedAt: Date(timeIntervalSinceNow: -86400*28), isPremium: false)
    static let readingComprehension = Material(title: "Reading Comprehension", subject: .english, educationLevel: "SMP", grade: "8", difficulty: .intermediate, estimatedMinutes: 18, summary: "Strategi membaca efektif: skimming, scanning, dan inference.", content: "Skimming membaca cepat untuk gagasan utama. Scanning mencari informasi spesifik seperti angka atau nama.\n\nInference menyimpulkan makna tersirat. Perhatikan kata kunci dan konteks kalimat.\n\nLangkah: baca judul, prediksi isi, garis bawahi kata kunci, jawab pertanyaan tanpa membaca ulang seluruh teks.\n\nLatihan dengan teks 250 kata tentang lingkungan, lalu jawab 5 pertanyaan pemahaman.", publishedAt: Date(timeIntervalSinceNow: -86400*24), isPremium: false)
    static let conditionalSentences = Material(title: "Conditional Sentences", subject: .english, educationLevel: "SMA", grade: "12", difficulty: .intermediate, estimatedMinutes: 20, summary: "Type 0,1,2,3 conditional dan penggunaannya dalam konteks nyata.", content: "Conditional type 0 untuk fakta umum: If you heat ice, it melts.\n\nType 1 untuk kemungkinan masa depan: If it rains, we will stay home.\n\nType 2 untuk khayalan: If I were you, I would study harder.\n\nType 3 untuk penyesalan masa lalu: If you had studied, you would have passed. Perhatikan perbedaan tenses di tiap klausa.", publishedAt: Date(timeIntervalSinceNow: -86400*16), isPremium: false)
    static let essayWriting = Material(title: "Essay Writing", subject: .english, educationLevel: "SMA", grade: "13", difficulty: .advanced, estimatedMinutes: 30, summary: "Struktur essay akademik: introduction, body, conclusion dengan cohesion.", content: "Essay terdiri dari hook, thesis statement, topic sentence, supporting details, dan conclusion.\n\nGunakan cohesive devices: furthermore, however, therefore. Hindari kalimat terlalu panjang dan plagiarisme.\n\nOutline sebelum menulis: buat 3 poin utama, kembangkan masing-masing 1 paragraf.\n\nRevisi dengan memeriksa grammar, coherence, dan word count. Latihan menulis 250 kata tentang teknologi.", publishedAt: Date(timeIntervalSinceNow: -86400*12), isPremium: true)
    static let vocabularyBuilder = Material(title: "Vocabulary Builder", subject: .english, educationLevel: "SMP", grade: "7", difficulty: .beginner, estimatedMinutes: 14, summary: "Teknik mengingat kosakata dengan mnemonik dan word families.", content: "Kelompokkan kata berdasarkan topik: animals, food, school. Gunakan flashcard dan spaced repetition.\n\nWord families: happy, happiness, happily, unhappy. Pelajari prefix dan suffix.\n\nBuat kalimat sendiri untuk tiap kata baru agar lebih melekat.\n\nTarget 10 kata baru per hari, review mingguan untuk retensi jangka panjang.", publishedAt: Date(timeIntervalSinceNow: -86400*21), isPremium: false)
    static let zatDanWujudnya = Material(title: "Zat dan Wujudnya", subject: .kimia, educationLevel: "SMP", grade: "7", difficulty: .beginner, estimatedMinutes: 12, summary: "Klasifikasi zat, perubahan wujud, dan sifat fisika-kimia.", content: "Zat terbagi padat, cair, gas. Perubahan wujud: mencair, membeku, menguap, mengembun, menyublim.\n\nSifat fisika: warna, titik didih, massa jenis. Sifat kimia: mudah terbakar, berkarat.\n\nContoh perubahan fisika: es mencair. Perubahan kimia: besi berkarat.\n\nEksperimen sederhana: panaskan kapur barus untuk melihat menyublim.", publishedAt: Date(timeIntervalSinceNow: -86400*26), isPremium: false)
    static let strukturAtom = Material(title: "Struktur Atom", subject: .kimia, educationLevel: "SMA", grade: "10", difficulty: .intermediate, estimatedMinutes: 20, summary: "Partikel subatom, konfigurasi elektron, dan tabel periodik.", content: "Atom terdiri dari proton, neutron, dan elektron. Nomor atom = jumlah proton, nomor massa = proton + neutron.\n\nKonfigurasi elektron mengikuti aturan aufbau, Hund, dan Pauli. Contoh: Natrium 1s2 2s2 2p6 3s1.\n\nElektron valensi menentukan sifat kimia. Unsur segolongan memiliki sifat mirip.\n\nIsotop adalah atom dengan proton sama tapi neutron berbeda, misal C-12 dan C-14.", publishedAt: Date(timeIntervalSinceNow: -86400*14), isPremium: false)
    static let ikatanKimia = Material(title: "Ikatan Kimia", subject: .kimia, educationLevel: "SMA", grade: "11", difficulty: .intermediate, estimatedMinutes: 22, summary: "Ikatan ion, kovalen, logam, dan struktur Lewis.", content: "Ikatan ion terjadi serah terima elektron antara logam dan nonlogam, contoh NaCl.\n\nIkatan kovalen berbagi elektron, contoh H2O. Kepolaran tergantung keelektronegatifan.\n\nStruktur Lewis menggambarkan pasangan elektron. Aturan oktet membantu prediksi stabilitas.\n\nIkatan logam: elektron bebas mengalir, menyebabkan konduktivitas dan kilap logam.", publishedAt: Date(timeIntervalSinceNow: -86400*19), isPremium: false)
    static let stoikiometri = Material(title: "Stoikiometri", subject: .kimia, educationLevel: "SMA", grade: "12", difficulty: .advanced, estimatedMinutes: 28, summary: "Perhitungan mol, pereaksi pembatas, dan rendemen reaksi.", content: "Mol adalah satuan jumlah zat: 1 mol = 6.02x10^23 partikel. Massa molar = massa per mol.\n\nPersamaan setara adalah kunci. Contoh: 2H2 + O2 -> 2H2O.\n\nPereaksi pembatas adalah yang habis pertama dan menentukan hasil. Hitung dengan membandingkan mol tersedia vs koefisien.\n\nRendemen = (hasil nyata / hasil teoritis) x 100%. Latihan soal campuran untuk penguasaan.", publishedAt: Date(timeIntervalSinceNow: -86400*10), isPremium: true)
    static let larutanDanPH = Material(title: "Larutan & pH", subject: .kimia, educationLevel: "SMA", grade: "11", difficulty: .intermediate, estimatedMinutes: 16, summary: "Konsentrasi larutan, asam-basa, dan perhitungan pH.", content: "Konsentrasi: molaritas = mol zat terlarut / liter larutan.\n\nAsam melepaskan H+, basa melepaskan OH-. Skala pH 0-14: <7 asam, 7 netral, >7 basa.\n\npH = -log[H+]. Contoh: [H+]=10^-3 => pH 3.\n\nIndikator dan titrasi digunakan untuk menentukan titik ekuivalen asam-basa.", publishedAt: Date(timeIntervalSinceNow: -86400*17), isPremium: false)

    static let materials: [Material] = [pecahanDasar, perkalianPembagian, aljabarSatuVariabel, turunanFungsi, integralTentu, statistikaDasar, simplePresentTense, readingComprehension, conditionalSentences, essayWriting, vocabularyBuilder, zatDanWujudnya, strukturAtom, ikatanKimia, stoikiometri, larutanDanPH]

    static let quizPecahan = Quiz(title: "Kuis Pecahan Dasar", subject: .matematika, materialID: pecahanDasar.id, questions: [
        QuizQuestion(text: "Hasil dari 1/2 + 1/4 adalah...", options: ["1/6", "2/6", "3/4", "1/8"], correctIndex: 2, explanation: "Samakan penyebut: 2/4+1/4=3/4."),
        QuizQuestion(text: "Bentuk desimal dari 3/4 adalah...", options: ["0.25", "0.5", "0.75", "0.80"], correctIndex: 2, explanation: "3/4 = 0.75."),
        QuizQuestion(text: "Pecahan senilai dengan 2/3 adalah...", options: ["3/4", "4/6", "5/7", "1/3"], correctIndex: 1, explanation: "Kalikan 2/3 x 2/2 = 4/6."),
        QuizQuestion(text: "Hasil 2/5 x 3/4 adalah...", options: ["6/20", "5/9", "6/9", "1/2"], correctIndex: 0, explanation: "2*3 / 5*4 = 6/20 = 3/10."),
        QuizQuestion(text: "Urutkan dari terkecil: 1/2, 1/3, 2/3", options: ["1/3, 1/2, 2/3", "1/2, 1/3, 2/3", "2/3, 1/2, 1/3", "1/3, 2/3, 1/2"], correctIndex: 0, explanation: "1/3=0.33, 1/2=0.5, 2/3=0.66.")
    ])
    static let quizTurunan = Quiz(title: "Kuis Turunan Fungsi", subject: .matematika, materialID: turunanFungsi.id, questions: [
        QuizQuestion(text: "Turunan dari f(x)=x^3 adalah...", options: ["x^2", "3x^2", "3x", "x^3"], correctIndex: 1, explanation: "Aturan pangkat: n*x^(n-1)."),
        QuizQuestion(text: "Turunan f(x)=5x^2 + 3x adalah...", options: ["10x+3", "5x+3", "10x", "3x"], correctIndex: 0, explanation: "Turunkan tiap suku."),
        QuizQuestion(text: "Jika y=(2x+1)^2 maka y' adalah...", options: ["2(2x+1)", "4(2x+1)", "2x+1", "4x"], correctIndex: 1, explanation: "Rantai: 2(2x+1)*2."),
        QuizQuestion(text: "Gradien garis singgung y=x^2 di x=2 adalah...", options: ["2", "4", "6", "8"], correctIndex: 1, explanation: "y'=2x => 4."),
        QuizQuestion(text: "Turunan sin x adalah...", options: ["-sin x", "cos x", "-cos x", "tan x"], correctIndex: 1, explanation: "Turunan sin = cos.")
    ])
    static let quizIntegral = Quiz(title: "Kuis Integral Tentu", subject: .matematika, materialID: integralTentu.id, questions: [
        QuizQuestion(text: "[integral][0,1] 2x dx =", options: ["0", "1", "2", "0.5"], correctIndex: 1, explanation: "x^2|0..1=1."),
        QuizQuestion(text: "[integral][0,2] 3x^2 dx =", options: ["4", "8", "6", "12"], correctIndex: 1, explanation: "x^3|0..2=8."),
        QuizQuestion(text: "[integral] x dx =", options: ["x", "x^2/2 + C", "x^2", "2x"], correctIndex: 1, explanation: "Antiturunan x."),
        QuizQuestion(text: "Luas di bawah y=4 di [0,3] adalah...", options: ["4", "12", "7", "3"], correctIndex: 1, explanation: "Integral konstanta = 4*3."),
        QuizQuestion(text: "Sifat [integral](f+g) =", options: ["[integral]f * [integral]g", "[integral]f + [integral]g", "[integral]f - [integral]g", "tidak ada"], correctIndex: 1, explanation: "Linearitas integral.")
    ])
    static let quizEnglish = Quiz(title: "Kuis English Grammar", subject: .english, materialID: conditionalSentences.id, questions: [
        QuizQuestion(text: "If it rains, we ___ at home.", options: ["stay", "will stay", "stayed", "would stay"], correctIndex: 1, explanation: "Type 1: will."),
        QuizQuestion(text: "If I ___ you, I would study.", options: ["am", "were", "was", "be"], correctIndex: 1, explanation: "Type 2 pakai were."),
        QuizQuestion(text: "She ___ coffee every morning.", options: ["drink", "drinks", "drinking", "drank"], correctIndex: 1, explanation: "She + s."),
        QuizQuestion(text: "If you had studied, you ___ passed.", options: ["will have", "would have", "would", "will"], correctIndex: 1, explanation: "Type 3."),
        QuizQuestion(text: "If you heat ice, it ___", options: ["melted", "melts", "will melt", "would melt"], correctIndex: 1, explanation: "Type 0 fakta.")
    ])
    static let quizAtom = Quiz(title: "Kuis Struktur Atom", subject: .kimia, materialID: strukturAtom.id, questions: [
        QuizQuestion(text: "Partikel bermuatan positif di inti adalah...", options: ["Elektron", "Proton", "Neutron", "Foton"], correctIndex: 1, explanation: "Proton positif."),
        QuizQuestion(text: "Nomor atom menunjukkan jumlah...", options: ["Neutron", "Proton", "Elektron valensi", "Massa"], correctIndex: 1, explanation: "Definisi nomor atom."),
        QuizQuestion(text: "Konfigurasi Na (Z=11) adalah...", options: ["1s2 2s2 2p6 3s1", "1s2 2s2 2p6", "1s2 2s1", "1s2 2p6 3s1"], correctIndex: 0, explanation: "Aufbau."),
        QuizQuestion(text: "Isotop memiliki...", options: ["Proton berbeda", "Neutron berbeda", "Elektron berbeda", "Semua berbeda"], correctIndex: 1, explanation: "Neutron beda, proton sama."),
        QuizQuestion(text: "Elektron valensi Cl (7) berada di...", options: ["Kulit 1", "Kulit 2", "Kulit 3", "Inti"], correctIndex: 2, explanation: "Periode 3.")
    ])
    static let quizStoikiometri = Quiz(title: "Kuis Stoikiometri", subject: .kimia, materialID: stoikiometri.id, questions: [
        QuizQuestion(text: "1 mol mengandung...", options: ["6.02x10^22", "6.02x10^23", "1x10^23", "3x10^23"], correctIndex: 1, explanation: "Bilangan Avogadro."),
        QuizQuestion(text: "Massa molar H2O adalah... (H=1,O=16)", options: ["16", "17", "18", "20"], correctIndex: 2, explanation: "2*1+16=18."),
        QuizQuestion(text: "Pereaksi pembatas adalah...", options: ["Paling banyak", "Habis pertama", "Paling mahal", "Gas"], correctIndex: 1, explanation: "Definisi."),
        QuizQuestion(text: "2H2+O2->2H2O, jika 2 mol H2 dan 1 mol O2, hasil H2O...", options: ["1 mol", "2 mol", "3 mol", "4 mol"], correctIndex: 1, explanation: "Stoikiometri 1:1."),
        QuizQuestion(text: "Rendemen 80% dari teoritis 100g adalah...", options: ["80g", "100g", "20g", "180g"], correctIndex: 0, explanation: "80% x100.")
    ])
    static let quizzes: [Quiz] = [quizPecahan, quizTurunan, quizIntegral, quizEnglish, quizAtom, quizStoikiometri]

    static let discussion1 = Discussion(authorID: budi.id, title: "Cara cepat paham turunan?", subject: .matematika, createdAt: Date(timeIntervalSinceNow: -86400*2), replies: [
        Reply(authorID: dewi.id, body: "Coba pahami aturan pangkat dulu, baru rantai. Latihan 10 soal per hari!", createdAt: Date(timeIntervalSinceNow: -86400*1.5), likes: 4),
        Reply(authorID: siti.id, body: "Aku pakai video visual, lebih kebayang gradiennya.", createdAt: Date(timeIntervalSinceNow: -86400*1), likes: 2)
    ], body: "Aku mentok di turunan fungsi komposisi. Ada trik biar tidak bingung aturan rantai?", likes: 12)
    static let discussion2 = Discussion(authorID: siti.id, title: "Tips essay English biar tidak blank", subject: .english, createdAt: Date(timeIntervalSinceNow: -86400*5), replies: [
        Reply(authorID: nadia.id, body: "Buat outline 3 poin dulu, baru kembangkan. Jangan langsung nulis panjang!", createdAt: Date(timeIntervalSinceNow: -86400*4), likes: 6),
        Reply(authorID: budi.id, body: "Pakai template: hook - thesis - body - conclusion.", createdAt: Date(timeIntervalSinceNow: -86400*3), likes: 3),
        Reply(authorID: rizky.id, body: "Baca contoh essay band 8, tiru strukturnya.", createdAt: Date(timeIntervalSinceNow: -86400*2), likes: 1)
    ], body: "Setiap disuruh essay, ideku buntu di paragraf pertama. Gimana cara brainstorming cepat?", likes: 18)
    static let discussion3 = Discussion(authorID: rizky.id, title: "Kenapa Stoikiometri susah?", subject: .kimia, createdAt: Date(timeIntervalSinceNow: -86400*3), replies: [
        Reply(authorID: dewi.id, body: "Kuncinya persamaan setara dulu. Kalau koefisien salah, semua salah.", createdAt: Date(timeIntervalSinceNow: -86400*2.2), likes: 7)
    ], body: "Aku selalu salah tentukan pereaksi pembatas. Ada langkah sistematis?", likes: 9)
    static let discussion4 = Discussion(authorID: dewi.id, title: "Integral vs Turunan, hubungan?", subject: .matematika, createdAt: Date(timeIntervalSinceNow: -86400*7), replies: [
        Reply(authorID: budi.id, body: "Integral adalah kebalikan turunan, seperti tambah vs kurang.", createdAt: Date(timeIntervalSinceNow: -86400*6), likes: 5),
        Reply(authorID: andi.id, body: "Teorema dasar kalkulus menyatukan keduanya!", createdAt: Date(timeIntervalSinceNow: -86400*5.5), likes: 2)
    ], body: "Bingung bedanya integral tentu dan tak tentu, serta kaitannya dengan turunan.", likes: 15)
    static let discussion5 = Discussion(authorID: nadia.id, title: "Vocabulary cepat hafal gimana?", subject: .english, createdAt: Date(timeIntervalSinceNow: -86400*1), replies: [
        Reply(authorID: siti.id, body: "Pakai mnemonik dan buat kalimat sendiri, jangan hanya hafal list.", createdAt: Date(timeIntervalSinceNow: -3600*12), likes: 3),
        Reply(authorID: andi.id, body: "Aku pakai flashcard Anki, spaced repetition manjur!", createdAt: Date(timeIntervalSinceNow: -3600*6), likes: 4)
    ], body: "Butuh hafal 100 kosakata minggu depan, metode paling efektif apa?", likes: 7)
    static let discussion6 = Discussion(authorID: andi.id, title: "Pecahan untuk anak SD biar fun?", subject: .matematika, createdAt: Date(timeIntervalSinceNow: -86400*10), replies: [
        Reply(authorID: siti.id, body: "Pakai pizza atau coklat batang, visual banget!", createdAt: Date(timeIntervalSinceNow: -86400*9), likes: 8)
    ], body: "Mau ajari adik pecahan, tapi dia bosan kalau hanya angka.", likes: 5)
    static let discussion7 = Discussion(authorID: budi.id, title: "Struktur atom: kulit vs orbital?", subject: .kimia, createdAt: Date(timeIntervalSinceNow: -86400*4), replies: [
        Reply(authorID: dewi.id, body: "Kulit itu level energi, orbital bentuk ruang elektron.", createdAt: Date(timeIntervalSinceNow: -86400*3.5), likes: 6),
        Reply(authorID: rizky.id, body: "Bayangkan kulit seperti lantai gedung, orbital kamar di lantai itu.", createdAt: Date(timeIntervalSinceNow: -86400*3), likes: 2),
        Reply(authorID: nadia.id, body: "Diagram aufbau membantu urutan pengisian.", createdAt: Date(timeIntervalSinceNow: -86400*2.5), likes: 1)
    ], body: "Bedanya kulit K,L,M dengan orbital s,p,d apa ya?", likes: 22)
    static let discussion8 = Discussion(authorID: siti.id, title: "Conditional mana yang paling sering keluar?", subject: .english, createdAt: Date(timeIntervalSinceNow: -86400*6), replies: [
        Reply(authorID: nadia.id, body: "Type 1 dan 2 paling sering di ujian SMP/SMA.", createdAt: Date(timeIntervalSinceNow: -86400*5), likes: 5),
        Reply(authorID: dewi.id, body: "Type 0 untuk sains juga sering.", createdAt: Date(timeIntervalSinceNow: -86400*4.5), likes: 2)
    ], body: "Mau fokus belajar conditional, tapi tipe mana yang prioritas?", likes: 11)
    static let discussions: [Discussion] = [discussion1, discussion2, discussion3, discussion4, discussion5, discussion6, discussion7, discussion8]

    static let note1 = Note(materialID: pecahanDasar.id, title: "Rangkuman Pecahan", body: {
        var a = AttributedString("Pecahan = pembilang / penyebut\nTips: samakan penyebut dulu!")
        a.font = .system(.body, design: .rounded)
        return a
    }(), updatedAt: Date(timeIntervalSinceNow: -86400*1), subject: .matematika)
    static let note2 = Note(materialID: conditionalSentences.id, title: "Conditional Cheat Sheet", body: {
        var a = AttributedString("Type 1: If + present, will + V1\nType 2: If + past, would + V1")
        a.font = .system(.body, design: .rounded)
        return a
    }(), updatedAt: Date(timeIntervalSinceNow: -86400*2), subject: .english)
    static let note3 = Note(materialID: turunanFungsi.id, title: "Turunan Kilat", body: {
        var a = AttributedString("Aturan pangkat: x^n -> n x^(n-1)\nRantai: (f o g)' = f'(g)*g'")
        a.font = .system(.body, design: .rounded)
        return a
    }(), updatedAt: Date(timeIntervalSinceNow: -3600*5), subject: .matematika)
    static let note4 = Note(materialID: stoikiometri.id, title: "Stoikiometri Step", body: {
        var a = AttributedString("1. Setarakan persamaan\n2. Hitung mol\n3. Cari pembatas\n4. Hitung hasil")
        a.font = .system(.body, design: .rounded)
        return a
    }(), updatedAt: Date(timeIntervalSinceNow: -3600*10), subject: .kimia)
    static let notes: [Note] = [note1, note2, note3, note4]

    static let achievement1 = Achievement(title: "Pemula Rajin", symbol: "star.fill", isUnlocked: true, progress: 1.0)
    static let achievement2 = Achievement(title: "7 Hari Streak", symbol: "flame.fill", isUnlocked: true, progress: 1.0)
    static let achievement3 = Achievement(title: "Juara Kuis", symbol: "trophy.fill", isUnlocked: false, progress: 0.6)
    static let achievement4 = Achievement(title: "Penjelajah Materi", symbol: "books.vertical.fill", isUnlocked: false, progress: 0.4)
    static let achievements: [Achievement] = [achievement1, achievement2, achievement3, achievement4]
}

