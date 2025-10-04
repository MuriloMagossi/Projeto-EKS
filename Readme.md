# Projeto EKS com Terraform

## Objetivo
Criar um cluster EKS com Terraform onde:
- O Kubernetes será privado (nós em subnets privadas)
- ALB (Application Load Balancer) será exposto na rede pública
- Terraform será executado via pipeline no GitHub Actions

## Etapas para Implementação

### 1. Preparação do Ambiente Local
- [X] Instalar AWS CLI
- [X] Configurar credenciais AWS (`aws configure`)
- [X] Instalar Terraform
- [X] Instalar kubectl
- [X] Criar conta AWS com permissões adequadas

### 2. Configuração do Estado do Terraform
- [X] Criar bucket S3 para armazenar o estado do Terraform
- [X] Habilitar versionamento no bucket S3
- [X] Configurar DynamoDB para lock do estado
- [X] Criar arquivo `backend.tf` para configurar o backend remoto

### 3. Estrutura do Projeto Terraform
- [X] Criar estrutura de diretórios do projeto
- [X] Configurar `main.tf` com providers (AWS, Kubernetes)
- [X] Criar `variables.tf`
- [X] Criar `outputs.tf`

### 4. Infraestrutura de Rede
- [X] Criar VPC com CIDR apropriado
- [X] Criar subnets públicas (para ALB e NAT Gateway)
- [X] Criar subnets privadas (para nós do EKS)
- [X] Configurar Internet Gateway
- [X] Configurar NAT Gateway para subnets privadas
- [X] Configurar Route Tables

### 6. Cluster EKS
- [X] modelar main eks
- [X] configurar VPC e Subnets

### 7. Application Load Balancer (ALB)
- [ ] 

### 8. Pipeline GitHub Actions
- [ ] Criar secrets no GitHub (AWS credentials)
- [ ] Criar workflow `.github/workflows/terraform.yml`
- [ ] Configurar stages: plan, apply, destroy
- [ ] Configurar approval manual para apply
- [ ] Configurar notificações de status

### 9. Testes e Validação
- [ ] Testar criação completa da infraestrutura
- [ ] Validar conectividade do cluster
- [ ] Testar deploy de aplicação via ALB
- [ ] Validar funcionamento do pipeline
- [ ] Testar processo de destruição

### 10. Documentação e Monitoramento
- [ ] Documentar comandos kubectl essenciais
- [ ] Criar dashboards de monitoramento
- [ ] Documentar processo de troubleshooting

## Arquivos Necessários
- `main.tf` - Configuração principal
- `variables.tf` - Variáveis do projeto
- `outputs.tf` - Outputs importantes
- `backend.tf` - Configuração do backend S3
- `terraform.tfvars` - Valores das variáveis
- `.github/workflows/terraform.yml` - Pipeline CI/CD
- `README.md` - Esta documentação

## Comandos Úteis
```bash
# Inicializar Terraform
terraform init

# Planejar mudanças
terraform plan

# Aplicar mudanças
terraform apply

# Conectar ao cluster
aws eks update-kubeconfig --region <region> --name <cluster-name>

# Verificar status do cluster
kubectl get nodes
kubectl get pods --all-namespaces
```

## Notas Importantes
- ALB (Application Load Balancer) é um load balancer da AWS que funciona na camada 7 (HTTP/HTTPS)
- Os nós do EKS ficarão em subnets privadas para maior segurança
- O ALB ficará em subnets públicas para acesso externo
- Use sempre tags adequadas para organização e billing
- Configure backup e disaster recovery conforme necessário