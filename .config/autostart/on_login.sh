#!/bin/bash

# NOTE: to run pycharm
export _JAVA_AWT_WM_NONREPARENTING=1

# NOTE: $ python -c "import ssl; print(ssl.get_default_verify_paths())"
# ubuntu CA bundle:
# export REQUESTS_CA_BUNDLE="/usr/lib/ssl/certs/ca-certificates.crt"
# centos CA bundle:
export REQUESTS_CA_BUNDLE="/etc/pki/tls/cert.pem"
