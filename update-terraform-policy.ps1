# Caminho do arquivo JSON da nova politica
$PolicyFile = "terraform-eks-alb-policy.json"
$PolicyName = "TerraformEKSALBPolicy"

# 1 Obter o ARN da politica pelo nome
Write-Host "Obtendo ARN da politica $PolicyName"
$PolicyArn = (aws iam list-policies --query "Policies[?PolicyName=='$PolicyName'].Arn" --output text)

if (-not $PolicyArn) {
    Write-Host "Politica $PolicyName nao encontrada Verifique o nome ou crie a primeiro" -ForegroundColor Red
    exit 1
}

Write-Host "ARN encontrado $PolicyArn"

# 2 Criar nova versao da politica
Write-Host "Criando nova versao da politica"
$CreateResult = aws iam create-policy-version `
    --policy-arn $PolicyArn `
    --policy-document file://$PolicyFile `
    --set-as-default

if ($LASTEXITCODE -ne 0) {
    Write-Host "Erro ao criar nova versao da politica" -ForegroundColor Red
    exit 1
}

Write-Host "Nova versao criada e definida como padrao"

# 3 Limpar versoes antigas se houver mais de 4 IAM permite no maximo 5
Write-Host "Verificando versoes antigas"
$Versions = aws iam list-policy-versions --policy-arn $PolicyArn --query "Versions" | ConvertFrom-Json

if ($Versions.Count -ge 5) {
    $OldVersions = $Versions | Where-Object { $_.IsDefaultVersion -eq $false } | Sort-Object CreateDate | Select-Object -First ($Versions.Count - 4)
    
    foreach ($Version in $OldVersions) {
        $VersionId = $Version.VersionId
        Write-Host "Removendo versao antiga $VersionId"
        aws iam delete-policy-version --policy-arn $PolicyArn --version-id $VersionId
    }

    Write-Host "Versoes antigas limpas"
}
else {
    Write-Host "Nenhuma limpeza necessaria menos de 5 versoes"
}

Write-Host "Politica $PolicyName atualizada com sucesso"
