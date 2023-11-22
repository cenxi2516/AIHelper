git checkout --orphan latest_branch;
git add -A;
git commit -am "clear all history";
echo -e -n "请输入清空历史的分支名：";
read InputContent; # 接收输入值
git branch -D ${InputContent};
git branch -m ${InputContent};
git push -f origin ${InputContent};
git branch --set-upstream-to=origin/${InputContent} ${InputContent};
git pull;
git log --pretty=oneline;
git branch -a;
git tag;
git ls-remote --tags;
