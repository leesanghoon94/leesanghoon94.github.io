#!/bin/zsh

# 사용자로부터 글 제목을 입력 받음
echo -n "글 제목을 입력하세요: "
read post_title

# 글 제목이 비어있는지 확인
if [ -z "$post_title" ]; then
  echo "글 제목을 입력하세요."
  exit 1
fi

# 입력 받은 글 제목을 사용하여 bundle exec jekyll post 명령 실행
bundle exec jekyll compose "$post_title"
