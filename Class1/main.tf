resource "aws_iam_user" "lb" {
  name = "damira"
}

resource "aws_iam_user" "lb1" {
  name = "alex"
}
resource "aws_iam_group" "developers" {
  name = "developers"
  
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb1.name,
    aws_iam_user.lb.name,
  ]

  group = aws_iam_group.developers.name
}


  
