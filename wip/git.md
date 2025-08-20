git 초기설정
고객정보를 ㄷ으록
git을 이용하여 commit을 했을 때 누가 commit 했는지 식별하기 위해서 이용됩니다.
git config --global user.name <사용자명>
git config --global user.email <이메일주소>

staging 취소 unstaging 하기
git reset <file name>

working directory를 변경전상태로 되돌린다.
git reset --hard
변경된 내용이 소멸됨
특정 commit상태로 되돌리고자하는경우에는 끝에 commit id 작성

git reset --hard <commit id>

복수의 local commit 을 나중에 하나로 정리하고자 할 경우에는,
git rebase -i 명령어를 이용합니다.
또는 직전의 commit과 이번에 수행하고 싶은 commit을 하나로 정리한다면 git commit --ammend 이용.


local repo
remote repo 생성 등록

remote repo 만든후 local
local repo 만든후 remote repo 등록

remote repo 등록 및 local repo 정보의 반영
git remote add origin https://github.com/ACCOUNT_ID/REPO.git
git push -u origin master

branch
git branch 

git branch test 생성

git checkout branch 전환

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

git switch -

git remote add origin https://github.com/account.git
git push -u origin master