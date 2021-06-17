# 변수목록 제거
rm(list=ls())


##### 1장 : R 기본 #####

###1.데이터타입###

## 1.스칼라 ## 

## 가. 숫자형(numeric)
a<-1      # a라는 변수에 정수 1 저장
b<-2.7    # b라는 변수에 소수 2.7 저장
a         # a 출력 #;1 
b         # b 출력 #;2.7
#변수의 데이터 타입 확인 : mode(변수)
mode(a)   #;"numeric"
mode(b)   #;"numeric"

## 나. 문자형(character)
a<-"가" # a라는 변수에 "가" 저장
mode(a) #;"character"
b<-"1"
c<-"2"
b+c #에러발생; 문자끼리연산 불가

## 다. 논리형 (logical)
# FALSE: O False: X F: O
a<-TRUE   # a 변수에 논리값 TRUE 저장
mode(a)   #;logical(논리형)
b<-FALSE #;FALSE ;0
a+b       # 논리형 데이터끼리는 산술연산이 가능!! #;1

## 라. 팩터형 (factor) 
#factor(데이터, levels= c('레벨1','레벨2',..),
#       labels=c('라벨1','라벨2',..),ordered = F)
fc<-factor(c("m","m","f","f","f"), levels=c("f","m"), 
           labels=c("여","남"), ordered=F) #명목형
fc
# [1] 남 남 여 여 여
# Levels: 여 남
fc<-factor(c("m","m","f","f","f"), levels=c("f","m"), 
           labels=c("여","남"), ordered=T) #순서형;라벨에서 뒤에 있는 것이 더큼
fc
#[1] 남 남 여 여 여
# Levels: 여 < 남



## 2.벡터##


## 가. 벡터의 생성

#1) (c() 사용)
a<-c(1,2,3)
a #;1 2 3

#2) (: 사용)
b<-1:3
b #;1 2 3

#3) rep(벡터, 반복횟수)사용 : 벡터를 반복함
rep(c(1,2,3),3) #1 2 3 1 2 3 1 2 3

#3) rep(벡터,벡터) : 뒤 벡터는 반복횟수를 의미하여 1:1대칭
rep(c(1,2), c(1,2)) # 1을 1번 반복, 2를 2번 반복#;  1 2 2

#4) seq(시작숫자,마지막숫자, 증가하는양)
c<-seq(1,11,2) #1부터 11까지 2씩 증가하는 수열 ! R은 마지막숫자 포함!!
c #;1 3 5 7 9 11


## 나. 벡터의 인덱싱
z<-c(1:5)
z # 1 2 3 4 5

z[2]        #스칼라값 ; 2
z[c(1,3)]   #벡터 ;  1 3
z[1:3]      #:이용 #; 1 2 3
z[-5]       # -index:제외하고출력 #;1 2 3 4
z[z>3]      # 값조건 #;4 5


# 1~3까지의 값이 저장된 벡터 x 생성
x<-c(1,2,3) #; 1 2 3

# x의 각 요소에 대해 Kim, Park, Lee 라는 이름을 지정
# names(변수명) <-(요소1에 지정할 이름1, 이름2, 이름3,..)
names(x)<-c("Kim","Park","Lee")

str(x) #데이터구조확인
# Named num [1:3] 1 2 3
#- attr(*, "names")= chr [1:3] "Kim" "Park" "Lee"

x
#Kim Park  Lee 
#1    2    3 

# x벡터에서 이름이 Kim인 원소 출력
x["Kim"]
#Kim 
#1 

# x벡터의 각 요소에 부여된 이름 출력
names(x) #"Kim"  "Park" "Lee" 

# *변수명(원소명)추출 
# names(벡터)  names(데이터프레임) names(리스트)
# dimnames(데이터프레임) dimnames(행렬)
# rownames(데이터프레임) rownames(행렬)
# colnames(데이터프레임) colnames(행렬)

# names(x)의 두 번째 값 출력
names(x)[2] #"Park"


## 다. 벡터의 연산
# 벡터의 연산 예시
x<-c(1:4) # 1 2 3 4 

x*3     # x벡터의 전체 원소에 3을 곱함; 3  6  9 12
x+5     #x벡터의 전체 원소에 5를 더함; 6 7 8 9

# 벡터간 연산의 예시
y<-c(5:8) # 5 6 7 8
z<-c(1,2) # 1 2

# 길이가 같은 벡터간 연산
x+y # 6  8 10 12
# 길이가 다른 벡터간 연산
x+z # 2 4 4 6



## 3.행렬##

# Q) 1,2,3,4,5,6,7,8,9 가 저장된 3행3열의 행렬을 생성해보자.
#   이 때 1행부터 차례대로 r1, r2, r3이라는 행이름을 부여하고
#   1열부터 차례대로 a,b,c라는 이름을 부여하자.
# A)
# 행렬(데이터,nrow=행수, ncol=열수, byrow=TRUE(행우선)FALSE(열우선))
matrix(1:9, nrow=3, ncol=3, dimnames=list(c("r1","r2","r3"),c("a","b","c")))
#    a b c
# r1 1 4 7
# r2 2 5 8
# r3 3 6 9


## 4.데이터프레임 ##

# Q) 아래에 예시로 주어진 표와 같은 데이터프레임을 생성하여 
#   x변수에 저장한 뒤 출력하고, x 데이터의 구조를 확인해보자.
## A)
# 데이터프레임 생성
x<-data.frame(이름=c("이유리","최민준","김민지"), 
                전공=c("경영학과","컴퓨터공학과","테이터과학과"),
                성별=c("여","남","여"), 나이=c(20,22,21))
x
#    이름         전공 성별 나이
#1 이유리     경영학과   여   20
#2 최민준 컴퓨터공학과   남   22
#3 김민지 테이터과학과   여   21
# x 데이터의 구조 확인
str(x) # 'data.frame':	3 obs. of  4 variables: $ 이름: Factor ~~ 


## 5. 리스트

v1<-c("가","나","다")  
v2<-c(T,F,F)           
# 데이터프레임 생성
# data.frame(변수명1 = 벡터1, 변수명2 = 벡터2, stringsAsFactors=default.stringsAsFactors() )
df<-data.frame(subject=c("미술","음악","체육"), class=c("1교시","2교시","3교시"))
df
#  subject class
#1    미술 1교시
#2    음악 2교시
#3    체육 3교시

# key를 지정하지 않고 리스트 생성
ls1 <- list(v1,v2,df,sum)
ls1

# key를 지정하여 리스트 생성
# list(key이름 = 값)
ls2 <- list(v1=v1,v2=v2,df=df,fun=sum)
ls2


## 6. 배열

#Q) 1~27까지의 숫자를 3x3행렬 3개에 저장하고 있는 배열을 생성해보자. 
#   이 때 매트릭스의 행이름은 1행, 2행, 3행, 열이름은 1열, 2열, 3열, 
#   각 매트릭스의 이름은 matrix_1, matrix_2, matrix_3으로 지정하자.
# A)
rname=c("1행","2행","3행")  
cname=c("1열","2열","3열")   
mname=c("matrix_1","matrix_2","matrix_3")  

ar<-array(1:27, dim=c(3,3,3), dimnames=list(rname,cname,mname))
ar
# , , matrix_1
# 
# 1열 2열 3열
# 1행   1   4   7
# 2행   2   5   8
# 3행   3   6   9
# 
# , , matrix_2
# 
# 1열 2열 3열
# 1행  10  13  16
# 2행  11  14  17
# 3행  12  15  18
# 
# , , matrix_3
# 
# 1열 2열 3열
# 1행  19  22  25
# 2행  20  23  26
# 3행  21  24  27


### 사용자 정의함수 ###

# Q1) 하나의 숫자를 입력받아 제곱값을 계산하는 함수를 생성해보자.
fun1<-function(num){  
  return(num^2)
}
fun1(2) # ;4

# Q2) 여러 숫자를 입력받아 합을 출력하는 함수를 생성해보자.
fun2<-function(...){
  x<-sum(...)      
  paste("합계 : ",x)
} # 인자수를 지정하지않음
fun2(2,4,6,8,10) #;"합계 :  30"

# Q3) 중첩함수 구문을 통해 두 개의 숫자를 입력받아 두 숫자와 그 합을 출력하는 함수를 생성해보자.
fun3<-function(x,y){
  print(x) 
  print(y)
  fun4<-function(x,y){      #fun3 함수 안에 fun4 함수를 정의
    sum<-x+y
    paste(x, "+", y, "=", sum) #문자 이어붙여 출력
  }
  fun4(x,y)                   #fun3 함수 안에서 fun4 함수를 호출
}
#함수호출
fun3(3,5)
# [1] 3
# [1] 5
# [1] "3 + 5 = 8"
