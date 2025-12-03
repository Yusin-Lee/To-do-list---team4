#!/bin/bash

# feature2.sh - Feature 2: 할일 목록 조회 및 완료 표시
# 담당자: 이유신

# common.sh에서 공통 변수 및 함수 가져오기
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common.sh"

# Feature 2-1: 할일 목록 조회
list_todos() {
    if [ ! -s "$TODO_FILE" ]; then
        echo "=== 할일 목록 ==="
        echo "등록된 할일이 없습니다."
        return 0
    fi
    
    echo "=== 할일 목록 ==="
    
    local total=0
    local completed=0
    local incomplete=0
    
    # 파일을 읽어서 출력
    while IFS='|' read -r id content status; do
        total=$((total + 1))
        
        if [ "$status" = "complete" ]; then
            echo "$id. [X] $content"
            completed=$((completed + 1))
        else
            echo "$id. [ ] $content"
            incomplete=$((incomplete + 1))
        fi
    done < "$TODO_FILE"
    
    echo ""
    echo "총 ${total}개의 할일 (완료: ${completed}, 미완료: ${incomplete})"
}

# Feature 2-2: 할일 완료 표시
complete_todo() {
    if [ -z "$1" ]; then
        echo "오류: 완료 처리할 할일의 ID를 입력해주세요."
        echo "사용법: complete [할일 ID]"
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
    
    # 이미 완료된 할일인지 확인
    if grep "^$id|.*|complete$" "$TODO_FILE" > /dev/null; then
        echo "알림: 할일 ${id}번은 이미 완료 처리되었습니다."
        return 0
    fi
    
    # 상태를 complete로 변경 (sed 사용)
    sed -i "s/^\($id|.*|\)incomplete$/\1complete/" "$TODO_FILE"
    echo "할일 ${id}번이 완료 처리되었습니다."
}