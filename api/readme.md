# VPN Manager API

Esta é uma API simples para gerenciar conexões VPN no StrongSwan de forma automatizada, permitindo criar e remover VPNs facilmente.

## 🚀 Tecnologias Utilizadas
- Node.js
- Express.js
- Shell Script para gerenciamento de VPN

## 📌 Requisitos
- **Node.js** (v14 ou superior)
- **StrongSwan** instalado no servidor
- **Permissões para executar scripts de configuração de VPN**

## 📦 Instalação

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seuusuario/vpn-manager-api.git
   cd vpn-manager-api
   ```

2. **Instale as dependências**:
   ```bash
   npm install
   ```

3. **Dê permissão ao script de VPN**:
   ```bash
   chmod +x vpn_manager.sh
   ```

## 🚀 Execução
Para iniciar a API, execute:
```bash
node server.js
```

Para rodar em background:
```bash
nohup node server.js > output.log 2>&1 &
```

Com **PM2** (recomendado para produção):
```bash
npm install -g pm2
pm start server.js --name vpn-api
pm2 save
pm2 startup
```

## 🔥 Endpoints Disponíveis

### **Criar VPN**
- **URL:** `POST /create-vpn`
- **Body JSON:**
  ```json
  {
    "remotegateway": "192.168.1.1",
    "localgateway": "10.10.10.1",
    "cripto": "aes256-sha256-modp2048",
    "psk": "minhaSenhaSecreta",
    "localnetwork": "10.0.0.0/24",
    "remotenetwork": "192.168.2.0/24"
  }
  ```
- **Resposta esperada:**
  ```json
  { "message": "VPN criada com sucesso!" }
  ```

### **Remover VPN**
- **URL:** `POST /remove-vpn`
- **Body JSON:** (Pode informar remotegateway ou remotenetwork)
  ```json
  {
    "remotegateway": "192.168.1.1"
  }
  ```
  **Ou**
  ```json
  {
    "remotenetwork": "192.168.2.0/24"
  }
  ```
- **Resposta esperada:**
  ```json
  { "message": "VPN removida com sucesso!" }
  ```

## 🔒 Segurança e Firewall
Se for acessar a API remotamente, libere a porta 3001:
```bash
sudo ufw allow 3001/tcp  # Para Ubuntu/Debian
sudo firewall-cmd --add-port=3001/tcp --permanent  # Para CentOS/RHEL
sudo firewall-cmd --reload
```

## 🛠 Contribuições
Sinta-se à vontade para abrir issues e enviar pull requests!

## 📜 Licença
MIT License

---

🚀 **Feito para facilitar o gerenciamento de VPNs!**
