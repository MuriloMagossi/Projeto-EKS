# Projeto EKS com Terraform

## Objetivo
Criar um cluster EKS com Terraform onde:
- O Kubernetes será privado (nós em subnets privadas)
- ALB (Application Load Balancer) será exposto na rede pública
- Terraform será executado via pipeline no GitHub Actions

## Etapas para Implementação

### 1. Preparação do Ambiente Local
- [ ] Instalar AWS CLI
- [ ] Configurar credenciais AWS (`aws configure`)
- [ ] Instalar Terraform
- [ ] Instalar kubectl
- [ ] Criar conta AWS com permissões adequadas

### 2. Configuração do Estado do Terraform
- [ ] Criar bucket S3 para armazenar o estado do Terraform
- [ ] Habilitar versionamento no bucket S3
- [ ] Configurar DynamoDB para lock do estado
- [ ] Criar arquivo `backend.tf` para configurar o backend remoto

### 3. Estrutura do Projeto Terraform
- [ ] Criar estrutura de diretórios do projeto
- [ ] Configurar `main.tf` com providers (AWS, Kubernetes)
- [ ] Criar `variables.tf` com variáveis necessárias
- [ ] Criar `outputs.tf` com outputs importantes
- [ ] Configurar `terraform.tfvars` com valores específicos

### 4. Infraestrutura de Rede
- [ ] Criar VPC com CIDR apropriado
- [ ] Criar subnets públicas (para ALB e NAT Gateway)
- [ ] Criar subnets privadas (para nós do EKS)
- [ ] Configurar Internet Gateway
- [ ] Configurar NAT Gateway para subnets privadas
- [ ] Configurar Route Tables

### 5. Segurança e IAM
- [ ] Criar roles IAM para EKS Cluster
- [ ] Criar roles IAM para EKS Node Groups
- [ ] Configurar Security Groups para cluster e nós
- [ ] Configurar Security Groups para ALB
- [ ] Criar policies IAM necessárias

### 6. Cluster EKS
- [ ] Criar cluster EKS com configurações de segurança
- [ ] Configurar logging do cluster (CloudWatch)
- [ ] Criar node groups nas subnets privadas
- [ ] Configurar auto-scaling groups para os nós
- [ ] Instalar AWS Load Balancer Controller

### 7. Application Load Balancer (ALB)
- [ ] Criar ALB nas subnets públicas
- [ ] Configurar target groups
- [ ] Configurar listeners e rules
- [ ] Criar ingress controller para Kubernetes
- [ ] Configurar certificados SSL/TLS (opcional)

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
- [ ] Configurar CloudWatch monitoring
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