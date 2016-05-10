#!/bin/bash

dnf install --assumeyes git &&
    build git1 &&
    build job2 &&
    build job3 &&
    true
