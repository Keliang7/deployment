SHELL := /bin/bash

# 自动从 .gitmodules 提取子模块路径
SUBMODULES := $(shell git config --file .gitmodules --get-regexp path | awk '{print $$2}')
BRANCH := develop

.PHONY: all update build print_commit

all: update build

# 所有子模块都拉取 develop 分支
update:
	@for module in $(SUBMODULES); do \
		echo "🔄 更新子模块: $$module 到分支 $(BRANCH)"; \
		cd $$module && \
		git fetch origin && \
		git checkout $(BRANCH) && \
		git pull origin $(BRANCH) && \
		cd - >/dev/null; \
	done

build:
	@rm -rf _stage_dist
	@mkdir -p _stage_dist
	@for module in $(SUBMODULES); do \
		echo "📦 构建 $$module"; \
		cd $$module && \
		pnpm install --ignore-scripts && \
		pnpm build:dev && \
		rm -rf ../_stage_dist/$$module && \
		mkdir -p ../_stage_dist/$$module && \
		cp -r dist/* ../_stage_dist/$$module/ && \
		cd - >/dev/null; \
	done

print_commit:
	@for module in $(SUBMODULES); do \
		cd $$module && \
		branch=$$(git rev-parse --abbrev-ref HEAD) && \
		commit=$$(git rev-parse --short HEAD) && \
		echo "📁 $$module 分支：$$branch | commit：$$commit"; \
		cd - >/dev/null; \
	done