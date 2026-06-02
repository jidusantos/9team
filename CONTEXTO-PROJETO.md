# 9TEAM — Contexto Completo do Projeto

## O que é o projeto
Loja online de camisetas de futebol premium chamada **9TEAM**. É um site estático em HTML puro (sem backend), hospedado em servidor de hospedagem compartilhada. O fornecedor das imagens é o **Yupoo** (rede chinesa de álbuns de foto).

---

## Arquivos do projeto
Todos os arquivos ficam na mesma pasta na hospedagem e localmente em:
`/Users/tarcisiosantos/Documents/Claude/Projects/9 Team/`

| Arquivo | Função |
|---|---|
| `catalogo-9team.html` | Catálogo público da loja (página principal) |
| `admin.html` | Painel administrativo com login |
| `baixar-imagens.command` | Script bash para baixar imagens do Yupoo localmente |
| `imgs/` | Pasta com imagens locais (fallback caso Yupoo não carregue) |

---

## Catálogo (`catalogo-9team.html`)

### Visual
- Tema escuro: preto (`#111827`), azul (`#3B6EF0`), roxo (`#9B4FD8`)
- Fontes: Oswald + Barlow Condensed (Google Fonts)
- Grid responsivo de cards de produtos
- Modal de detalhe com galeria de fotos (frente + verso)
- Filtro por categoria + busca por texto
- Bilíngue: Português / Inglês (toggle no header)
- Botão de compra abre Instagram Direct

### Produtos hardcoded no array `const P = [...]`
51 produtos organizados em categorias:
- **Série A**: Flamengo, Palmeiras, Corinthians, Fluminense, Cruzeiro, Santos, Internacional, Atlético Mineiro, Grêmio
- **Premier League**: Manchester United, Arsenal, Chelsea, Manchester City, Tottenham
- **La Liga**: Real Madrid, Barcelona, Atlético Madrid, Sevilla, Valencia
- **Bundesliga**: Bayern de Munique, Borussia Dortmund, Eintracht Frankfurt, Schalke 04
- **Serie A Italiana**: Inter de Milão, Napoli, AC Milan, Roma, Lazio, Fiorentina, Atalanta
- **Ligue 1**: PSG, Lyon, Marseille, Monaco
- **Seleções**: Brasil, Argentina, França, Portugal, Inglaterra, Alemanha, Holanda, Itália, Espanha, Coreia do Sul, Japão, México, Estados Unidos
- **Retrô**: Barcelona Retrô, Manchester United Retrô
- **Kids**: Camiseta Infantil
- **Kits**: Agasalho Windbreaker

### Estrutura de cada produto no array P
```js
{
  id: 1,                    // ID único (número)
  name: 'Flamengo',         // Nome em português
  nameen: 'Flamengo',       // Nome em inglês
  sub: 'Camisa Premium 2025',   // Descrição PT
  suben: 'Premium Jersey 2025', // Descrição EN
  cat: 'times',             // Categoria: times | selecoes | retro | kids | kits
  feat: true,               // Destaque na vitrine (boolean)
  league: 'Série A',        // Liga/grupo
  imgs: [
    { i: '301c46b24b', e: 'jpeg' }, // foto 1 (capa)
    { i: 'e91137c6e1', e: 'jpeg' }, // foto 2
  ]
}
```

### Formato das imagens Yupoo
- URL base: `https://photo.yupoo.com/194939/{ID}/medium.{EXT}`
- Conta Yupoo: `194939` (fixo para todos os produtos)
- IDs são strings hexadecimais (ex: `301c46b24b`)
- Extensões: `jpeg`, `jpg`, `png`
- Fallback local: `imgs/{produtoId}.{ext}` (capa) e `imgs/{produtoId}_{fotoIndex}.{ext}` (galeria)

### Produtos novos do admin
O catálogo tem um bloco que carrega produtos NOVOS do localStorage (apenas IDs que não existem no array base):
```js
(function loadNewAdminProducts(){
  // lê nineTeamOverrides do localStorage
  // só adiciona produtos com IDs novos (não edita os existentes)
  // resolve imagens: {local:key} → busca base64 em nineTeamImages
})();
```
Isso significa: edições em produtos existentes feitas no admin NÃO aparecem no catálogo. Só produtos completamente novos aparecem.

### Funções de imagem (suportam 3 formatos)
```js
function cdnUrl(ph){
  if(ph.url) return ph.url;       // URL direta ou base64
  return `https://photo.yupoo.com/194939/${ph.i}/medium.${ph.e}`;
}
```

---

## Admin (`admin.html`)

### Login
- URL de acesso: `seusite.com/admin.html`
- Senha: **2026**
- Variável no código: `const PWD = '2026';`
- Sessão guardada em `sessionStorage.setItem('adminOk','1')`

### Funcionalidades
- Listar todos os produtos (base + novos)
- Criar novo produto
- Editar: nome PT/EN, descrição PT/EN (textarea), liga, categoria, destaque
- Adicionar fotos de **2 formas**:
  1. **Upload do PC**: arraste ou selecione arquivos — converte para base64 comprimida (max 900px, JPEG 82%) e salva em localStorage
  2. **URL / Yupoo ID**: cole URL completa ou só o ID do Yupoo
- Reordenar fotos com botões ◀ ▶
- Remover fotos individualmente
- Restaurar produto ao original (↩)
- Exportar overrides como JSON (`⬇ Exportar`)
- Botão "Ver Catálogo" abre catalogo-9team.html

### localStorage — chaves usadas
| Chave | Conteúdo |
|---|---|
| `nineTeamOverrides` | `{ [id]: {...produtoCompleto} }` — todos os produtos editados/criados |
| `nineTeamImages` | `{ [key]: "data:image/jpeg;base64,..." }` — imagens enviadas do PC |

### Formato de imagem com upload do PC
```js
// guardado em editImgs:
{ local: 'img_1717000000000_abc12' }  // key para buscar no nineTeamImages

// quando resolvido para o catálogo:
{ url: 'data:image/jpeg;base64,...', i: '', e: '' }
```

---

## Limitação principal (IMPORTANTE)

**localStorage é por navegador.** Se o cliente editar no admin no computador dele → as mudanças ficam no browser dele → visitantes de outros browsers/devices NÃO veem as mudanças.

### Solução recomendada (ainda não implementada)
Integrar **Firebase Realtime Database** (gratuito):
1. Cliente cria conta em firebase.google.com
2. Cria projeto + Realtime Database
3. Fornece as credenciais de config
4. Admin salva no Firebase, catálogo lê do Firebase
5. Funciona para todos os visitantes em tempo real

---

## Script de download (`baixar-imagens.command`)
Script bash para macOS que baixa todas as imagens do Yupoo para a pasta `imgs/` local. Usa `curl` com headers de Referer e User-Agent para burlar a proteção do Yupoo. Cada produto tem fotos frente (idx 0) e verso (idx 1+).

---

## Instagram
- Handle: `9teamstore`
- Botão de compra gera mensagem pré-formatada e abre `https://ig.me/m/9teamstore`

---

## Hospedagem
- Site já está no ar e funcionando
- Estrutura na hospedagem: `catalogo-9team.html`, `admin.html`, pasta `imgs/` — tudo na mesma pasta raiz
- Admin acessado via `seusite.com/admin.html` (não `/admin`)

---

## Próximo passo sugerido
Implementar Firebase para tornar o admin funcional para todos os visitantes (não só no browser local). Passos:
1. Criar projeto no firebase.google.com (grátis)
2. Ativar Realtime Database no modo teste
3. Copiar as credenciais de configuração (objeto `firebaseConfig`)
4. Compartilhar com o Claude para integração nos dois HTMLs
