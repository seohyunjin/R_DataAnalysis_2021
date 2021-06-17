##### CH02_데이터 전처리 #####

### 1장.제어문 ###


## 1절 | 조건문(if/else, ifelse())

#1. if/else
#if(조건식){참이면 수행문장}else{ 거짓일때 수행할 문장 }
# Q) 정수를 입력받아 해당 숫자가 짝수인지 홀수인지 판단하고, 
#   만약 입력받은 숫자가 정수가 아닐 경우 “정수를 입력해주세요.”라는 
#   문구를 출력하는 if문을 작성해보자.
# A)
x <- 9   
if(x%%2==0){                          # %% : 나머지연산자
  print(paste(x, "는 짝수입니다."))   # 조건이 참일 때 수행할 코드
}  else if (x%%2==1) {                 
  print(paste(x, "는 홀수입니다."))   # 첫째 조건이 거짓, x%%2==1 조건이 참일 때 수행할 코드    
}  else { 
  print ("정수를 입력해주세요.")      # 위의 조건 중 어느 것도 만족하지 않을 때 수행할 코드
} #  "9 는 홀수입니다."

# 2. ifelse
# ifelse(조건식,참일때 수행할 문장, 거짓일때 수행할 문장)
# Q) 정수를 입력받아 짝수이면 “짝수입니다.”, 홀수이면 “홀수입니다.”를 출력하고, 
#    정수가 아닐 경우 “정수가 아닙니다.”를 출력하는 ifelse문을 작성해보자. 
# A)
x<-3.9
ifelse(x%%2==0, "짝수입니다.",
       ifelse(x%%2==1, "홀수입니다.", "정수가 아닙니다."))
# "정수가 아닙니다."


## 2절 | 반복문(for, while, repeat)

# 1. for
#for(변수 in 시퀀스 ){참일때 실행문장}
# Q) 만약 여러분이 아래에 제시된 데이터를 콘솔창에 출력하고 싶다면 
#    print 함수 구문을 4번 수행하는 대신, for문을 사용한 간단한 R 코드를 실행하여 
#    원하는 결과를 더욱 편리하게 얻을 수 있다. 
#    이를 확인하기 위해 반복문을 사용하지 않을 때와 반복문을 사용할 때를 비교해보자.
# A)
# 반복문을 사용하지 않은 경우 : print 함수를 4번 실행
# paste() : ()안에 나열된 문자열을 합쳐주는 함수
print(paste("The year is", 2015))       
print(paste("The year is", 2016))
print(paste("The year is", 2017))
print(paste("The year is", 2018))
#반복문
for (year in c(2015:2018)){
  print(paste("The year is", year))
}
# [1] "The year is 2015"
# [1] "The year is 2016"
# [1] "The year is 2017"
# [1] "The year is 2018"

# 2. while
# while(가변변수조건식){참일때 실행할 문장, 변수증감식}
# Q) for문을 사용하여 해결했던 예제에 대해 while문을 이용해서 똑같은 결과값을 만들어보자.
# A)
year <- 2015          
while(year<=2018){
  print(paste("The year is", year))
  year <- year+1}
# [1] "The year is 2015"
# [1] "The year is 2016"
# [1] "The year is 2017"
# [1] "The year is 2018"


# 3. repeat

# - break 
# 1~10 까지의 숫자 중 짝수만 출력하기
i<-0
repeat{i <- i+2
print(i)
if(i>=10){
  break   # i가 10이상이면 반복문 종료
}
}
# [1] 2
# [1] 4
# [1] 6
# [1] 8
# [1] 10

#- next 
# 1~10 까지의 숫자 중 홀수만 출력하기
# 반복문 내의 next를 만나면 print(i)를 실행하지 않고 for문의 맨 처음으로 이동
for(i in 1:10){ 
  if(i%%2==0){ next } # 다음을 실행하지않고 건너띔!!
  print(i)
} 
# [1] 1
# [1] 3
# [1] 5
# [1] 7
# [1] 9
