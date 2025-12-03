#!/bin/bash

# feature1.sh - Feature 1: 할일 추가/삭제 기능
# 담당자: 이유신

# common.sh에서 공통 변수 및 함수 가져오기
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Feature 1-1: 할일 추가 기능
add_todo() {
    if [ -z "$1" ]; then
        echo "오류: 할일 내용을 입력해주세요."
        echo "사용법: add [할일 내용]"
        return 1
    fi
    
    local content="$*"
    local id=$(get_next_id)
    local status="incomplete"
    
    # 파일 형식: ID|내용|상태
    echo "$id|$content|$status" >> "$TODO_FILE"
    echo "할일이 추가되었습니다. (ID: $id)"
}

# Feature 1-2: 할일 삭제 기능
delete_todo() {
    if [ -z "$1" ]; then
        echo "오류: 삭제할 할일의 ID를 입력해주세요."
        echo "사용법: delete [할일 ID]"
        return 1
    fi
    
    local id="$1"
    
    # ID가 숫자인지 확인
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "오류: ID는 숫자여야 합니다."
        return 1
    fi
    
    # 해당 ID가 존재하는지 확인
    if ! grep -q "^$id|" "$TODO_FILE"; then
        echo "오류: ID $id에 해당하는 할일을 찾을 수 없습니다."
        return 1
    fi
    
    # 해당 ID의 할일 삭제 (sed 사용)
    sed -i "/^$id|/d" "$TODO_FILE"
    echo "할일 ${id}번이 삭제되었습니다."
}