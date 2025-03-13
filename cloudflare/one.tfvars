# Using cblanche.ch DNS domain in Tamedia account because it's not used
cloudflare_static_records = [
  {
    name    = "rba-test-1.cblanche.ch."
    zone    = "cblanche.ch"
    content = "rba-test-1"
    type    = "CNAME"
    ttl     = "300"
    comment = "test"
  },
  {
    name    = "rba-test-1.cblanche.ch"
    zone    = "cblanche.ch"
    content = "rba-test-1"
    type    = "CNAME"
    ttl     = "300"
    comment = "test"
  },
]
