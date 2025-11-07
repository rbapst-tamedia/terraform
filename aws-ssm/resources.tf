# Test document to run from AWS console. No aws_ssm_association, has to be run from AWS SSM console
resource "aws_ssm_document" "test_adjoin" {
  name            = "AAAA--rba-test"
  document_format = "JSON"
  document_type   = "Command"
  content = jsonencode(
    {
      description = "To test new version fo adjoin.sh script"
      mainSteps = [
        {
          action = "aws:runShellScript"
          inputs = {
            runCommand = [
              file("../../../tx-pts-dai/ness-core-infrastructure/documents/adjoin-test.sh")
            ]
          }
          name = "TestDomainJoinAndAdminLocalAdmins"
          precondition = {
            StringEquals = [
              "platformType",
              "Linux",
            ]
          }
        }
      ]
      schemaVersion = "2.2"
    }
  )
}
