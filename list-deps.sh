#!/bin/bash

cd folly && ./build/fbcode_builder/getdeps.py install-system-deps --dry-run --recursive
