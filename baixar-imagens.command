#!/bin/bash
cd "$(dirname "$0")"
mkdir -p imgs

echo "🏃 Baixando imagens dos produtos 9TEAM..."
echo "   Cada produto tem fotos frente e verso."
echo ""

# download id imgid ext fotoIndex
# fotoIndex 0 = capa do card (nome: ID.ext) + galeria ID_0.ext
# fotoIndex 1+ = fotos extras na galeria (nome: ID_1.ext, ID_2.ext, ...)
download() {
  local id=$1 imgid=$2 ext=$3 idx=${4:-0}
  local file
  if [ "$idx" -eq 0 ]; then
    file="imgs/${id}.${ext}"
  fi
  local file_gallery="imgs/${id}_${idx}.${ext}"

  local url="https://photo.yupoo.com/194939/${imgid}/medium.${ext}"

  for target in "$file_gallery" ${file:+"$file"}; do
    if [ -f "$target" ] && [ "$(stat -f%z "$target" 2>/dev/null || stat -c%s "$target")" -gt 5000 ]; then
      continue
    fi
    curl -s -L \
      -H "Referer: https://194939.x.yupoo.com/" \
      -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
      -o "$target" "$url"
    local size=$(stat -f%z "$target" 2>/dev/null || stat -c%s "$target" 2>/dev/null || echo 0)
    if [ "$size" -lt 5000 ]; then
      echo "  ❌ $target — falhou"
      rm -f "$target"
    fi
  done
}

report() {
  local id=$1 name=$2 ext=$3
  local file="imgs/${id}.${ext}"
  if [ -f "$file" ]; then
    echo "  ✅ #${id} ${name}"
  else
    echo "  ⚠️  #${id} ${name} — não baixado"
  fi
}

echo "── Série A ─────────────────────────────"
download  1  301c46b24b jpeg 0
download  1  e91137c6e1 jpeg 1
report  1  "Flamengo" jpeg

download  2  6e19381355 jpeg 0
download  2  e37b2dd9bd jpeg 1
report  2  "Palmeiras" jpeg

download  3  c6556b1b1f jpeg 0
download  3  d972416559 jpeg 1
download  3  c3ce20def4 jpeg 2
download  3  643a94f7d6 jpeg 3
download  3  2c4bfe6006 jpeg 4
report  3  "Corinthians" jpeg

download  4  04835350db jpeg 0
download  4  3ff15157f8 jpeg 1
report  4  "Fluminense" jpeg

download  5  f7fffb1075 jpeg 0
report  5  "Cruzeiro" jpeg

download 48  728e17021e png  0
download 48  70444c4f7f png  1
download 48  d4b63c0aaf png  2
download 48  845cec265a png  3
download 48  d4d23e5958 png  4
download 48  c591f79ac5 png  5
download 48  8caefa0743 png  6
download 48  e950f7e4cb png  7
report 48  "Santos" png

download 49  de87b48586 jpeg 0
report 49  "Internacional" jpeg

download 50  d8da91403a jpeg 0
download 50  d0b48f3ae4 jpeg 1
report 50  "Atlético Mineiro" jpeg

download 51  d33745614a jpeg 0
download 51  eb563e2631 jpeg 1
report 51  "Grêmio" jpeg

echo "── Premier League ──────────────────────"
download  6  97118c90c7 jpeg 0
download  6  ff4986828c jpeg 1
report  6  "Manchester United" jpeg

download  7  cd1fb95d71 jpeg 0
download  7  0cf2203025 jpeg 1
report  7  "Arsenal" jpeg

download  8  1f385c76ca jpeg 0
download  8  d38398c952 jpeg 1
report  8  "Chelsea" jpeg

download  9  6dbcb88a00 jpeg 0
download  9  11ae7b94a9 jpeg 1
report  9  "Manchester City" jpeg

download 10  4c14f16d72 jpeg 0
download 10  1fc7355e60 jpeg 1
report 10  "Tottenham" jpeg

echo "── La Liga ─────────────────────────────"
download 11  4453504a05 jpeg 0
download 11  cf4611f649 jpeg 1
report 11  "Real Madrid" jpeg

download 12  f55129ba08 jpeg 0
download 12  a68d368677 jpeg 1
download 12  31104a0b59 jpeg 2
download 12  865575624f jpeg 3
report 12  "Barcelona" jpeg

download 36  741994ed   jpg  0
download 36  ce841501   jpg  1
report 36  "Atlético Madrid" jpg

download 37  92a363f08b jpeg 0
download 37  0f9e3458e7 jpeg 1
report 37  "Sevilla" jpeg

download 38  1896c7ff1f jpeg 0
download 38  9b15d8513c jpeg 1
report 38  "Valencia" jpeg

echo "── Bundesliga ──────────────────────────"
download 13  758df2ad35 jpeg 0
download 13  ed0284d3f4 jpeg 1
report 13  "Bayern Munich" jpeg

download 14  b64af9da69 jpeg 0
download 14  2289612cb0 jpeg 1
report 14  "Borussia Dortmund" jpeg

download 42  45b1c92af0 jpeg 0
download 42  49e339eb90 jpeg 1
report 42  "Frankfurt" jpeg

download 43  fe6ec6a73f jpeg 0
download 43  5f7243d68f jpeg 1
report 43  "Schalke 04" jpeg

echo "── Serie A Italiana ────────────────────"
download 16  ce3b69c0   jpg  0
download 16  a8a1f9f7   jpg  1
report 16  "Inter Milan" jpg

download 17  efef4b5e   jpg  0
download 17  0eff18c9   jpg  1
report 17  "Napoli" jpg

download 18  09385a32   jpg  0
download 18  47dc0a87   jpg  1
report 18  "AC Milan" jpg

download 44  4f14331d   jpg  0
report 44  "Roma" jpg

download 45  5da5fb78   jpeg 0
download 45  48f1fc61   jpeg 1
report 45  "Lazio" jpeg

download 46  c4eba399   jpg  0
download 46  df74a635   jpg  1
report 46  "Fiorentina" jpg

download 47  3c8a0938   jpeg 0
download 47  3bdf5f40   jpeg 1
report 47  "Atalanta" jpeg

echo "── Ligue 1 ─────────────────────────────"
download 15  ca571a5415 jpeg 0
download 15  911b9b8506 jpeg 1
report 15  "PSG" jpeg

download 39  c2679c7c   jpg  0
download 39  f21fd5fd   jpg  1
report 39  "Lyon" jpg

download 40  f81aadbd   jpg  0
download 40  0d9995ca   jpg  1
report 40  "Marseille" jpg

download 41  7ace2d71   jpeg 0
download 41  f462842b   jpeg 1
report 41  "Monaco" jpeg

echo "── Seleções ────────────────────────────"
download 19  d49dc8ad41 jpeg 0
download 19  36cac3af7e jpeg 1
download 19  c1c61ca42f jpeg 2
report 19  "Brasil" jpeg

download 20  097ca50662 jpeg 0
download 20  a68ff0f383 jpeg 1
download 20  db2c881091 jpeg 2
download 20  265c1621bc jpeg 3
download 20  2921e44142 jpeg 4
report 20  "Argentina" jpeg

download 21  884a641817 jpeg 0
download 21  e3c9fc660b jpeg 1
report 21  "França" jpeg

download 22  ffae7515d9 jpeg 0
download 22  bafec2b787 jpeg 1
report 22  "Portugal" jpeg

download 27  c3d2f15ca5 jpeg 0
download 27  2bd8329024 jpeg 1
report 27  "Inglaterra" jpeg

download 28  d1a8773900 jpeg 0
download 28  f06d93abda jpeg 1
report 28  "Alemanha" jpeg

download 29  50fa0bfe3c jpeg 0
download 29  25874d1123 jpeg 1
report 29  "Holanda" jpeg

download 30  b35a7fddcc jpeg 0
download 30  124bfef818 jpeg 1
report 30  "Itália" jpeg

download 31  ac0a314df8 jpeg 0
download 31  fb3c56d639 jpeg 1
download 31  a959f479e9 jpeg 2
download 31  f1d5f90b74 jpeg 3
download 31  03d68436f7 jpeg 4
report 31  "Espanha" jpeg

download 32  e0e5aca979 jpeg 0
download 32  5da38f5dfe jpeg 1
report 32  "Coreia do Sul" jpeg

download 33  2b9b0fd7e0 jpeg 0
download 33  17c439a7ca jpeg 1
report 33  "Japão" jpeg

download 34  4be5325162 jpeg 0
download 34  0488688737 jpeg 1
download 34  87ae7cac3f jpeg 2
report 34  "México" jpeg

download 35  17bc4a0ae4 jpeg 0
download 35  8dbabfbf5f jpeg 1
report 35  "Estados Unidos" jpeg

echo "── Retrô ───────────────────────────────"
download 23  3bdd762ab0 png  0
report 23  "Barcelona Retrô" png

download 24  02dc33646b jpeg 0
report 24  "Man. United Retrô" jpeg

echo "── Kids & Kits ─────────────────────────"
download 25  8cdaf5ef   jpeg 0
report 25  "Camiseta Infantil" jpeg

download 26  85d0a0c6   jpeg 0
report 26  "Windbreaker" jpeg


echo "── NOVOS (lote 1) ──────────────────────"
download 52  e36b989f03 jpeg 0
download 52  036ca517c7 jpeg 1
report  52  "Botafogo" jpeg

download 53  c81c2f345a jpeg 0
download 53  71ff2c5be3 jpeg 1
report  53  "Bahia" jpeg

echo "── NOVOS (lote 2) ──────────────────────"
download 54  94198d7e52 jpeg 0
download 54  0dfd79d85b jpeg 1
download 54  edaefe16fa jpeg 2
download 54  386483d170 jpeg 3
report  54  "São Paulo" jpeg

download 55  ba2b69430a jpeg 0
download 55  10b687b648 jpeg 1
report  55  "Vitória" jpeg

download 56  3c8408318d jpeg 0
report  56  "Athletico Paranaense" jpeg

echo "── NOVOS (lote 3) ──────────────────────"
download 57  cf9b3906 jpg 0
download 57  2a908aed jpg 1
report  57  "Vasco da Gama" jpg

download 58  97878cd9c6 jpeg 0
download 58  1995fb426d jpeg 1
report  58  "Sport Recife" jpeg

echo "── NOVOS (lote 4 — Seleções) ───────────"
download 59  cd4f94a07e jpeg 0
download 59  d299747c9c jpeg 1
report  59  "Colômbia" jpeg

download 60  b0615303ae jpeg 0
download 60  5d61ad94c6 jpeg 1
report  60  "Canadá" jpeg

echo "── NOVOS (lote 5 — Seleções) ───────────"
download 61  9543b047b9 jpeg 0
download 61  678b43c4b3 jpeg 1
report  61  "Gana" jpeg

download 62  36a402496c jpeg 0
download 62  ecf73d0b44 jpeg 1
report  62  "Cabo Verde" jpeg

download 63  21bd44b6f5 png 0
download 63  82a9395768 png 1
report  63  "Jordânia" png

echo "── NOVOS (lote 6 — Seleções) ───────────"
download 64  23b6de5a85 jpeg 0
download 64  7d30c28fa7 jpeg 1
report  64  "Senegal" jpeg

download 65  f097f15e jpg 0
download 65  e401b783 jpg 1
report  65  "Equador" jpg

echo "── NOVOS (lote 7 — Seleções) ───────────"
download 66  da986400a1 jpeg 0
download 66  6024de4f6f jpeg 1
report  66  "Nigéria" jpeg

echo ""
COUNT=$(ls imgs/*.jpeg imgs/*.jpg imgs/*.png 2>/dev/null | wc -l | tr -d ' ')
echo "✅ Concluído! $COUNT imagens em imgs/"
echo ""
echo "Pressione Enter para fechar..."
read
