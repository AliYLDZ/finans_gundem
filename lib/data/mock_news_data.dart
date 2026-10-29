import '../models/news_item.dart';

class MockNewsData {
  static List<NewsItem> getNews() {
    final now = DateTime.now();

    return [
      NewsItem(
        id: 'news_1',
        title: 'BIST 100 Endeksi Bankacılık ve Havacılık Öncülüğünde Rekor Seviyelere Tırmanıyor',
        summary: 'Borsa İstanbul\'da BIST 100 endeksi, yabancı yatırımcı ilgisi ve güçlü bilanço beklentileriyle günü %1.47 yükselişle 9.845 puandan tamamladı.',
        content: '''
Borsa İstanbul BIST 100 endeksi, haftanın üçüncü işlem gününde alıcılı bir seyir izleyerek kapanışa doğru kazançlarını artırdı. Özellikle bankacılık (%2.3) ve havacılık (%2.1) hisselerindeki güçlü alımlar endeksin 9.800 puan direncinin üzerine çıkmasını sağladı.

Analistler, Merkez Bankası'nın faiz kararı öncesinde piyasada olumlu beklentilerin korunduğunu belirtiyor. Türk Hava Yolları (THYAO), Garanti BBVA (GARAN) ve Akbank (AKBNK) en çok işlem gören hisseler arasında ilk sıralarda yer aldı.

Yatırımcı İlişkileri Direktörleri, üçüncü çeyrek finansal sonuçlarının açıklanmaya başlamasıyla birlikte şirket bazlı ayrışmaların artabileceğini vurguluyor. Teknik açıdan BIST 100 endeksinde 9.900 seviyesi direnç, 9.720 seviyesi ise ana destek konumunda bulunuyor.
''',
        category: 'BIST',
        imageUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80',
        source: 'Bloomberg HT',
        publishedAt: now.subtract(const Duration(minutes: 25)),
        isBreaking: true,
        relatedSymbols: ['XU100', 'THYAO', 'GARAN', 'AKBNK'],
        url: 'https://www.bloomberght.com',
        readingTimeMinutes: 4,
      ),
      NewsItem(
        id: 'news_2',
        title: 'Fed Yetkililerinden Faiz İndirimi Sinyali: Wall Street Rallisi Hız Kazandı',
        summary: 'S&P 500 ve Nasdaq endeksleri, ABD Merkez Bankası (Fed) üyelerinin güvercin açıklamaları ve teknoloji devlerinin bilançoları sonrası yükselişini sürdürüyor.',
        content: '''
New York Borsası'nda (Wall Street) endeksler, Fed yetkililerinin enflasyondaki yavaşlamaya dikkat çekerek kademeli faiz indirimlerine devam edilebileceği sinyalini vermesiyle yükselişle kapandı.

S&P 500 %0.55 primle 5.864 puana ulaşırken, teknoloji ağırlıklı Nasdaq %0.70 artış gösterdi. Çip üreticisi Nvidia (NVDA) yeni nesil yapay zeka çiplerine olan devasa talep haberleriyle %2.31 değer kazanarak piyasa değerini artırdı.

Piyasa uzmanları, ABD'de açıklanacak perakende satışlar ve istihdam verilerinin Fed'in Gelecek ay yapacağı toplantıdaki 25 baz puanlık faiz indirimi beklentilerini pekiştirebileceğini öngörüyor. Apple (AAPL), Microsoft (MSFT) ve Amazon (AMZN) hisseleri de günü pozitif bölgede tamamladı.
''',
        category: 'ABD Borsaları',
        imageUrl: 'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=800&q=80',
        source: 'Wall Street Journal',
        publishedAt: now.subtract(const Duration(hours: 1, minutes: 10)),
        isBreaking: true,
        relatedSymbols: ['S&P 500', 'NASDAQ', 'NVDA', 'AAPL'],
        url: 'https://www.wsj.com',
        readingTimeMinutes: 5,
      ),
      NewsItem(
        id: 'news_3',
        title: 'Bitcoin 68.000 Doları Aştı: Spot ETF\'lere Dev Sermaye Akışı Sürüyor',
        summary: 'Kripto para piyasalarında boğa rüzgarı esiyor. Bitcoin (BTC) kurumsal yatırımcı girişleriyle 68.450 dolara kadar tırmandı.',
        content: '''
Lider kripto para birimi Bitcoin (BTC), ABD spot ETF'lerine gerçekleşen son dönemin en yüksek net nakit girişiyle birlikte kritik direnç noktalarını tek tek aştı. BTC, gün içerisinde %2.73 yükselerek 68.450 dolar seviyesini test etti.

Ethereum (ETH) da Bitcoin'deki yükseliş trendine eşlik ederek %3.33 artışla 2.640 doların üzerine çıktı. Solana (SOL) ve Avalanche (AVAX) gibi katman-1 blokzincir projelerinde de hacim artışları dikkat çekiyor.

Analistler, ABD seçimleri öncesinde artan küresel likidite beklentileri ve opsiyon piyasasındaki pozitif konumlanmanın Bitcoin'in tarihi zirve seviyesi olan 73.700 doları tekrar hedeflemesine yol açabileceğini ifade ediyor.
''',
        category: 'Kripto Para',
        imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80',
        source: 'CoinDesk',
        publishedAt: now.subtract(const Duration(hours: 2, minutes: 40)),
        isBreaking: false,
        relatedSymbols: ['BTC/USD', 'ETH/USD', 'SOL'],
        url: 'https://www.coindesk.com',
        readingTimeMinutes: 3,
      ),
      NewsItem(
        id: 'news_4',
        title: 'Gram Altın Rekor Tazeledi: Ons Altın 2.710 Doları Aşarak Zirveye Yerleşti',
        summary: 'Ortadoğu\'daki jeopolitik riskler ve küresel faiz indirimi dalgası güvenli liman altına olan talebi tarihi zirvelere taşıdı.',
        content: '''
Altın fiyatları hem ons hem de gram bazında yeni rekorlara imza atmaya devam ediyor. Ons altın uluslararası piyasalarda 2.712 dolar seviyesine yükselerek tüm zamanların en yüksek değerine ulaştı.

İç piyasada ise Dolar/TL kurundaki yatay-yukarı seyir ve ons altındaki rekorla birlikte Gram Altın 2.985 TL seviyesine kadar yükseldi. Kapalıçarşı'da fiziki altın talebinde de canlılık göze çarpıyor.

Piyasa stratejistleri, merkez bankalarının altın rezervlerini artırma politikaları ve jeopolitik gerilimlerin devam etmesi halinde ons altının yıl sonuna kadar 2.750 - 2.800 dolar bandını zorlayabileceğini dile getiriyor.
''',
        category: 'Döviz & Altın',
        imageUrl: 'https://images.unsplash.com/photo-1610375461246-83df859d849d?w=800&q=80',
        source: 'Anadolu Finans',
        publishedAt: now.subtract(const Duration(hours: 4, minutes: 15)),
        isBreaking: false,
        relatedSymbols: ['GRAM_ALTIN', 'ONS_ALTIN', 'USD/TRY'],
        url: 'https://www.aa.com.tr/tr/finans',
        readingTimeMinutes: 4,
      ),
      NewsItem(
        id: 'news_5',
        title: 'Merkez Bankaları Rezervleri Güçlendiriyor: Küresel Enflasyonda Son Durum',
        summary: 'Uluslararası Para Fonu (IMF) yayınladığı son raporda küresel ekonominin yumuşak iniş senaryosuna yaklaştığını bildirdi.',
        content: '''
IMF ve Dünya Bankası yıllık toplantıları öncesinde yayınlanan Küresel Ekonomik Görünüm Raporu, gelişmiş ülke ekonomilerinde enflasyonun hedeflenen seviyelere doğru gerilediğini ortaya koydu.

Raporda, küresel büyüme tahminleri hafif yukarı yönlü revize edilirken, sıkı para politikalarının kademeli olarak gevşetilmesinin yatırımları ve ticareti canlandıracağı vurgulandı.

Öte yandan, gelişmekte olan ülkelerde sermaye akımlarının yeniden artışa geçtiği ve uluslararası rezervlerin güçlendiği kaydedildi.
''',
        category: 'Ekonomi',
        imageUrl: 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=800&q=80',
        source: 'Reuters Finans',
        publishedAt: now.subtract(const Duration(hours: 6)),
        isBreaking: false,
        relatedSymbols: ['EUR/TRY', 'USD/TRY'],
        url: 'https://www.reuters.com',
        readingTimeMinutes: 4,
      ),
      NewsItem(
        id: 'news_6',
        title: 'Yapay Zeka Şirketlerinin Piyasa Değeri Trilyon Dolarları Aşmaya Devam Ediyor',
        summary: 'Nvidia, Microsoft ve Google yapay zeka altyapı yatırımlarını artırırken hisse senetlerinde yeni ralli hedefleri belirleniyor.',
        content: '''
Bilişim ve veri merkezi harcamalarında yapay zeka odaklı dönüşüm hız kesmeden devam ediyor. Teknoloji devlerinin üçüncü çeyrek bilanço beklentilerinde veri merkezi gelirlerinin %40'ın üzerinde büyümesi bekleniyor.

Nvidia'nın CEO'su Jensen Huang, Blackwell mimarisine sahip çiplerin üretim kapasitesinin tam randımanla çalıştığını ve önümüzdeki 12 ay boyunca tüm siparişlerin dolduğunu açıkladı.

Wall Street analistleri, teknoloji sektöründeki bu ivmenin S&P 500 endeksini yıl sonuna doğru yeni rekor seviyelere taşıyabileceği görüşünde birleşiyor.
''',
        category: 'ABD Borsaları',
        imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=800&q=80',
        source: 'CNBC Markets',
        publishedAt: now.subtract(const Duration(hours: 8)),
        isBreaking: false,
        relatedSymbols: ['NVDA', 'MSFT', 'GOOGL', 'NASDAQ'],
        url: 'https://www.cnbc.com',
        readingTimeMinutes: 3,
      ),
    ];
  }
}
