variable "waf_whitelisted_ips_v4" {
  description = "The IPv4s to whitelist in WAF. The variable is for environment specific whitelists, please use the list in the waf module definition for all envs whitelists"
  type        = list(string)
  default = [
    "46.101.116.1/32", # teci-571 IP of goTom, took to take picture of website
    "185.94.24.0/22",  # fum-1454 Allow saucelabs
    # Note: FUM-3312. Oracle list of crawler looks no more to be suppored. Here is the last list we had.
    # Note 2: Oracle will stop this service Sep 30th, this list is to keep until then
    # BEGIN OF ORACLE LIST
    "132.145.11.125/32",
    "132.145.14.70/32",
    "132.145.15.209/32",
    "132.145.64.33/32",
    "132.145.66.116/32",
    "132.145.66.156/32",
    "132.145.67.248/32",
    "132.145.9.5/32",
    "140.238.81.78/32",
    "140.238.83.181/32",
    "140.238.94.137/32",
    "140.238.95.199/32",
    "140.238.95.47/32",
    "148.64.56.112/32",
    "148.64.56.113/32",
    "148.64.56.114/32",
    "148.64.56.115/32",
    "148.64.56.116/32",
    "148.64.56.117/32",
    "148.64.56.118/32",
    "148.64.56.119/32",
    "148.64.56.120/32",
    "148.64.56.121/32",
    "148.64.56.122/32",
    "148.64.56.123/32",
    "148.64.56.124/32",
    "148.64.56.125/32",
    "148.64.56.126/32",
    "148.64.56.127/32",
    "148.64.56.128/32",
    "148.64.56.64/32",
    "148.64.56.65/32",
    "148.64.56.66/32",
    "148.64.56.67/32",
    "148.64.56.68/32",
    "148.64.56.69/32",
    "148.64.56.70/32",
    "148.64.56.71/32",
    "148.64.56.72/32",
    "148.64.56.73/32",
    "148.64.56.74/32",
    "148.64.56.75/32",
    "148.64.56.76/32",
    "148.64.56.77/32",
    "148.64.56.78/32",
    "148.64.56.79/32",
    "148.64.56.80/32",
    "152.67.128.219/32",
    "152.67.137.35/32",
    "152.67.138.180/32",
    # END OF ORACLE LIST
  ]
}
variable "waf_whitelisted_ips_v6" {
  description = "The IPv6s to whitelist in WAF. The variable is for environment specific whitelists, please use the list in the waf module definition for all envs whitelists"
  type        = list(string)
  default     = []
}

locals {
  waf_bypass_header_name = "x-disco-waf-bypass"
  waf_bypass_header = {
    (local.waf_bypass_header_name) = "dummy"
  }
}

variable "waf_block_articles" {
  default = [
    { name = "teci-439_Block_UK_Articles"
      articles = [
        "/story/21008846",
        "/story/11682567",
        "/story/10750748",
        "/story/20066183",
        "/story/29008823",
        "/story/17703007",
        "-930543720570"
      ]
      country_codes = ["GB"]
      priority      = 10
    },
    { name = "teci-461_Block_US_Articles"
      articles = [
        "-548039927522",
        "-168154293778",
        "-850519746098",
        "-892009682269",
        "-295880478843",
        "-456984065155",
        "-875532264517",
        "-770770342355",
        "-199781524264",
        "-961874634370",
        "-521246040231",
        "-857984311223",
        "-266415915738",
        "-797546601302"
      ]
      country_codes = ["US"]
      priority      = 11
    }
  ]
  description = "Blocked Articles for WAF"
  type = list(object({
    name          = string
    priority      = number
    articles      = set(string)
    country_codes = set(string)
  }))
}

variable "enable_oracle_crawler_whitelist" {
  description = "Whitelist the Oracle Data Cloud Crawler IPs. (https://www.oracle.com/corporate/acquisitions/grapeshot/crawler.html)"
  type        = bool
  default     = false
}

variable "waf_enable_logging" {
  description = "Enable waf logs."
  type        = bool
  default     = false
}

module "waf" {
  source = "github.com/tx-pts-dai/terraform-aws-waf.git?ref=Fix-rate-limit-limits"

  providers = {
    aws = aws.us
  }

  enable_oracle_crawler_whitelist   = var.enable_oracle_crawler_whitelist
  enable_google_bots_whitelist      = true
  enable_parsely_crawlers_whitelist = true
  whitelisted_ips_v4 = concat([
    "145.234.0.0/16",     # TX servers and trusted clients
    "31.10.249.21/32",    # Küsnacht
    "46.240.134.174/32",  # Belgrade clients ISP 1
    "77.243.21.173/32",   # Belgrade clients ISP 2
    "52.17.9.21/32",      # Detectify IP Ireland 1
    "52.17.98.131/32",    # Detectify IP Ireland 2
    "134.209.240.242/32", # DISC-3100, BotTalk https://docs.bottalk.io/docs/monetization/paywall-integration#whitelisting-bottalk-parser-for-firewall
    "46.4.94.142/32",     # DISC-3100, BotTalk https://docs.bottalk.io/docs/monetization/paywall-integration#whitelisting-bottalk-parser-for-firewall
    "142.132.156.19/32",  # DISC-3100, BotTalk https://docs.bottalk.io/docs/monetization/paywall-integration#whitelisting-bottalk-parser-for-firewall
    "20.54.106.120/29",   # OneTrust Cookies Scanner IP ranges https://my.onetrust.com/s/article/UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af?language=en_US#UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af_section-idm231917567291454
    "20.103.218.56/29",   # OneTrust Cookies Scanner IP ranges https://my.onetrust.com/s/article/UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af?language=en_US#UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af_section-idm231917567291454
    "20.106.15.128/29",   # OneTrust Cookies Scanner IP ranges https://my.onetrust.com/s/article/UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af?language=en_US#UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af_section-idm231917567291454
    "20.1.221.192/29",    # OneTrust Cookies Scanner IP ranges https://my.onetrust.com/s/article/UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af?language=en_US#UUID-21f6bff2-1b12-8c67-e8b0-d852e36f37af_section-idm231917567291454
  ], var.waf_whitelisted_ips_v4)
  whitelisted_ips_v6 = var.waf_whitelisted_ips_v6
  whitelisted_headers = {
    headers = local.waf_bypass_header
  }
  count_requests_from_ch = false
  country_rates = [
    {
      name          = "Group_1-CH"
      limit         = 5000
      country_codes = ["CH"]
      priority      = 70
    },
    {
      name          = "Group_2-PY_RS"
      limit         = 4000
      country_codes = ["PY", "RS"]
      priority      = 71
    },
    {
      name          = "Group_3-IE_GB_DE"
      limit         = 2300
      country_codes = ["IE", "GB", "DE"]
      priority      = 72
    },
    {
      name          = "Group_4-AT"
      limit         = 1600
      country_codes = ["AT"]
      priority      = 73
    },
    {
      name          = "Group_5-FR_US_FI"
      limit         = 1000
      country_codes = ["FR", "US", "FI"]
      priority      = 74
    },
    {
      name          = "Group_6-BE_DK_ES_IT_LU_NO_PT_SE_NL"
      limit         = 650
      country_codes = ["BE", "DK", "ES", "IT", "LU", "NO", "PT", "SE", "NL"]
      priority      = 75
    }
  ]
  everybody_else_limit = 400
  limit_search_requests_by_countries = {
    limit         = 100
    country_codes = ["CH"]
  }
  block_articles = var.waf_block_articles
  enable_logging = var.waf_enable_logging
}
