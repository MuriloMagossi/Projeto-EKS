terraform {
  backend "s3" {
    # Configuração do Bucket S3
    bucket         = "terraform-state-eks-magossi"  # O nome do bucket que você criou
    key            = "global/terraform.tfstate"       # O caminho/nome do arquivo de estado dentro do bucket
    region         = "sa-east-1"                      # A região do bucket e da tabela

    # Configuração da Tabela DynamoDB para Lock
    dynamodb_table = "terraform-state-lock-table"     # O nome da tabela que você criou
    
    # Habilitar criptografia do lado do cliente (opcional, mas recomendado)
    encrypt        = true
  }
}