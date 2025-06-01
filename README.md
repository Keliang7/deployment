# deployment


## 1. clone 指定为develop分支
git submodule add -b develop https://github.com/yourname/partner.git partner

## 2. 提交代码
cd ..
git add .gitmodules partner
git commit -m "chore: add partner submodule at develop branch"
git push
