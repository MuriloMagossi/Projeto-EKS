terraform {
  backend "s3" {
    # Configuração do Bucket S3
    bucket         = "terraform-state-eks-magossi-202510062303"  
    key            = "global/terraform.tfstate"       
    region         = "us-east-1"                     
    # Configuração da Tabela DynamoDB para Lock
    dynamodb_table = "terraform-state-lock-table"     # O nome da tabela
        encrypt        = true
  }
}