resource "aws_ecr_repository" "sgecr" {
  name = var.ecr_name
}

resource "aws_ecr_lifecycle_policy" "sgecr-policy" {
  repository = aws_ecr_repository.sgecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 15 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["sgecr"],
                "countType": "imageCountMoreThan",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "sgecr2" {
  name = var.ecr_name2
}

resource "aws_ecr_lifecycle_policy" "sgecr2-policy" {
  repository = aws_ecr_repository.sgecr2.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 15 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["sgecr2"],
                "countType": "imageCountMoreThan",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}