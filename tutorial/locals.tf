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
      username = "one_name",
      email    = "one.name@example.com",
    },
    {
      username = "another_name",
      email    = "another.name@example.com",
    }
  ]

  phone = {
    police = {
      phone = 117
    },
    fire = {
      phone = 118
    }
  }

  me = local.phone["police"].phone
}
