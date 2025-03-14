#!/bin/bash

CONFIG_FILE="/etc/ipsec.conf"
SECRETS_FILE="/etc/ipsec.secrets"
STRONGSWAN_SERVICE="strongswan"

usage() {
    echo "Uso: $0 -remotegateway <gateway_remoto> -localgateway <gateway_local> -cripto <cifra> -psk <chave> -localnetwork <rede_local> -remotenetwork <rede_remota>"
    echo "     $0 -remove -remotegateway <gateway_remoto> OU -remove -remotenetwork <rede_remota>"
    exit 1
}

REMOVE=0
REMOTEGATEWAY=""
LOCALGATEWAY="%defaultroute"
CRIPTO="aes256-sha256-modp2048"
PSK=""
LOCALNET=""
REMOTENET=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -remotegateway) REMOTEGATEWAY="$2"; shift 2;;
        -localgateway) LOCALGATEWAY="$2"; shift 2;;
        -cripto) CRIPTO="$2"; shift 2;;
        -psk) PSK="$2"; shift 2;;
        -localnetwork) LOCALNET="$2"; shift 2;;
        -remotenetwork) REMOTENET="$2"; shift 2;;
        -remove) REMOVE=1; shift;;
        *) usage;;
    esac
done

if [[ "$REMOVE" -eq 1 ]]; then
    if [[ -n "$REMOTEGATEWAY" ]]; then
        sed -i "/conn $REMOTEGATEWAY/,/}/d" "$CONFIG_FILE"
        sed -i "/$REMOTEGATEWAY/d" "$SECRETS_FILE"
        echo "VPN com gateway remoto $REMOTEGATEWAY removida."
    elif [[ -n "$REMOTENET" ]]; then
        sed -i "/leftsubnet=$REMOTENET/d" "$CONFIG_FILE"
        echo "VPN com rede remota $REMOTENET removida."
    else
        usage
    fi
    systemctl restart "$STRONGSWAN_SERVICE"
    exit 0
fi

if [[ -z "$REMOTEGATEWAY" || -z "$PSK" || -z "$LOCALNET" || -z "$REMOTENET" ]]; then
    usage
fi

cat <<EOF >> "$CONFIG_FILE"
conn $REMOTEGATEWAY
    auto=start
    left=$LOCALGATEWAY
    leftsubnet=$LOCALNET
    right=$REMOTEGATEWAY
    rightsubnet=$REMOTENET
    ike=$CRIPTO
    esp=$CRIPTO
    keyexchange=ikev2
    authby=secret
EOF

echo "$REMOTEGATEWAY : PSK \"$PSK\"" >> "$SECRETS_FILE"

systemctl restart "$STRONGSWAN_SERVICE"
echo "VPN com gateway remoto $REMOTEGATEWAY configurada e ativa."
