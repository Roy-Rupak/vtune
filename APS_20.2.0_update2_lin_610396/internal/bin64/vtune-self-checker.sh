#!/bin/sh

VTUNE_SCRIPT_PATH=$(dirname "$0")
VTUNE_SCRIPT_PATH=$(cd "${VTUNE_SCRIPT_PATH}"; pwd -P)

path_to_module="${VTUNE_SCRIPT_PATH}/self_check.py"
path_to_python="${VTUNE_SCRIPT_PATH}/amplxe-python"

"${path_to_python}" "${path_to_module}" "$@"