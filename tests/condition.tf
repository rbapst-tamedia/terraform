locals {
  deploy_random   = true
  deploy_random_2 = true
}

resource "random_pet" "this" {
  count  = local.deploy_random ? 1 : 0
  length = 10
  prefix = "f"
}


resource "random_pet" "this_2" {
  count  = local.deploy_random ? 1 : 0
  # length = local.deploy_random ? random_pet.this[0].length : 9
  length = random_pet.this[0].length
  prefix = "second"
}
