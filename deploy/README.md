# GLPI - DETRAN Ceará

Deploy do GLPI com tema personalizado do DETRAN Ceará.

## Estrutura

```
deploy/
├── docker-compose.yml      # Configuração dos containers
├── .env.example            # Variáveis de ambiente (exemplo)
├── README.md               # Este arquivo
└── theme/                  # Tema DETRAN Ceará
    ├── css/
    │   ├── core_palettes.scss
    │   └── palettes/
    │       └── _detran_ceara.scss
    └── pics/
        └── logos/
            ├── logomarca_detran_01.png  # Logo login (2560x1440)
            └── logomarca_detran_02.png  # Logo menu (1280x1379)
```

## Deploy via Dokploy

### 1. Criar aplicação no Dokploy

1. Acesse o painel do Dokploy
2. Clique em **"Create Project"** (ou use um existente)
3. Clique em **"Add Service"** → **"Docker Compose"**
4. Configure:
   - **Name**: `glpi-detran`
   - **Source**: GitHub
   - **Repository**: `andersonfas/glpi`
   - **Branch**: `claude/glpi-detran-ceara-branding-qCddm` (ou o branch de produção)
   - **Compose Path**: `deploy/docker-compose.yml`

### 2. Configurar variáveis de ambiente

No Dokploy, vá em **Environment** e adicione:

```env
MARIADB_TAG=11.4
GLPI_TAG=latest
GLPI_PORT=8095
TIMEZONE=America/Fortaleza
DB_HOST=glpi-db
DB_NAME=glpi
DB_USER=glpi
DB_PASS=SuaSenhaSegura123!
DB_ROOT_PASS=SenhaRootSegura456!
```

⚠️ **IMPORTANTE**: Use senhas fortes e diferentes do exemplo!

### 3. Configurar domínio (opcional)

No Dokploy, vá em **Domains** e configure:
- **Domain**: `glpi.seudominio.com.br`
- **HTTPS**: Ativado (Let's Encrypt)

### 4. Deploy

Clique em **"Deploy"** e aguarde os containers subirem.

## Ativar o Tema DETRAN Ceará

1. Acesse o GLPI: `http://seu-servidor:8095`
2. Faça login com usuário administrador
3. Vá em **Preferências** (canto superior direito)
4. Em **Personalização**, selecione: **"detran_ceara"**
5. Clique em **Salvar**

## Cores do Tema

| Elemento | Cor | Hex |
|----------|-----|-----|
| Menu principal | Amarelo | `#FFE500` |
| Texto do menu | Preto | `#2D3436` |
| Links/destaques | Verde Ceará | `#006847` |

## Backup

Os dados são persistidos em volumes Docker:

| Volume | Conteúdo |
|--------|----------|
| `glpi_database` | Banco de dados MariaDB |
| `glpi_config` | Configurações do GLPI |
| `glpi_files` | Arquivos/uploads |
| `glpi_marketplace` | Plugins instalados |

### Fazer backup manual

```bash
# Backup do banco
docker exec glpi-db mysqldump -u root -p glpi > backup_glpi_$(date +%Y%m%d).sql

# Backup dos volumes
docker run --rm -v glpi_files:/data -v $(pwd):/backup alpine tar czf /backup/glpi_files_$(date +%Y%m%d).tar.gz /data
```

## Atualização

Para atualizar o GLPI ou o tema:

1. No Dokploy, vá em **Deployments**
2. Clique em **"Redeploy"**

Os dados serão mantidos pois estão em volumes persistentes.

## Troubleshooting

### Tema não aparece

```bash
# Verificar se os arquivos estão montados
docker exec glpi-app ls -la /var/www/html/glpi/css/palettes/_detran_ceara.scss
docker exec glpi-app cat /var/www/html/glpi/css/core_palettes.scss | grep detran
```

### Limpar cache do GLPI

```bash
docker exec glpi-app rm -rf /var/www/html/glpi/files/_cache/*
```

### Logs

```bash
docker logs glpi-app
docker logs glpi-db
```
