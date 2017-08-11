#!/bin/bash

# Nuke virtual env from a prior run
if [[ -d demo_env ]]; then
    rm -rf demo_env;
fi

# Create an isolated env with only pip-tools
virtualenv demo_env
source demo_env/bin/activate
pip install pip-tools

# Generate A
pip-compile -o A.txt A.in

# Generate B
pip-compile -o B.txt B.in

# Install B, and confirm that package is installed
pip-sync B.txt
python -c "import backports.ssl_match_hostname"

# Install A, and confirm that package is installed
pip-sync A.txt

# This line fails, when it should not.
python -c "import backports.ssl_match_hostname"
