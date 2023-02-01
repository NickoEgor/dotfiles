#!/bin/sh

# NOTE: $ python -c "import ssl; print(ssl.get_default_verify_paths())"
if [ -d "/usr/lib/ssl/certs/" ]; then
    # ubuntu CA bundle:
    export REQUESTS_CA_BUNDLE="/usr/lib/ssl/certs/ca-certificates.crt"
elif [ -d "/etc/pki/tls/" ]; then
    # centos CA bundle:
    export REQUESTS_CA_BUNDLE="/etc/pki/tls/cert.pem"
fi

# NOTE: CURL_CA_BUNDLE variable can be used for similar CA troubles for curl
# $ echo "cacert=/etc/ssl/certs/ca-certificates.crt" >> ~/.curlrc

export SUDO_ASKPASS="/home/yahor/.local/bin/wm/dmenu_pass"
/usr/bin/vmware-user-suid-wrapper &>/dev/null &
