# Fitness Takip Uygulaması

SwiftUI, Firebase ve SwiftData kullanılarak geliştirilmiş kapsamlı bir iOS fitness takip uygulaması. Uygulama, kullanıcıların antrenmanlarını takip etmelerine, ilerlemelerini izlemelerine ve fitness hedeflerini sürdürmelerine yardımcı olur.

## Özellikler

### Kullanıcı Yönetimi
- Firebase ile kullanıcı kaydı ve kimlik doğrulama
- Kişisel bilgi depolama ile profil yönetimi
- Güvenli giriş ve çıkış işlevselliği
- SwiftData ile kalıcı kullanıcı verisi depolama

### Antrenman Takibi
- Egzersiz hareket analizi
- Gerçek zamanlı form düzeltme
- Video tabanlı egzersiz rehberliği
- İlerleme takibi ve istatistikler

### Veri Yönetimi
- SwiftData ile yerel veri depolama
- Firebase ile bulut senkronizasyonu
- Güvenli kullanıcı verisi depolama
- Çevrimdışı işlevsellik

## Teknik Altyapı

### Ön Yüz
- Modern UI geliştirme için SwiftUI
- Özel UI bileşenleri ve animasyonlar
- Karanlık mod desteği
- Duyarlı tasarım

### Arka Uç
- Kullanıcı yönetimi için Firebase Authentication
- Bulut depolama için Firebase Realtime Database
- Yerel veri depolama için SwiftData
- Egzersiz analizi için özel video işleme

### Mimari
- MVVM (Model-View-ViewModel) mimarisi
- Temiz kod yapısı
- Modüler tasarım
- Bağımlılık enjeksiyonu

## Proje Yapısı

```
BitirmeProjesi/
├── AI/                    # Yapay zeka ve makine öğrenimi bileşenleri
├── Assets.xcassets/       # Görsel ve medya varlıkları
├── Common/               # Paylaşılan yardımcı programlar ve uzantılar
├── Fonts/                # Özel yazı tipleri
├── Model/                # Veri modelleri
│   └── veriTabani/      # Veritabanı modelleri
├── Screen/              # Ana uygulama ekranları
│   ├── Home/           # Ana ekran ve ilgili görünümler
│   ├── Register/       # Kayıt ekranları
│   └── ...
├── Servis/             # Servis katmanı
├── UICommon/           # Paylaşılan UI bileşenleri
└── ViewModel/          # Görünüm modelleri
```

## Kurulum

1. Depoyu klonlayın
```bash
git clone [depo-url]
```

2. Bağımlılıkları yükleyin
- Xcode 15.0 veya daha yeni
- iOS 17.0 veya daha yeni


3. Firebase'i yapılandırın
- `GoogleService-Info.plist` dosyasını projeye ekleyin
- Firebase Console'da Kimlik Doğrulamayı etkinleştirin
- Realtime Database'i ayarlayın

4. Derleme ve Çalıştırma
- Projeyi Xcode'da açın
- Hedef cihazınızı seçin
- Çalıştır'a basın veya ⌘R

## Detaylı Özellikler

### Kullanıcı Kaydı
- E-posta ve şifre kimlik doğrulaması
- Kişisel bilgi toplama
- Profil resmi yükleme
- Veri doğrulama ve hata yönetimi

### Egzersiz Analizi
- Gerçek zamanlı hareket takibi
- Form düzeltme önerileri
- Egzersiz video oynatma
- İlerleme takibi

### Veri Senkronizasyonu
- Otomatik bulut yedekleme
- Çevrimdışı veri erişimi
- Gerçek zamanlı güncellemeler
- Çakışma çözümleme

## Katkıda Bulunma

1. Depoyu fork edin
2. Özellik dalınızı oluşturun (`git checkout -b ozellik/HarikaOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Harika bir özellik ekle'`)
4. Dalınıza push yapın (`git push origin ozellik/HarikaOzellik`)
5. Pull Request açın

## Lisans

Bu proje MIT Lisansı altında lisanslanmıştır - detaylar için LICENSE dosyasına bakın

## Teşekkürler

- Backend hizmetleri için Firebase
- UI framework'ü için SwiftUI
- AI özellikleri için Apple'ın Core ML'i
- Tüm katkıda bulunanlar ve destekçiler

## İletişim

Adınız - [@twitter_kullanici_adiniz](https://twitter.com/twitter_kullanici_adiniz)
Proje Linki: [https://github.com/kullanici_adiniz/BitirmeProjesi](https://github.com/kullanici_adiniz/BitirmeProjesi)