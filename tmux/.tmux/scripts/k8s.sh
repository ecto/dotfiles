#!/bin/bash
# Kubernetes context and namespace

if ! command -v kubectl &>/dev/null; then
    echo ""
    exit 0
fi

context=$(kubectl config current-context 2>/dev/null)
if [[ -z "$context" ]]; then
    echo ""
    exit 0
fi

namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
namespace=${namespace:-default}

# Truncate context if too long
if [[ ${#context} -gt 15 ]]; then
    context="${context:0:12}..."
fi

echo "#[fg=blue]󱃾 ${context}#[fg=white]:#[fg=cyan]${namespace}#[fg=white]"
