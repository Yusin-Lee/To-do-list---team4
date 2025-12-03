#!/bin/bash

# common.sh - 공통 함수 및 설정

# 데이터 파일 경로
DATA_DIR="./data"
TODO_FILE="$DATA_DIR/todos.txt"

# 데이터 디렉토리 생성
initialize_data_dir() {
    if [ ! -d "$DATA_DIR" ]; then
        mkdir -p "$DATA_DIR"
        echo "데이터 디렉토리가 생성되었습니다."
    fi
    
    if [ ! -f "$TODO_FILE" ]; then
        touch "$TODO_FILE"
        echo "할일 파일이 생성되었습니다."
    fi
}

# 다음 ID 생성
get_next_id() {
    if [ ! -s "$TODO_FILE" ]; then
        echo 1
    else
        local max_id=$(awk -F'|' '{print $1}' "$TODO_FILE" | sort -n | tail -1)
        echo $((max_id + 1))
    fi
}