#!/bin/bash
# todo.sh - To-Do List Manager 메인 프로그램
# 모든 기능을 통합하여 실행

# 스크립트 디렉토리 경로 설정
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 각 기능 파일 불러오기
source "$SCRIPT_DIR/common.sh"
source "$SCRIPT_DIR/feature1.sh"
source "$SCRIPT_DIR/feature2.sh"
# source "$SCRIPT_DIR/feature3.sh"  # Feature 3 완성 시 추가
# source "$SCRIPT_DIR/feature4.sh"  # Feature 4 완성 시 추가

# 도움말 출력
show_help() {
    echo "=== To-Do List Manager ==="
    echo "명령어: add, delete, list, complete, help, exit"
    echo ""
    echo "사용법:"
    echo "  add [내용]       - 새로운 할일 추가"
    echo "  delete [ID]      - 할일 삭제"
    echo "  list             - 전체 할일 목록 보기"
    echo "  complete [ID]    - 할일 완료 처리"
    echo "  help             - 도움말 보기"
    echo "  exit             - 프로그램 종료"
}

# 메인 프로그램
main() {
    # 초기화
    initialize_data_dir
    
    echo "=== To-Do List Manager ==="
    echo "명령어: add, delete, list, complete, help, exit"
    echo ""
    
    # 명령어 루프
    while true; do
        echo -n "> "
        read -r command args
        
        case "$command" in
            add)
                add_todo $args
                ;;
            delete)
                delete_todo $args
                ;;
            list)
                list_todos
                ;;
            complete)
                complete_todo $args
                ;;
            help)
                show_help
                ;;
            exit)
                echo "프로그램을 종료합니다."
                exit 0
                ;;
            "")
                continue
                ;;
            *)
                echo "알 수 없는 명령어입니다. 'help'를 입력하여 도움말을 확인하세요."
                ;;
        esac
        echo ""
    done
}

# 프로그램 시작
main