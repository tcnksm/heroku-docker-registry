#!/bin/bash

# Generate config.yml from template file
eval "cat <<EOF
$(</app/src/config.yml.tmpl)
EOF
" 1> /app/src/config.yml 2> /dev/null

# Run web process
registry /app/src/config.yml

