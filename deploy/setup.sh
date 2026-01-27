#!/bin/bash
# ============================================================
# Script de Setup - GLPI DETRAN Ceará
# ============================================================
# Execute este script NO SERVIDOR antes do primeiro deploy
# Uso: curl -sSL <url_do_script> | bash
# Ou:  ./setup.sh
# ============================================================

set -e

echo "=============================================="
echo "  GLPI DETRAN Ceará - Setup Inicial"
echo "=============================================="

# Diretório base
BASE_DIR="/opt/docker/volumes/glpi"

# Criar estrutura de diretórios
echo "[1/4] Criando diretórios..."
mkdir -p ${BASE_DIR}/database
mkdir -p ${BASE_DIR}/config
mkdir -p ${BASE_DIR}/files
mkdir -p ${BASE_DIR}/marketplace
mkdir -p ${BASE_DIR}/theme/css/palettes
mkdir -p ${BASE_DIR}/theme/pics/logos

# Baixar arquivos do tema
echo "[2/4] Baixando arquivos do tema DETRAN Ceará..."

# CSS Principal
curl -sSL -o ${BASE_DIR}/theme/css/core_palettes.scss \
  "https://raw.githubusercontent.com/andersonfas/glpi/claude/glpi-detran-ceara-branding-qCddm/deploy/theme/css/core_palettes.scss"

# Paleta DETRAN
curl -sSL -o ${BASE_DIR}/theme/css/palettes/_detran_ceara.scss \
  "https://raw.githubusercontent.com/andersonfas/glpi/claude/glpi-detran-ceara-branding-qCddm/deploy/theme/css/palettes/_detran_ceara.scss"

# Logos
echo "[3/4] Baixando logos oficiais..."
curl -sSL -o ${BASE_DIR}/theme/pics/logos/logomarca_detran_01.png \
  "https://raw.githubusercontent.com/andersonfas/glpi/11.0/bugfixes/public/pics/logos/logomarca_detran_01.png"

curl -sSL -o ${BASE_DIR}/theme/pics/logos/logomarca_detran_02.png \
  "https://raw.githubusercontent.com/andersonfas/glpi/11.0/bugfixes/public/pics/logos/logomarca_detran_02.png"

# Ajustar permissões
echo "[4/4] Ajustando permissões..."
chmod -R 755 ${BASE_DIR}
chmod 644 ${BASE_DIR}/theme/css/*.scss
chmod 644 ${BASE_DIR}/theme/css/palettes/*.scss
chmod 644 ${BASE_DIR}/theme/pics/logos/*.png

# Verificar
echo ""
echo "=============================================="
echo "  Setup concluído!"
echo "=============================================="
echo ""
echo "Estrutura criada em: ${BASE_DIR}"
echo ""
ls -la ${BASE_DIR}/
echo ""
echo "Arquivos do tema:"
ls -la ${BASE_DIR}/theme/css/
ls -la ${BASE_DIR}/theme/css/palettes/
ls -la ${BASE_DIR}/theme/pics/logos/
echo ""
echo "Próximo passo: Faça o deploy no Dokploy"
echo "=============================================="
