#!/bin/bash

set -e

echo "🔄 更新所有子模块到指定分支"
git submodule update --init --remote --checkout

echo ""
echo "🧾 当前子模块 commit 信息："
cd partner
git checkout develop
BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT=$(git rev-parse --short HEAD)
echo "📁 partner 分支：$BRANCH | commit: $COMMIT"

echo "📦 安装依赖并构建 partner"
pnpm install
pnpm build:dev
cd ..