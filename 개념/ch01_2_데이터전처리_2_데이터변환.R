##### CH02_데이터 전처리 #####

### 2장. 데이터 변환 ###


## 1절 | 파생변수 생성

# 1. $ : data.frame에서의 변수추가
#Q) R의 내장 데이터 iris에 행번호를 담고 있는 ‘ID’ 라는 변수를 새로 생성해보자.
#A)
str(iris) # iris 데이터의 구조 확인 'data.frame':	150 obs. of  5 variables:
# 150개 개체들의 고유번호에 해당하는 'ID' 변수를 새로 생성!!
iris$ID<-1:150
# iris 데이터의 상위 6개의 행을 출력한 결과, ID 변수가 추가된 것을 확인할 수 있다.
head(iris)

# 2. [ ] : 대괄호를 활용한 변수추가
# Q) $를 이용하여 생성했던 ID 변수의 값이 짝수이면 A, 
#    홀수이면 B로 분류하는 새로운 변수(변수명 : Group)를 [ ]를 활용하여 생성해보자.
#A)
# ifelse 함수를 이용하여 ID가 짝수이면 A, 홀수이면 B를 부여
iris["Group"]<-ifelse(iris$ID%%2==0,"A","B") #새로운 변수 생성
# iris 데이터의 상위 6개의 행을 출력 : Group 변수가 추가된 것을 확인할 수 있다.
head(iris)

# 3. transform
# Q) iris 데이터에서 Sepal.Length 변수와 Petal.Length 변수의 값을 더하여 
#   ‘Sum.Length’ 라는 새로운 변수를 생성해보자.
# A)
transform(iris, Sum.Length=Sepal.Length + Petal.Length) #새로운 파생변수 생성

# 4. within
# Q) 학생의 id(s1, s2, s3, s4, s5, s6)를 담은 student_id 변수와 시험점수(55, 90, 85, 71, 63, 99)를 
#   담은 score 변수로 구성된 데이터프레임을 생성하자. 
#   그 후 시험점수가 90점 이상이면 수, 80점 이상 90점 미만이면 우, 
#   70점 이상 80점 미만이면 미, 60점 이상 70점 미만이면 양, 
#   60점 이하이면 가로 분류하는 ‘grade’ 라는 변수를 새롭게 생성해보자.
# A)
# 학생id(student_id 변수)와 시험점수(score 변수)로 이루어진 데이터 프레임 생성
student_id <- c("s1", "s2", "s3", "s4", "s5", "s6")  # 학생id가 담긴 벡터
score <- c(55, 90, 85, 71, 63, 99)                   # 시험점수가 담긴 벡터
score_df <- data.frame(student_id, score)            # 데이터 프레임 생성
score_df
# student_id score
# 1         s1    55
# 2         s2    90
# 3         s3    85
# 4         s4    71
# 5         s5    63
# 6         s6    99
# 학생의 점수(score변수)를 수, 우, 미, 양, 가로 분류하여 'grade' 라는 새로운 변수 생성
score_df <- within(score_df, {
  grade = character(0)         # 새로운 변수의 데이터 타입 지정 (생략 가능)
  grade[ score < 60 ] = "가"   # score가 60미만인 경우 grade에 “가” 입력
  grade[ score >=60 & score < 70 ] = "양" 
  grade[ score >=70 & score < 80 ] = "미"
  grade[ score >=80 & score < 90 ] = "우" 
  grade[ score >=90 ] = "수" 
  grade = factor(grade, level = c("수", "우", "미", "양", "가")) 
  # grade변수를 "수", "우", "미", "양", "가"의 범주로 이루어진 팩터로 변환
})
score_df
#  student_id score grade
# 1         s1    55    가
# 2         s2    90    수
# 3         s3    85    우
# 4         s4    71    미
# 5         s5    63    양
# 6         s6    99    수



## 2절 | 변수 축소

## 1. 주성분분석

##Q) R에 내장된 USArrests 데이터는 1973년 미국 50개주 100,000명의 인구 당 
#   체포된 세 가지 강력범죄수(assault, murder, rape)와 각 주마다 도시에 거주하는 
#   인구의 비율(%)로 구성되어있다. 주성분 분석을 수행하여 해당 데이터의 변수들을 
#    가장 잘 요약하는 주성분을 구하고 해석해보자.
#A)

# ① 데이터 확인 및 산점도를 통해 변수 간 상관관계 파악
library(datasets)
data(USArrests)
head(USArrests)

#산점도를 통해 변수간 상관관계 파악!!
# pairs() : 둘 이상의 변수에 대해 모든 가능한 산점도를 그려줌
pairs(USArrests, panel = panel.smooth, main = "USArrests data")


# ② 주성분분석 수행
US.prin<-princomp(USArrests, cor=TRUE)
summary(US.prin)               

# screeplot 그리기
# 주성분분석의 결과를 plot함수 인자값으로 지정하면 scree plot이 생성된다.
plot(US.prin,type='l')

# ③ Loading
US.prin$loadings               

# ④ Scores
US.prin$scores 

# ⑤ 제 1-2 주성분에 의한 행렬도
biplot(US.prin, scale=0)                


## 2. 요인분석

# Q) R의 내장 데이터 swiss는 1888년 경 스위스 내 47개 주의 사회 경제적 지표(교육, 농업 종사자 비율 등)와 
# 출산율에 대한 데이터이다. 원활한 분석을 위해 먼저 해당 데이터의 5가지 변수들을 min-max 정규화한 뒤, 
# 요인분석을 실시하여 변수들을 3개의 요인으로 축소해보자.(factanal 함수 사용)
#A)
# swiss 데이터 확인 
data(swiss)
str(swiss)

# 정규화 수행 및 실습용 데이터 생성
# apply(데이터, 계산방향, 적용함수) : 주어진 데이터의 행 혹은 열 방향으로 함수를 적용
Min <- apply(swiss,2,min) 
Max <- apply(swiss,2,max)
swiss_fa<-scale(swiss, center=Min, scale=(Max-Min)) # min-max scaling

head(swiss_fa)

# 요인분석 수행
# factanal함수 rotation 인자의 기본값은 "varimax"임
factanal(swiss_fa, factors=3) 



### 3절 | 표준화와 정규화


## 1. 표준화
# Q) R의 내장 데이터 ‘mtcars’의 mpg(마일)변수와 hp(총마력)변수로만 이루어진 
# 데이터프레임(test.cars)을 생성하고, 각 변수를 표준화한 새로운 변수를 추가해보자. 
# (mpg를 표준화한 변수의 이름은 mpg_scale, hp를 표준화한 변수의 이름은 hp_scale로 지정)
#A)
# 데이터 확인 
data("mtcars")
str(mtcars)

# 데이터프레임 생성
test.cars<-mtcars[,c("mpg","hp")]

# test.cars데이터의 상위 6개의 행 확인
head(test.cars)

# 표준화(스케일링)한 변수 추가
test.cars<-transform(test.cars,
                     mpg_scale=scale(test.cars$mpg),
                     hp_scale=scale(test.cars$hp))
head(test.cars)


## 2. 정규화

# 가. scale함수 이용
# scale 함수를 이용하여 R의 내장 데이터 iris의 Sepal.Length 변수를 정규화하는 코드를 살펴보자.
# iris데이터 Sepal.Length  변수의 최솟값 저장
Min<-min(iris$Sepal.Length)
# iris데이터 Sepal.Length 변수의 최댓값 저장
Max<-max(iris$Sepal.Length)
# scale함수를 활용한 min-max 표준화
iris$SL_new<-scale(iris$Sepal.Length, center=Min, scale=Max-Min)
head(iris)

## 나. 사용자 정의 함수 이용
# 정규화한 값을 반환하는 함수 정의
# x : 정규화하고자 하는 숫자형 벡터
normalize <-function(x) {
  return ((x-min(x)) / (max(x) -min(x)))
}
# 숫자형 벡터 생성
num<-c(50:500)
# 생성한 사용자 정의 함수를 이용하여 정규화 수행
num_new<-normalize(num) 
head(num_new)
