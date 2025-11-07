# Using cblanche.ch DNS domain in Tamedia account because it's not used
cloudflare_static_records = [
  {
    name    = "_0234282abea9513969b17b5a0001f62b.doorman.dev.24heures.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "24heures.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_a534c3f1584773846e4289ec6b64f4ea.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_11c837834c9dee0fb83f6976daf01965.doorman.dev.bazonline.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "bazonline.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_58eee287f404ed71bbc8f4a88a80e71a.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_bf577ad3c6812d3ef64121ca684286ff.doorman.dev.berneroberlaender.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "berneroberlaender.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_4c0d1967de9767f2c401f374e0be1b7e.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_c3d6615e6b22e8e820bc2ea84e63d851.doorman.dev.bernerzeitung.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "bernerzeitung.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_fe7cd598b447695b4d241487fe8d13f5.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_e496a5f0a0683deb9be8de1067ecab73.doorman.dev.bilan.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "bilan.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_e1ba10966f616152737a6679269cbdee.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_014c9a0a0406024d2a70501af4713bd9.doorman.dev.carteb.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "carteb.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_02f869c227c7bc1559c26bc48b2ca519.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_524d73c31adcb277f4fe980ab7a138a8.doorman.dev.carteblanche.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "carteblanche.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_5c575d908f56c8cff0c37f27c930f112.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_2718b980ff1683689f3489f123b304f9.doorman.dev.derbund.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "derbund.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_6627e96103ce30d4db738fdc67137fe1.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_c0e3961252ce8a04027c3853b2e9f232.doorman.dev.fuw.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "fuw.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_aee935d67c3ee6121d285bb5eb033a14.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_befac3bfc2c29c6241b812cf0d84b5be.doorman.dev.landbote.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "landbote.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_711f6dce0d110147517a92b6fdb2bffc.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_e24f643c6e9a43ee3ea4efd746ef5fa3.doorman.dev.langenthalertagblatt.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "langenthalertagblatt.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_ce6e76c934e686ea66a99fbdc5f70b18.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_0e47a424186c53ebcc36432a81080e40.doorman.dev.tagesanzeiger.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "tagesanzeiger.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_5de8482626860b02c991ed36e2471e5f.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_e323210f70e3db2e7fa91e54889229fb.doorman.dev.tdg.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "tdg.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_ed14fe8795162bad2972cf788f73dbe5.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_b676af6df085a55199be6e5c3b1b5dec.doorman.dev.thunertagblatt.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "thunertagblatt.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_d8f1e03a26146b893b495c7c43d6bd36.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_77663fed1c012474c1c4817a12cb7bbf.doorman.dev.zsz.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "zsz.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_0a7751b7eaf0cc85b2988e442c38f985.xlfgrmvvlj.acm-validations.aws"
  },
  {
    name    = "_6c582650e2ce4b6336cc65a5fd57d083.doorman.dev.zuonline.ch"
    ttl     = "300"
    type    = "CNAME"
    zone    = "zuonline.ch"
    comment = "Validation record for AWS ACM certificate in AWS account 269132892972"
    content = "_ea045dc824cae7e7788a70a3db385346.xlfgrmvvlj.acm-validations.aws"
  },
]
