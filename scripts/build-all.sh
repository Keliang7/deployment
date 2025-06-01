#!/bin/bash

set -e

echo "🔄 更新所有子模块到指定分支"
git submodule update --init --remote --checkout