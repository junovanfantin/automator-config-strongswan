const express = require('express');
const { exec } = require('child_process');

const app = express();
const PORT = 3001;

app.use(express.json());

// Rota para criar uma VPN
app.post('/create-vpn', (req, res) => {
    const { remotegateway, localgateway, cripto, psk, localnetwork, remotenetwork } = req.body;
    
    if (!remotegateway || !localgateway || !cripto || !psk || !localnetwork || !remotenetwork) {
        return res.status(400).json({ error: 'Parâmetros obrigatórios ausentes' });
    }

    const command = `./vpn_manager.sh -remotegateway ${remotegateway} -localgateway ${localgateway} -cripto ${cripto} -psk ${psk} -localnetwork ${localnetwork} -remotenetwork ${remotenetwork}`;
    
    exec(command, (error, stdout, stderr) => {
        if (error) {
            return res.status(500).json({ error: stderr });
        }
        res.json({ message: 'VPN criada com sucesso!', output: stdout });
    });
});

// Rota para remover uma VPN
app.post('/remove-vpn', (req, res) => {
    const { remotegateway, remotenetwork } = req.body;
    
    if (!remotegateway && !remotenetwork) {
        return res.status(400).json({ error: 'Informe remotegateway ou remotenetwork para remoção' });
    }

    const command = remotegateway
        ? `./vpn_manager.sh -remove -remotegateway ${remotegateway}`
        : `./vpn_manager.sh -remove -remotenetwork ${remotenetwork}`;
    
    exec(command, (error, stdout, stderr) => {
        if (error) {
            return res.status(500).json({ error: stderr });
        }
        res.json({ message: 'VPN removida com sucesso!', output: stdout });
    });
});

app.listen(PORT, () => {
    console.log(`API VPN Manager rodando na porta ${PORT}`);
});
