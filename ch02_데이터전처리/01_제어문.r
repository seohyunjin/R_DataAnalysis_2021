# 조건문 

# if /else
# 정수를 입력 받아 해당 숫자가 짝수인지 홀수인지 판단하고, 입력받은 숫자가 정수가 아닐 경우 '정수를 입력해주세요' 문구를 출력하는 if문 작성해보자

x <- 0 
if(x%%2 == 0){
    print(paste(x,"는 짝수 입니다."))
}else if (x %%2 == 1){
    print(paste(x,'는 홀수 입니다.'))
}else{
    print("정수를 입력해주세요.")
}
