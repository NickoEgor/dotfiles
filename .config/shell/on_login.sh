#!/bin/bash

# NOTE: $ python -c "import ssl; print(ssl.get_default_verify_paths())"
# ubuntu CA bundle:
# export REQUESTS_CA_BUNDLE="/usr/lib/ssl/certs/ca-certificates.crt"
# centos CA bundle:
export REQUESTS_CA_BUNDLE="/etc/pki/tls/cert.pem"

# gnome panels style
export GNOME_SHELL_SESSION_MODE=classic # gnome-session --session gnome-classic
