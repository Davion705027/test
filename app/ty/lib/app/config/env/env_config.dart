/// @Author swifter
/// @Date 2023/9/17 15:40

enum Env {
  DEV(
    api_url: "",
    merchant: "",
    secret: "",
    base_url: "http://h5.zxjlbvip.org",
    // "https://dawsapitpp1.si6w8.com",
    coron_url: "https://dev-bob-wap.emkcp.com",
    mqtt_url: "wss://api.mjpu9qew.com/yewuws2/push",
    cdn_url: "http://dl.ybdj.online/",
    mqtt_name: "admin",
    mqtt_password: "Qazqaz123...",
    upload_url: 'https://uphw-cdn5.q7b4549e.com/',
  ),
  FAT(
    api_url: "http://dj-fat-bobapi.zxjlbvip.org",
    merchant: "376523290039260",
    secret: "d695e6b89648d0b671e1d5ff00684265",
    base_url: "http://newh5.zxjlbvip.org",
    coron_url: "http://fatbob-api-1.yblott.com",
    mqtt_url: "wss://djmqfat.ouligk.com:8084/mqtt",
    cdn_url: "http://dl.pai500.org/",
    mqtt_name: "admin",
    mqtt_password: "Qazqaz123...",
    upload_url: 'http://dl1.zxjlbvip.org/',
  ),
  UAT(
    api_url: "http://loginbob.oqwelo123.com",
    merchant: "51795451072280192",
    secret: "963cfd7ef39c601b7868604cb7f71f76",
    base_url: "https://duatbob-txapi.kkgnru.com",
    coron_url: "https://uat-wap.obcp.io",
    mqtt_url: "wss://uat-djwss.kluiqe1d.com:8084/mqtt",
    cdn_url: "https://dj-uat.klsdfjoiuwe23.com:8011/",
    mqtt_name: "admin",
    mqtt_password: "Qazqaz123...",
    upload_url: 'https://uat-uptxcdn1.sq5595.com/',
  ),
  PROD(
    api_url: "",
    merchant: "",
    secret: "",
    base_url: "http://dawsapitpp1.si6w8.com",
    coron_url: "https://h5.bobcp.vip",
    mqtt_url: "wss://pro-dj-aws-mqtt.qxbc09w9.com:8084/mqtt",
    cdn_url: "https://txgzdj.91dkwg.com:8012/",
    mqtt_name: "admin",
    mqtt_password: "Qazqaz123...",
    upload_url: 'https://uptx-cdn2.q0n5k964.com/',
  );

  final String api_url;
  final String merchant;
  final String secret;
  final String base_url;
  final String coron_url;
  final String mqtt_url;
  final String cdn_url;
  final String mqtt_name;
  final String mqtt_password;
  final String upload_url;

  const Env({
    required this.api_url,
    required this.merchant,
    required this.secret,
    required this.base_url,
    required this.coron_url,
    required this.mqtt_url,
    required this.cdn_url,
    required this.mqtt_name,
    required this.mqtt_password,
    required this.upload_url,
  });
}

Env appEnv = Env.PROD;
