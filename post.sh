#!/bin/bash


# 블로그의 _posts 디렉토리 경로 설정
POSTS_DIR="_posts"

# 현재 날짜 가져오기 (YYYY-MM-DD 형식)
CURRENT_DATE=$(date +"%Y-%m-%d")

# 사용자로부터 포스트 제목 입력받기
read -p "포스트 제목을 입력하세요: " TITLE
mkdir -p _posts/$TITLE
# 파일명 생성 (공백은 대시로 변환)
FILENAME="$CURRENT_DATE-${TITLE// /-}.md"

# 카테고리 입력받기
read -p "카테고리를 입력하세요 (쉼표로 구분): " CATEGORIES

# 태그 입력받기
read -p "태그를 입력하세요 (쉼표로 구분): " TAGS

# 포스트 파일 생성
cat << EOF > "$POSTS_DIR/$TITLE/$FILENAME"
---
layout: post
title: "$TITLE"
date: $CURRENT_DATE $(date +"%H:%M:%S %z")
categories: [$CATEGORIES]
tags: [$TAGS]
---

여기에 포스트 내용을 작성하세요.

EOF

echo "새 포스트가 생성되었습니다: $POSTS_DIR/$FILENAME"