# Use Node.js 20 (versão LTS)
FROM node:20-alpine

# Criar diretório da aplicação
WORKDIR /app

# Copiar package.json
COPY package.json ./

# Instalar dependências
RUN npm install --omit=dev

# Copiar o restante do código
COPY . .

# Expor a porta (EasyPanel gerencia automaticamente)
EXPOSE 3000

# Comando para iniciar
CMD ["node", "server.js"]
