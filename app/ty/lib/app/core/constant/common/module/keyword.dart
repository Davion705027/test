import 'package:flutter_ty_app/generated/locales.g.dart';

/**
 * 投注快捷金额
 *
 */
const keyboard = [
  {
    'text': "5",
    'value': 5,
    'disabled': false
  },
  {
    'text': "10",
    'value': 10, // 数值
    'disabled': false // 禁用
  },
  {
    'text': "25",
    'value': 25,
    'disabled': false
  },
  {
    'text': "50",
    'value': 50,
    'disabled': false
  },
  {
    'text': "100",
    'value': 100,
    'disabled': false
  },
  {
    'text': "200",
    'value': 200,
    'disabled': false
  }
];

// 盘 对应关系
const odds_type_name = {
  "EU": LocaleKeys.odds_EU, //欧洲盘
  "ID": LocaleKeys.odds_ID, //印尼盘
  "US": LocaleKeys.odds_US, //美式盘
  "MY": LocaleKeys.odds_MY, //马来盘
  "GB": LocaleKeys.odds_GB, //英式盘
  "HK": LocaleKeys.odds_HK, //香港盘
};

// 币种对应关系
const currency_code = {
  1: 'RMB',
  2: "USD",
  15: "AED",
  13: "AUD",
  41: "AZN",
  43: "BBD",
  44: "BRL",
  27: "BND",
  29: "BRL",
  50: "BSD",
  52: "BTN",
  14: "CAD",
  56: "CDF",
  59: "CLP",
  60: "CNH",
  62: "CUC",
  63: "CUP",
  64: "CVE",
  68: "DOP",
  17: "DZD",
  19: "EGP",
  7: "EUR",
  71: "FJD",
  72: "FKP",
  6: "GBP",
  73: "GEL",
  77: "GMD",
  79: "GTQ",
  3: "HKD",
  81: "HNL",
  25: "IDR",
  87: "IQD",
  10: "JPY",
  93: "KES",
  96: "KMF",
  12: "KRW",
  107: "MAD",
  33: "MMK",
  16: "MOP",
  116: "MXN",
  22: "MYR",
  119: "NGN",
  18: "OMR",
  126: "PGK",
  11: "PHP",
  132: "RSD",
  20: "RUB",
  136: "SCR",
  137: "SDG",
  138: "SEK",
  5: "SGD",
  140: "SLL",
  144: "STD",
  145: "STN",
  26: "THB",
  151: "TND",
  152: "TOP",
  31: "TRY",
  9: "TWD",
  156: "UGX",
  157: "UYU",
  167: "XOF",
  172: "ZAR",
  173: "ZMW",
};