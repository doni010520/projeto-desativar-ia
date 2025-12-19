# 🤖 Desativar IA - Sistema de Gerenciamento de Leads

Aplicação web simples para desativar a IA de leads através do número de telefone.

## 📋 Funcionalidades

- 📱 Buscar lead por número de telefone com **busca inteligente**
- 🔄 Alterar status `ia_on_off` para OFF
- ✅ Verificar status atual da IA
- 🎨 Interface moderna e responsiva
- 🔒 Integração segura com Supabase
- 🧠 **Normalização automática de telefones** - adiciona 55 e busca com/sem o 9

### 🔍 Busca Inteligente de Telefones

O banco de dados **sempre salva telefones com código 55**.  
A aplicação normaliza automaticamente o telefone que o usuário digita:

**Exemplo 1:** Usuário digita `(11) 98888-7777` ou `11988887777`
- Busca por: `5511988887777` (com 9) e `551188887777` (sem 9)

**Exemplo 2:** Usuário digita `(11) 8888-7777` ou `1188887777`
- Busca por: `551188887777` (sem 9) e `5511988887777` (com 9)

**Formatos aceitos do usuário:**
- Com/sem dígito 9 extra (celular)
- Com/sem formatação: `(11) 98888-7777` ou `11988887777`
- Se digitar com 55, remove e adiciona novamente (normalização)

✅ **Sempre busca 2 variações**: com 55 + com 9, e com 55 + sem 9

## 🚀 Tecnologias

- Node.js + Express
- Supabase (PostgreSQL)
- HTML/CSS/JavaScript (Vanilla)
- Docker

## 🌐 Deploy no EasyPanel (VPS)

### 1. Preparar o GitHub

1. Crie um repositório no GitHub
2. Faça push do código:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/seu-usuario/seu-repositorio.git
git push -u origin main
```

### 2. Configurar no EasyPanel

1. **Criar novo projeto:**
   - Acesse seu EasyPanel
   - Clique em "Create Project"
   - Escolha "From GitHub Repository"

2. **Conectar repositório:**
   - Selecione seu repositório
   - Branch: `main`

3. **Configurar variáveis de ambiente:**
   
   No EasyPanel, adicione as seguintes variáveis:
   
   ```
   SUPABASE_URL=https://seu-projeto.supabase.co
   SUPABASE_KEY=sua-anon-key-aqui
   ```

   **✅ Apenas essas 2 variáveis são necessárias!**
   
   A porta é gerenciada automaticamente pelo EasyPanel.

4. **Configurar o serviço:**
   
   - **Build Command:** `npm install`
   - **Start Command:** `npm start`
   - **Port:** Deixe vazio (EasyPanel gerencia automaticamente)

5. **Deploy:**
   - Clique em "Deploy"
   - Aguarde o build e deploy

### 3. Acessar a aplicação

Após o deploy, você receberá uma URL do tipo:
```
https://seu-app.easypanel.host
```

## 🔧 Configuração do Supabase

### Obter as credenciais:

1. Acesse [supabase.com](https://supabase.com)
2. Vá no seu projeto
3. Settings → API
4. Copie:
   - **URL:** Project URL
   - **Key:** anon/public key

### Tabela necessária:

A aplicação espera uma tabela chamada `leads_energia_solar` com as seguintes colunas principais:

- `id` (uuid)
- `telefone` (text)
- `nome` (text)
- `ia_on_off` (text)

## 📝 Como usar

### Desativar IA:

1. Digite o número de telefone no formato que preferir:
   - `(11) 98888-7777`
   - `11988887777`
   - `1188887777`
   - `5511988887777`
2. Clique em "Desativar IA"
3. A aplicação irá:
   - Gerar todas as variações possíveis do telefone
   - Buscar no banco em todos os formatos
   - Alterar `ia_on_off` para "OFF"
   - Exibir confirmação com os dados do lead

### Verificar Status:

1. Digite o número de telefone
2. Clique em "Verificar Status"
3. Veja o status atual da IA para aquele lead

## 📦 Instalação Local (Desenvolvimento)

### 1. Clonar o repositório

```bash
git clone seu-repositorio.git
cd seu-repositorio
```

### 2. Instalar dependências

```bash
npm install
```

### 3. Configurar variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
SUPABASE_URL=https://seu-projeto.supabase.co
SUPABASE_KEY=sua-anon-key-aqui
PORT=3000
```

### 4. Executar o projeto

```bash
npm start
```

Acesse: `http://localhost:3000`

## 🔒 Segurança

- ⚠️ Use apenas a **anon key** (pública) do Supabase
- 🔐 Configure Row Level Security (RLS) no Supabase
- 🛡️ Restrinja permissões da API no Supabase

### Exemplo de Policy RLS:

```sql
-- Permitir UPDATE apenas na coluna ia_on_off
CREATE POLICY "Allow update ia_on_off"
ON leads_energia_solar
FOR UPDATE
USING (true)
WITH CHECK (true);
```

## 📁 Estrutura do Projeto

```
.
├── server.js           # Servidor Express
├── package.json        # Dependências
├── Dockerfile          # Configuração Docker
├── .dockerignore       # Arquivos ignorados no Docker
├── .gitignore          # Arquivos ignorados no Git
├── .env.example        # Exemplo de variáveis
├── public/
│   └── index.html     # Interface do usuário
└── README.md          # Este arquivo
```

## 🐛 Troubleshooting

### Erro: "Variáveis de ambiente não encontradas"
- Verifique se configurou as variáveis no EasyPanel:
  - `SUPABASE_URL`
  - `SUPABASE_KEY`

### Erro: "Telefone não encontrado"
A aplicação busca automaticamente com o código 55 e com/sem o 9:
- **Sempre busca:** `55` + DDD + número (com e sem o 9)
- Se ainda não encontrar, verifique:
  - O telefone realmente existe na tabela `leads_energia_solar`?
  - O telefone no banco tem formato diferente de `55DDDnúmero`?

### Erro de conexão com Supabase
- Verifique a URL e Key
- Confirme se a tabela `leads_energia_solar` existe
- Verifique as permissões da API

## 📞 Suporte

Para problemas ou dúvidas, abra uma issue no GitHub.

## 📄 Licença

ISC
