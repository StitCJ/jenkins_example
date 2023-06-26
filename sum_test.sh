#!/bin/bash

# Docker 이미지 실행
container_id=$(docker run -d lcj0417/samsung-medison)

# 입력할 숫자 개수 및 숫자 값들
n=3
numbers=("1" "2" "3")

# 입력할 숫자 개수 전달
docker exec -it $container_id python -c "print($n)"

# 숫자 값들을 차례로 전달
for number in "${numbers[@]}"
do
    docker exec -it $container_id python -c "print($number)"
done

# 실행 결과 확인
result=$(docker logs $container_id)

# 실행 결과에 따라 성공 또는 실패 여부 판별
if [[ $result == "6" ]]; then
    echo "Tests Passed"
    # Jenkins 파이프라인에서 성공으로 설정
    currentBuild.result = 'SUCCESS'
else
    echo "Tests Failed"
    # Jenkins 파이프라인에서 실패로 설정
    currentBuild.result = 'FAILURE'
fi

# Docker 컨테이너 종료 및 제거
docker stop $container_id
docker rm $container_id