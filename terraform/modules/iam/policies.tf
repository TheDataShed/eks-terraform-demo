data "aws_iam_policy_document" "assume_role_policy" {
  statement = {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = ["eks.amazonaws.com"]
    }
  }
}
