#!/bin/bash

cat "${@}" | java hudson.cli.CLI -s http://127.0.0.1:8080 create-node $(basename "${@%.*}") &&
    true
