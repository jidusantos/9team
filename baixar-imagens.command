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

echo "── NOVOS (lote 8 — Seleções) ───────────"
download 67  9b7ce76c22 jpeg 0
download 67  bac8432729 jpeg 1
report  67  "Egito" jpeg

echo "── NOVOS (lote 9 — Seleções Copa) ───────"
download 68  819168ad52 jpeg 0
download 68  d6f37cec7c jpeg 1
download 68  8524eff6d1 jpeg 2
report  68  "Croácia" jpeg

download 69  37287aeaa2 jpeg 0
download 69  c81a83b0c6 jpeg 1
report  69  "Costa do Marfim" jpeg

download 70  1c9079af jpg 0
download 70  82b3316b jpg 1
report  70  "Austrália" jpg

download 71  cc943b278d jpeg 0
download 71  d9d6df2f99 jpeg 1
download 71  d83bf174be jpeg 2
report  71  "Arábia Saudita" jpeg

download 72  e07d608f jpg 0
download 72  b213f730 jpg 1
report  72  "Tunísia" jpg

download 73  7368a61a jpg 0
download 73  f6a5b6ee jpg 1
report  73  "Costa Rica" jpg

download 74  b65f501801 jpeg 0
download 74  042a4e5a0d jpeg 1
report  74  "Noruega" jpeg

download 75  dcfa13619e jpeg 0
download 75  09c568811b jpeg 1
report  75  "Áustria" jpeg

download 76  96fd54da jpg 0
download 76  f452a460 jpg 1
report  76  "Argélia" jpg

download 77  28894134d9 jpeg 0
download 77  a7bcc5419d jpeg 1
report  77  "África do Sul" jpeg

download 78  522dce3e68 jpeg 0
download 78  a70ffe1fb7 jpeg 1
report  78  "Panamá" jpeg

download 79  6e0e0230e3 jpeg 0
download 79  892141a84b jpeg 1
download 79  70caf9cbd2 jpeg 2
report  79  "Rep. Tcheca" jpeg

echo "── NOVOS (lote 10 — Seleções) ───────"
download 80  1e00175af9 jpeg 0
download 80  30ad38fe53 jpeg 1
report  80  "Curaçao" jpeg

download 81  2d88bc445e jpeg 0
download 81  15170306d7 jpeg 1
report  81  "Iraque" jpeg

download 82  29d7fae0ff jpeg 0
download 82  38995e7f80 jpeg 1
report  82  "Bósnia" jpeg

download 83  8cf0e1715a jpeg 0
download 83  5aa3bd3eff jpeg 1
report  83  "Honduras" jpeg

download 84  920dd37331 jpeg 0
download 84  f5b7c837e4 jpeg 1
report  84  "Escócia" jpeg

download 85  c41a3f9522 jpeg 0
download 85  ef784e4353 jpeg 1
report  85  "Ucrânia" jpeg

echo "── NOVOS (lote 11 — Seleções) ───────"
download 86  d680e953fe jpeg 0
download 86  d3074ad3ec jpeg 1
report  86  "Uzbequistão" jpeg

download 87  8f39435798 jpeg 0
download 87  ef6db51913 jpeg 1
report  87  "El Salvador" jpeg

download 88  f7c3b233f7 jpeg 0
report  88  "Jamaica" jpeg

echo "── NOVOS (lote 12 — Seleções) ───────"
download 89  f5d36713 jpg 0
download 89  6b16b225 jpg 1
report  89  "Paraguai" jpg

download 90  50af41f7 jpg 0
download 90  d3794595 jpg 1
report  90  "Marrocos" jpg

echo "── NOVOS (lote 13 — Seleções) ───────"
download 91  61c8f207 jpg 0
download 91  ae13f4b6 jpg 1
report  91  "Polônia" jpg

download 92  6cec8102 jpg 0
download 92  97a9f5f7 jpg 1
report  92  "Catar" jpg

download 93  8b9bb280 jpg 0
download 93  48a84bb3 jpg 1
report  93  "Nova Zelândia" jpg

echo "── NOVOS (lote 14 — Seleções) ───────"
download 94  68f39107 jpg 0
download 94  e0462d5e jpg 1
report  94  "Suécia" jpg

download 95  ba8ae60a jpg 0
download 95  49bd724e jpg 1
report  95  "Peru" jpg

download 96  e730c9ff jpg 0
download 96  1710f150 jpg 1
report  96  "Venezuela" jpg

download 97  985db3bd jpg 0
download 97  5cdd6c2a jpg 1
report  97  "Hungria" jpg

download 98  3677eea0 jpg 0
download 98  0bdf32df jpg 1
report  98  "Albânia" jpg

download 99  b3595886 jpg 0
download 99  137b9eb5 jpg 1
report  99  "Emirados Árabes" jpg

download 100  c743c49a jpg 0
download 100  bda255ff jpg 1
report  100  "Grécia" jpg

download 101  80c20970 jpg 0
download 101  ab22bd25 jpg 1
report  101  "Palestina" jpg

download 102  c78e4ba2 jpg 0
download 102  667faa8d jpg 1
report  102  "Islândia" jpg

echo "── Flamengo variações (ids 103-105) ──"
download 103  311d946036 jpeg 0
download 103  7a737678d4 jpeg 1
report  103  "Flamengo II" jpeg

download 104  606d2635cf jpeg 0
download 104  9b05853af7 jpeg 1
report  104  "Flamengo III" jpeg

download 105  a02fc344f9 jpeg 0
download 105  3a6aeea1fa jpeg 1
report  105  "Flamengo IV" jpeg

echo "── Flamengo/Corinthians/Fluminense/Palmeiras/SãoPaulo (ids 106-115) ──"
download 106  786f05d9a8 jpeg 0
download 106  e38a065153 jpeg 1
report  106  "Flamengo V" jpeg
download 107  d9d7a53d32 jpeg 0
download 107  8fe31b7c35 jpeg 1
report  107  "Flamengo VI" jpeg
download 108  89926d8a10 jpeg 0
download 108  d38de4ae77 jpeg 1
report  108  "Flamengo VII" jpeg
download 109  2dcd0a2fc2 jpeg 0
download 109  61fe799d59 jpeg 1
report  109  "Corinthians I" jpeg
download 110  99b784f13c jpeg 0
download 110  1061bf3d1a jpeg 1
report  110  "Fluminense I" jpeg
download 111  5b0f9b5f59 jpeg 0
download 111  06d4cd88d8 jpeg 1
report  111  "Fluminense II" jpeg
download 112  fae71e9d44 jpeg 0
download 112  c7aec07e4c jpeg 1
report  112  "Fluminense III" jpeg
download 113  86bf8ceafb jpeg 0
download 113  1834087b2b jpeg 1
report  113  "Fluminense IV" jpeg
download 114  931d3be96f jpeg 0
download 114  87b95092f4 jpeg 1
report  114  "Palmeiras I" jpeg
download 115  f139d31192 jpeg 0
download 115  2cb7a40b6e jpeg 1
report  115  "São Paulo I" jpeg

echo "── ids 116-126 ──"
download 116  f92f76a9ae jpeg 0
download 116  ed48b0ae1f jpeg 1
report  116  "Corinthians II" jpeg
download 117  52117cb958 jpeg 0
download 117  fa6f33c07a jpeg 1
report  117  "Gremio I" jpeg
download 118  bfff7a0624 jpeg 0
download 118  42031cddbb jpeg 1
report  118  "Internacional I" jpeg
download 119  c81c2f345a jpeg 0
download 119  71ff2c5be3 jpeg 1
report  119  "Bahia I" jpeg
download 120  e7acf9818e jpeg 0
download 120  e7d01f67ab jpeg 1
report  120  "Palmeiras II" jpeg
download 121  e36b989f03 jpeg 0
download 121  036ca517c7 jpeg 1
report  121  "Botafogo I" jpeg
download 122  17b822a8b6 jpeg 0
download 122  021141bdbc jpeg 1
report  122  "Internacional II" jpeg
download 123  d8da91403a jpeg 0
download 123  d0b48f3ae4 jpeg 1
report  123  "Atletico Mineiro I" jpeg
download 124  64438a139d jpeg 0
download 124  7afcf623d2 jpeg 1
report  124  "Cruzeiro I" jpeg
download 125  3bb608ac08 jpeg 0
download 125  30c3001680 jpeg 1
report  125  "Gremio II" jpeg
download 126  42911027b7 jpeg 0
download 126  572bfd0798 jpeg 1
report  126  "Internacional III" jpeg
echo "── ids 127-135 ──"
download 127  3c8408318d jpeg 0
report  127  "Athletico Paranaense I" jpeg
download 128  9debfe97f9 jpeg 0
download 128  988b73f07a jpeg 1
report  128  "Cruzeiro II" jpeg
download 129  4711e7859e jpeg 0
download 129  83065f38e3 jpeg 1
report  129  "Cruzeiro III" jpeg
download 130  d33745614a jpeg 0
download 130  eb563e2631 jpeg 1
report  130  "Gremio Player I" jpeg
download 131  728e17021e png 0
download 131  70444c4f7f png 1
report  131  "Santos I" png
download 132  d4b63c0aaf png 0
download 132  845cec265a png 1
report  132  "Santos II" png
download 133  d4d23e5958 png 0
download 133  c591f79ac5 png 1
report  133  "Santos III" png
download 134  8caefa0743 png 0
download 134  e950f7e4cb png 1
report  134  "Santos IV" png
download 135  6e9cd10ef9 jpeg 0
report  135  "Cruzeiro IV" jpeg
echo "── ids 136-139 ──"
download 136  1061bf3d1a jpeg 0
download 136  99b784f13c jpeg 1
report  136  "Fluminense I" jpeg
download 137  e4d6e73d2b jpeg 0
download 137  9f1836b1de jpeg 1
report  137  "Coritiba I" jpeg
download 138  ba2b69430a jpeg 0
download 138  10b687b648 jpeg 1
report  138  "Vitoria I" jpeg
download 139  a8b574e5f0 jpeg 0
download 139  f95ea2f929 jpeg 1
report  139  "Avai I" jpeg
echo "── ids 140-145 ──"
download 140  a4347fdfea jpeg 0
download 140  fbb5dc6fd4 jpeg 1
report  140  "Atletico Mineiro Player I" jpeg
download 141  e5bd537560 jpeg 0
download 141  ba7711166c jpeg 1
report  141  "Atletico Mineiro Player II" jpeg
download 142  487ad47819 jpeg 0
download 142  ca5fe17c78 jpeg 1
report  142  "Sao Paulo Player I" jpeg
download 143  0814da7515 jpeg 0
download 143  312609ba20 jpeg 1
report  143  "Sao Paulo Player II" jpeg
download 144  0bcc10cd3a jpeg 0
download 144  3fb5232ddc jpeg 1
report  144  "Santos V" jpeg
download 145  8896d8b11c jpeg 0
download 145  a598624c6a jpeg 1
report  145  "Santos VI" jpeg
echo "── ids 146-155 ──"
download 146  b3404c30da jpeg 0
download 146  e2da487649 jpeg 1
report  146  "Flamengo Player I" jpeg
download 147  4b2e5e7dc6 jpeg 0
download 147  19cafe3899 jpeg 1
report  147  "Flamengo Player II" jpeg
download 148  8093d615c8 jpeg 0
download 148  547731e8f2 jpeg 1
report  148  "Corinthians Player I" jpeg
download 149  709d7dce08 jpeg 0
download 149  748b21b75b jpeg 1
report  149  "Corinthians Player II" jpeg
download 150  353980693e jpeg 0
download 150  bef67da1e4 jpeg 1
report  150  "Corinthians Player III" jpeg
download 151  7a0f57f6cb jpeg 0
download 151  459ca01df5 jpeg 1
report  151  "Gremio Player I" jpeg
download 152  15abf71eb6 jpeg 0
download 152  b797946b54 jpeg 1
report  152  "Gremio Player II" jpeg
download 153  0d8f5ad67a jpeg 0
download 153  308113e774 jpeg 1
report  153  "Palmeiras I" jpeg
download 154  931d3be96f jpeg 0
download 154  87b95092f4 jpeg 1
report  154  "Palmeiras II" jpeg
download 155  6957aa8a8d jpeg 0
download 155  019e27a082 jpeg 1
report  155  "Bahia I" jpeg
echo "── ids 156-161 ──"
download 156  5921ad64aa jpeg 0
download 156  d8adfd3087 jpeg 1
report  156  "Palmeiras III" jpeg
download 157  85370b7239 jpeg 0
download 157  52bf2a77a3 jpeg 1
report  157  "Palmeiras IV" jpeg
download 158  49c5d1e908 jpeg 0
download 158  076d6da630 jpeg 1
report  158  "Sao Paulo II" jpeg
download 159  791d101bc7 jpeg 0
download 159  58dacec80d jpeg 1
report  159  "Sao Paulo III" jpeg
download 160  b20c9568ad jpeg 0
download 160  d4d2505add jpeg 1
report  160  "Santos VII" jpeg
download 161  c7395f5c22 jpeg 0
download 161  b60f628b19 jpeg 1
report  161  "Santos Player I" jpeg
echo "── ids 162-168 ──"
download 162  97878cd9c6 jpeg 0
download 162  1995fb426d jpeg 1
report  162  "Sport Recife I" jpeg
download 163  92d78b8fae jpeg 0
download 163  89f0141143 jpeg 1
report  163  "Sport Recife II" jpeg
download 164  38425c94 jpg 0
download 164  502bcce9 jpg 1
report  164  "Vasco da Gama I" jpg
download 165  bf914a57 jpg 0
download 165  0d645cdd jpg 1
report  165  "Vasco da Gama II" jpg
download 166  c6b45119 jpg 0
download 166  1d147ac4 jpg 1
report  166  "Remo I" jpg
download 167  5cf66aa5bf jpeg 0
download 167  25d042b829 jpeg 1
report  167  "Santa Cruz I" jpeg
download 168  b1e06212 jpg 0
download 168  b882f78c jpg 1
report  168  "Ceara I" jpg
download 169  bdb2d1a7 jpg 0
download 169  986d2289 jpg 1
report  169  "Atletico Mineiro I" jpg
download 170  1a7f9482 jpg 0
download 170  30563871 jpg 1
report  170  "Atletico Mineiro II" jpg
download 171  48f013b0 jpg 0
download 171  659f377a jpg 1
report  171  "Atletico Mineiro III" jpg
download 172  cc65110f jpg 0
download 172  2e424ba0 jpg 1
report  172  "Vitoria II" jpg
download 173  e7dd71b5 jpg 0
download 173  adee04e5 jpg 1
report  173  "Atletico Mineiro IV" jpg
download 174  802a5231 jpg 0
download 174  b7d94afa jpg 1
report  174  "Atletico Mineiro V" jpg
download 175  fe6fa1a3 jpg 0
download 175  e077718a jpg 1
report  175  "Internacional IV" jpg
download 176  62ab94eb jpg 0
download 176  8e5f31c0 jpg 1
report  176  "Sao Paulo IV" jpg
download 177  bcc4f551 jpg 0
download 177  d8eaaeeb jpg 1
report  177  "Athletico Paranaense I" jpg
download 178  c6b45119 jpg 0
download 178  1d147ac4 jpg 1
report  178  "Remo II" jpg
download 179  1e3bbbdc jpg 0
download 179  6e484149 jpg 1
report  179  "Palmeiras III" jpg
download 180  ab62cf3f jpg 0
download 180  c49ac161 jpg 1
report  180  "Athletico Paranaense II" jpg
download 181  c42fa974 jpg 0
download 181  07ffff8b jpg 1
report  181  "Cruzeiro I" jpg
download 182  849dcd2f jpg 0
download 182  6b62470b jpg 1
report  182  "Cruzeiro II" jpg
download 183  527dd7b9 jpg 0
download 183  1667892b jpg 1
report  183  "Paysandu I" jpg
download 184  90d7f9d0 jpg 0
download 184  69806cda jpg 1
report  184  "Bahia II" jpg
download 185  ebf33db3 jpg 0
download 185  4bf8b26a jpg 1
report  185  "Internacional V" jpg
download 186  128ddd12 jpg 0
download 186  edfd7d5f jpg 1
report  186  "Internacional VI" jpg
download 187  2f86931d jpg 0
download 187  9ea82a03 jpg 1
report  187  "Vasco III" jpg
download 188  c6fa6745 jpg 0
download 188  578f5467 jpg 1
report  188  "Corinthians III" jpg
download 189  82aad3e0 jpg 0
download 189  7af32d49 jpg 1
report  189  "Corinthians IV" jpg
download 190  60ea7304 jpg 0
download 190  afb6547c jpg 1
report  190  "Bahia III" jpg
download 191  e8b3406c jpg 0
download 191  6da5894e jpg 1
report  191  "Bahia IV" jpg
download 192  22ea2f7a jpg 0
download 192  626a934b jpg 1
report  192  "Internacional VII" jpg
download 193  3bb7e937 jpg 0
download 193  00d630c8 jpg 1
report  193  "Cruzeiro V" jpg
download 194  39187f7c jpg 0
download 194  e514c011 jpg 1
report  194  "Corinthians V" jpg
download 195  2a051084 jpg 0
download 195  a53dae2c jpg 1
report  195  "Bahia V" jpg
download 196  d5f68beb jpg 0
download 196  6ecf68b8 jpg 1
report  196  "Bahia VI" jpg
download 197  8b76df89 jpg 0
download 197  5b865887 jpg 1
report  197  "Cruzeiro VI" jpg
download 198  d65a8244aa jpeg 0
download 198  6a49829e1c jpeg 1
report  198  "Bahia VII" jpeg
download 199  087560ed77 jpeg 0
download 199  f42a3682be jpeg 1
report  199  "Santa Cruz II" jpeg
download 200  9836f25b jpg 0
download 200  8b78d735 jpg 1
report  200  "Grêmio III" jpg
download 201  4413a706 jpg 0
download 201  8034696b jpg 1
report  201  "Atlético Mineiro VI" jpg
download 202  03b691d8 jpg 0
download 202  e8af85a1 jpg 1
report  202  "Atlético Mineiro VII" jpg
download 203  2f7fb792 jpg 0
download 203  b1dda4e4 jpg 1
report  203  "Fluminense V" jpg
download 204  c547d5c69f jpeg 0
download 204  63e71459ba jpeg 1
report  204  "Corinthians VI" jpeg
download 205  010e09f0 jpg 0
download 205  009597a1 jpg 1
report  205  "Flamengo VIII" jpg

echo ""
COUNT=$(ls imgs/*.jpeg imgs/*.jpg imgs/*.png 2>/dev/null | wc -l | tr -d ' ')
echo "✅ Concluído! $COUNT imagens em imgs/"
echo ""
echo "Pressione Enter para fechar..."
read
