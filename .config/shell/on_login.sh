#!/bin/sh

# NOTE: $ python -c "import ssl; print(ssl.get_default_verify_paths())"
# ubuntu CA bundle:
# export REQUESTS_CA_BUNDLE="/usr/lib/ssl/certs/ca-certificates.crt"
# centos CA bundle:
export REQUESTS_CA_BUNDLE="/etc/pki/tls/cert.pem"
# NOTE: CURL_CA_BUNDLE variable can be used for similar CA troubles for curl
# $ echo "cacert=/etc/ssl/certs/ca-certificates.crt" >> ~/.curlrc

# gnome panels style
export GNOME_SHELL_SESSION_MODE=classic # gnome-session --session gnome-classic
