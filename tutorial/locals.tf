#
# Locals (pratique pour faire des "calculs")
#
locals {
  allowed_ips = [
    "un",
    "deux",
    "trois"
  ]

  premier_element = local.allowed_ips[0]

  array_of_records = [
    {
      username = "Roland_Bapst",
      email    = "roland.bapst@tx.group",
    },
    {
      username = "Fabien_Francillon",
      email    = "fabien.francillon@tx.group",
    }
  ]

  map = {
    roland = {
      phone = 5114
    },
    marvin = {
      phone = 6000
    }
  }

  roland = local.map["roland"].phone
}
