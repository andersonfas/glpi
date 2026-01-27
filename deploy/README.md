# GLPI - DETRAN Ceará

Deploy do GLPI com tema personalizado do DETRAN Ceará.

## Arquitetura de Persistência

```
/opt/docker/volumes/glpi/
├── database/          ← Banco de dados MariaDB
├── config/            ← Configurações do GLPI
├── files/             ← Arquivos/uploads
├── marketplace/       ← Plugins instalados
└── theme/             ← Tema DETRAN Ceará
    ├── css/
    │   ├── core_palettes.scss
    │   └── palettes/
    │       └── _detran_ceara.scss
    └── pics/logos/
        ├── logomarca_detran_01.png
        └── logomarca_detran_02.png
```

## Segurança dos Dados

| Ação | Dados | Status |
|------|-------|--------|
| `docker system prune -af` | `/opt/docker/volumes/glpi/` | ✅ **SEGURO** |
| `docker-compose down` | `/opt/docker/volumes/glpi/` | ✅ **SEGURO** |
| Redeploy no Dokploy | `/opt/docker/volumes/glpi/` | ✅ **SEGURO** |
| Atualizar versão GLPI | `/opt/docker/volumes/glpi/` | ✅ **SEGURO** |
| `rm -rf /opt/docker/volumes/glpi/` | Dados | ❌ **PERDIDOS** |

## Setup Inicial (EXECUTAR APENAS UMA VEZ)

No servidor de deploy, execute:

```bash
# Opção 1: Via curl (recomendado)
curl -sSL https://raw.githubusercontent.com/andersonfas/glpi/claude/glpi-detran-ceara-branding-qCddm/deploy/setup.sh | bash

# Opção 2: Manualmente
mkdir -p /opt/docker/volumes/glpi/{database,config,files,marketplace}
mkdir -p /opt/docker/volumes/glpi/theme/css/palettes
mkdir -p /opt/docker/volumes/glpi/theme/pics/logos

# Baixar tema
curl -sSL -o /opt/docker/volumes/glpi/theme/css/core_palettes.scss \
  "https://raw.githubusercontent.com/andersonfas/glpi/claude/glpi-detran-ceara-branding-qCddm/deploy/theme/css/core_palettes.scss"

curl -sSL -o /opt/docker/volumes/glpi/theme/css/palettes/_detran_ceara.scss \
  "https://raw.githubusercontent.com/andersonfas/glpi/claude/glpi-detran-ceara-branding-qCddm/deploy/theme/css/palettes/_detran_ceara.scss"

# Baixar logos
curl -sSL -o /opt/docker/volumes/glpi/theme/pics/logos/logomarca_detran_01.png \
  "https://raw.githubusercontent.com/andersonfas/glpi/11.0/bugfixes/public/pics/logos/logomarca_detran_01.png"

curl -sSL -o /opt/docker/volumes/glpi/theme/pics/logos/logomarca_detran_02.png \
  "https://raw.githubusercontent.com/andersonfas/glpi/11.0/bugfixes/public/pics/logos/logomarca_detran_02.png"
```

## Deploy via Dokploy

### 1. Configurar no Dokploy

| Campo | Valor |
|-------|-------|
| Provider | GitLab |
| Repository | glpi |
| Branch | `claude/glpi-detran-ceara-branding-qCddm` |
| Compose Path | `deploy/docker-compose.yml` |

### 2. Variáveis de Ambiente

```env
# Versões
MARIADB_TAG=10.11
GLPI_TAG=latest
GLPI_PORT=8095

# Banco de dados
DB_HOST=glpi-db
DB_NAME=glpidb
DB_USER=glpi_user
DB_PASS=SuaSenhaSegura!
DB_ROOT_PASS=SuaSenhaRootSegura!

# Geral
TIMEZONE=America/Fortaleza
GLPI_INSTALL_MODE=NO
```

### 3. Deploy

Clique em **Deploy** no Dokploy.

## Ativar Tema DETRAN Ceará

1. Acesse o GLPI
2. Vá em **Preferências** (canto superior direito)
3. Na aba **Personalização**
4. Em **Paleta de cores**, selecione **"detran_ceara"**
5. Salve

## Backup

```bash
# Backup completo
tar -czvf backup_glpi_$(date +%Y%m%d).tar.gz /opt/docker/volumes/glpi/

# Restaurar
tar -xzvf backup_glpi_YYYYMMDD.tar.gz -C /
```

## Atualização de Versão

Para atualizar o GLPI:

1. Altere `GLPI_TAG` no Dokploy (ex: `10.0.16` para `10.0.17`)
2. Clique em **Redeploy**
3. Os dados são mantidos automaticamente

## Cores do Tema

| Elemento | Cor | Hex |
|----------|-----|-----|
| Menu principal | Amarelo DETRAN | `#FFE500` |
| Texto do menu | Preto | `#2D3436` |
| Links/destaques | Verde Ceará | `#006847` |
