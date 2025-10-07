@echo off
setlocal

echo ========================================
echo    CRIACAO DE RECURSOS AWS PARA TERRAFORM
echo ========================================
echo.

REM Configurações
set BUCKET_NAME=terraform-state-eks-magossi
set TABLE_NAME=terraform-state-lock-table
set AWS_REGION=us-east-1

echo Verificando AWS CLI...
aws --version
if %errorlevel% neq 0 (
    echo ERRO: AWS CLI nao encontrado!
    pause
    exit /b 1
)

echo.
echo Verificando credenciais AWS...
aws sts get-caller-identity
if %errorlevel% neq 0 (
    echo ERRO: AWS nao configurado!
    echo Execute: aws configure
    pause
    exit /b 1
)

echo.
echo ========================================
echo CRIANDO BUCKET S3...
echo ========================================

echo Tentando criar bucket: %BUCKET_NAME%
aws s3api create-bucket --bucket %BUCKET_NAME% --region %AWS_REGION%
if %errorlevel% equ 0 (
    echo SUCESSO: Bucket criado!
) else (
    echo AVISO: Bucket pode ja existir ou erro na criacao
)

echo.
echo Configurando bucket...
aws s3api put-public-access-block --bucket %BUCKET_NAME% --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-versioning --bucket %BUCKET_NAME% --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket %BUCKET_NAME% --server-side-encryption-configuration "{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\": {\"SSEAlgorithm\": \"AES256\"}}]}"

echo.
echo ========================================
echo CRIANDO TABELA DYNAMODB...
echo ========================================

echo Tentando criar tabela: %TABLE_NAME%
aws dynamodb create-table --table-name %TABLE_NAME% --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region %AWS_REGION%
if %errorlevel% equ 0 (
    echo SUCESSO: Tabela criada!
) else (
    echo AVISO: Tabela pode ja existir
)

echo.
echo Aguardando tabela ficar ativa...
aws dynamodb wait table-exists --table-name %TABLE_NAME% --region %AWS_REGION%

echo.
echo ========================================
echo VERIFICACAO FINAL...
echo ========================================

echo Listando buckets S3:
aws s3 ls | findstr %BUCKET_NAME%

echo.
echo Listando tabelas DynamoDB:
aws dynamodb list-tables --region %AWS_REGION% | findstr %TABLE_NAME%

echo.
echo ========================================
echo CONCLUIDO!
echo ========================================
echo.
echo Proximos passos:
echo 1. cd terraform
echo 2. terraform init
echo 3. terraform plan
echo 4. terraform apply
echo.

pause
