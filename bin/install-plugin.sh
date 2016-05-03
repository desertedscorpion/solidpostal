#!/bin/bash

java hudson.cli.CLI -s http://127.0.0.1:8080 install-plugin "${@}" &&
    true
