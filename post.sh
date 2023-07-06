# 블로그 포스트의 제목을 입력 받습니다.
read -p "포스트 제목을 입력하세요: " title

# 카테고리 선택을 위한 선택지를 배열로 선언합니다.
options=("dev" "writer")

# 선택을 위한 대화상자를 출력하고 선택을 받습니다.
category=$(osascript -e 'button returned of (display dialog "포스트 카테고리를 선택하세요:" buttons {"dev", "writer"} default button 1)')

# 선택이 취소되었을 경우 스크립트를 종료합니다.
if [[ $category == "false" ]]; then
    echo "카테고리 선택이 취소되었습니다."
    exit 1
fi

# 댓글을 허용할지 여부를 입력 받습니다.
comments=$(osascript -e 'button returned of (display dialog "댓글을 허용하시겠습니까?" buttons {"true", "false"} default button 1)')

# 블로그 포스트의 파일명을 생성합니다.
filename="_posts/$(date +"%Y-%m-%d")-$(echo "$title" | tr " " -).md"

# 블로그 포스트 파일을 생성하고 헤더 정보를 추가합니다.
echo "---" > "$filename"
echo "title: $title" >> "$filename"
echo "categories: [$category]" >> "$filename"
echo "comments: $comments" >> "$filename"
echo "---" >> "$filename"

echo "블로그 포스트 파일이 생성되었습니다. 파일명: $filename"
