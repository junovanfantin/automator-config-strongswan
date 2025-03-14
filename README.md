# VPN Manager - StrongSwan

Este repositório contém um **script shell** para facilitar a **criação e remoção de VPNs** no StrongSwan. O script permite configurar rapidamente uma nova conexão VPN IPsec ou remover uma VPN específica sem impactar outras já configuradas.

## 📌 Funcionalidades
- Criar VPNs de forma automática informando os parâmetros necessários.
- Remover VPNs com base no **gateway remoto** ou na **rede remota**.
- Configuração dinâmica do algoritmo de criptografia.
- Gerenciamento seguro de **PSK (Pre-Shared Key)**.
- Reinicialização automática do serviço **StrongSwan** após modificações.

## 🛠️ Instalação

Clone este repositório e conceda permissão de execução ao script:

```bash
git clone https://github.com/seuusuario/vpn-manager.git
cd vpn-manager
chmod +x vpn_manager.sh
```

## 🚀 Uso do Script

### Criar uma VPN

```bash
./vpn_manager.sh -remotegateway 192.168.1.1 -localgateway 10.10.10.1 -cripto aes256-sha256-modp2048 -psk "minhaSenhaSecreta" -localnetwork 10.0.0.0/24 -remotenetwork 192.168.2.0/24
```

### Remover uma VPN pelo Gateway Remoto

```bash
./vpn_manager.sh -remove -remotegateway 192.168.1.1
```

### Remover uma VPN pela Rede Remota

```bash
./vpn_manager.sh -remove -remotenetwork 192.168.2.0/24
```

## 📄 Licença
Este projeto está sob a licença MIT. Sinta-se à vontade para utilizar e modificar conforme necessário.

## 🤝 Contribuições
Contribuições são bem-vindas! Siga as etapas:
1. Faça um fork do repositório.
2. Crie uma branch com sua feature (`git checkout -b minha-feature`).
3. Commit suas alterações (`git commit -m 'Adiciona nova funcionalidade'`).
4. Faça um push para a branch (`git push origin minha-feature`).
5. Abra um Pull Request.

## 📧 Contato
Caso tenha dúvidas ou sugestões, entre em contato através de [seu email ou redes sociais].

