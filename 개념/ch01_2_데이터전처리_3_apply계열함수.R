## 3장. 데이터 결합 및 요약


##### 1절 | 데이터 결합

##### 1. rbind

## Q) id와 last_name이라는 변수로 이루어진 두 개의 데이터프레임을 생성한 후, 
## 두 데이터프레임을 행 기준으로 결합하여 고객의 아이디와 성을 저장하고 있는 
## 하나의 데이터프레임으로 만들어 보자. 

##===== A)
# 행으로 묶을 데이터 생성 : rbind를 사용할 때에는 열의 이름과 개수가 동일해야 함
customer1 <- data.frame(id = c("c01","c02","c03","c04"),
                        last_name = c("Lee", "Kim", "Choi", "Park"))

customer2 <- data.frame(id = c("c05", "c06", "c07"), 
                        last_name = c("Lim" , "Bae", "Kim"))

# rbind를 사용하여 두 데이터프레임을 결합
id_name <- rbind(customer1, customer2)    
id_name    


##### 2. cbind

## Q) 고객의 나이(age)와 수입(income)을 담고 있는 데이터(age_income)를 새로 생성하고, 
## rbind 함수 예제에서 생성했던 id_name 데이터와 열을 기준으로 결합하여 customer 데이터를 만들어보자.

##===== A)
# 열로 묶을 데이터 생성 : cbind를 사용할 때에는 행의 개수가 동일해야 함
# age변수와 income변수로 구성된 데이터프레임 생성
age_income <- data.frame(age = c(20, 25, 37, 40, 32, 45, 37), 
                         income = c(2500, 6400, 0, 7000, 3400, 3800, 5010))

# cbind를 사용하여 두 데이터프레임을 결합
customer <- cbind(id_name, age_income)     
customer


##### 3. merge
## Q) 고객의 아이디(id), 이름(name)으로 이루어진 데이터프레임(id_name)과 고객의 아이디(id), 
## 번호(number)로 이루어진 데이터프레임(id_number)을 생성한 뒤, 다양한 방법으로 두 데이터를 병합해 보자.

##===== A)
# 병합에 사용할 데이터프레임 생성
id_name <- data.frame(id = c("c01","c02","c03","c04","c05", "c06", "c07"), 
                      last_name = c("Lee", "Kim", "Choi", "Park", "Lim" , "Bae", "Kim"))

id_number <- data.frame(id = c("c03", "c04", "c05", "c06", "c07", "c08", "c09"), 
                        number = c(3, 1, 0, 7, 3, 4, 1))

# id_name, id_number 데이터프레임 확인
id_name
id_number


## Q1) id 칼럼을 기준으로 두 테이블이 모두 공통된 값을 가지고 있는 경우에만 
## 두 데이터(id_name, id_number)를 병합해 보자. (데이터베이스의 Inner Join에 해당)
merge(id_name, id_number, by = 'id')


## Q2) 공통된 값이 없는 경우에도 데이터가 출력되도록 id 칼럼을 기준으로 두 데이터(id_name, id_number)의 
## 모든 행을 병합해 보자. (데이터베이스의 Outer Join에 해당)
# 기준칼럼에 공통된 값이 없는 경우, 다른 변수 값 자리에는 NA가 채워짐
merge(id_name, id_number, by = 'id', all = T) 


## Q3) id 칼럼을 기준으로 두 데이터(id_name, id_number)를 병합하는데, 기준칼럼에 공통 값이 없는 경우에는 
## id_name 데이터를 기준으로 병합해보자. (데이터베이스의 Left Outer Join에 해당)
merge(id_name, id_number,  by = 'id', all.x = T)


## Q4) id 칼럼을 기준으로 두 데이터(id_name, id_number)를 병합하는데, 
## 기준칼럼에 공통 값이 없는 경우에는 id_number 데이터를 기준으로 병합해보자. 
## (데이터베이스의 Right Outer Join에 해당)
merge(id_name, id_number, by = 'id', all.y = T)




##### 2절 | 데이터 요약

##### 1. aggregate

## Q1) iris 데이터에서 종별 Sepal.Width의 평균을 구해보자.
aggregate(Sepal.Width~Species, iris, mean)

## Q2) iris 데이터에서 종별 Sepal.Width, Petal.Width 의 평균을 한 번에 구해보자.
aggregate(cbind(Sepal.Width, Petal.Width)~Species, iris, mean)


##### 2. table

## Q1) 내장데이터 Titanic은 타이타닉호 탑승자들의 특성에 따른 생존여부를 기록해놓은 데이터이다.
## Titanic이 데이터에서 좌석등급을 의미하는 Class 변수에 대해서 도수분포표를 생성해보자.

##===== A)
# 내장데이터 Titanic의 구조 확인
str(Titanic)

# 분석을 위해 Titanic 데이터를 데이터프레임으로 변환한 뒤 다시 한번 구조를 확인
# as.data.frame() : 객체를 데이터프레임으로 변환
Titanic<-as.data.frame(Titanic)   

str(Titanic)   # 데이터 구조가 데이터프레임으로 변환되었음을 확인 가능

# table함수를 이용하여 범주형 변수 Class에 대한 도수분포표를 생성
table(Titanic$Class)


## Q2) 내장데이터 Titanic에서 Survived 변수는 승객의 생존여부를 의미한다. 
## 좌석등급과 생존여부의 관계를 살펴보기 위해 
## Class 변수에 따른 Survived 변수의 도수를 표 형태로 나타내보자.
table(Titanic$Class, Titanic$Survived)


##### 3. prop.table

## Q) Titanic 데이터에서 Age 변수는 해당 승객이 어른인지 아이인지의 여부를 나타낸다. 
## Age 변수에 따른 생존여부의 관계를 전체에 대한 비율, 행별 비율, 열별 비율로 살펴보자.

##===== A)
# Age에 따른 Survived에 대한 비율을 파악
prop.table(table(Titanic$Age, Titanic$Survived))

# 행 별 비율 파악
prop.table(table(Titanic$Age, Titanic$Survived), 1)  

# 열 별 비율 파악
prop.table(table(Titanic$Age, Titanic$Survived), 2)  


##### 4. subset

## Q) 내장데이터 iris에서 종(Species)이 setosa이면서, 
## Sepal.Length의 값이 5.5초과인 데이터들의 Species와 Sepal.Length 변수값만 조회해보자. 

##===== A)
subset(iris,
       subset = (Species=='setosa' & Sepal.Length > 5.5),
       select = c(Species,Sepal.Length))




##### 3절 | apply 계열 함수

##### 1. apply

## Q1) 4행 3열로 이루어진 행렬을 만든 후에 각 행별로 max 값을 구해보자.
a <- matrix(1:12, nrow=4, ncol=3)        # matrix 생성 
apply(a, 1, max)                         # 1은 행 방향, 2는 열 방향으로 계산함을 의미

## Q2) iris 데이터의 1~4열에 대해서 평균을 구해보자.
apply(iris[,1:4], 2, mean) 



##### 2. lapply
## Q) lapply함수를 사용하여 숫자가 저장된 벡터의 값을 제곱한 뒤 리스트 형태로 반환해보자.

##===== A)
a <- c(1,2,3)                      # a는 1,2,3의 숫자가 저장된 벡터
lapply(a, FUN=function(x){x^2})    # FUN인자의 값으로 제곱을 계산해주는 사용자 정의 함수를 사용

# 데이터구조 확인하기 : lapply 함수의 적용 결과 반환되는 데이터는 리스트임을 알 수 있음
class(lapply(a, FUN=function(x){x^2})) # class() : 객체의 물리적 자료형 반환 

# 만약 리스트로 반환된 결과를 벡터로 변환하고 싶다면 unlist함수를 이용하여 원하는 결과를 얻을 수 있음
b<-lapply(a, FUN=function(x){x^2})     # lapply를 적용한 결과를 변수 b에 저장
unlist(b)                              # unlist함수를 이용하여 리스트 b를 벡터로 변환



##### 3. sapply
## Q1) iris 데이터에서 각 컬럼별 데이터 타입을 구해보자.
sapply(iris, class)

# 데이터구조 확인 : 변수마다 함수를 적용한 결과 값이 하나씩 존재하므로 문자형 벡터로 반환
class(sapply(iris, class))  # “character”는 문자를 저장한 벡터를 의미


## Q2) iris 데이터에서 각 컬럼에 summary함수를 적용해보자.
sapply(iris, summary)       # summary() : 데이터의 기초 통계량을 요약해주는 함수           

# 데이터구조 확인 : 변수마다 함수를 적용한 결과 값의 길이가 다르므로 리스트로 반환
class(sapply(iris, summary))



##### 4. vapply
## Q) 1~100까지의 숫자가 저장된 리스트에 fivenum함수를 적용한 후, 
## 각 값에 이름을 부여하여 리스트 형태로 출력해보자.

##===== A)
# fivenum() : 최소값, 1사분위수, 중위수, 3사분위수, 최대값을 차례로 출력
# 1~100까지의 숫자가 저장된 벡터 생성
test <- c(1:100)

# fivenum 함수를 적용
fivenum(test)

# vapply를 이용하여 fivenum 함수를 적용하는데, 출력되는 결과의 형식(Template)을 원하는대로 지정
test <- list(test) #출력형태를 리스트로 변환

#출력되는 결과의 양식(Template)을 Min, Q1, Median, Q3, Max 로 지정
test2 <- vapply(test, fivenum, c("Min" = 0, "Q1" = 0, "Median" = 0, "Q3" = 0, "Max" = 0))
test2



##### 5. mapply
## Q) 1을 4번, 2를 3번, 3을 2번, 4를 1번 반복하는 4개의 수열을 구해보자. 
## 이 때 rep 함수를 이용할 때와 mapply 함수를 이용 할 때를 비교해보자.

##===== A)
# 1) rep을 사용할 경우 총 4번의 R 코드를 실행해야 한다.
#   rep(x, times, ... )
#   x: 반복할 객체, times: 반복횟수
rep(1,4)
rep(2,3)
rep(3,2)
rep(4,1) 


# 2) mapply를 사용할 경우 1번의 R 코드 실행으로 동일한 결과를 얻을 수 있다. 
# rep함수의 x 인자값 : c(1:4), times 인자값 : c(4:1)
mapply(rep, c(1:4), c(4:1))     



##### 6. tapply
## Q1) R의 googleVis 패키지에 있는 Fruits 데이터에서 과일종류(Fruit)별 판매량(Profit)의 평균을 구해보자.

# googleVis 패키지의 Fruits 데이터를 이용하기 위해 패키지 설치 및 로드
install.packages("googleVis")
library(googleVis)

# Fruits 데이터의 상위 6개의 행 확인
head(Fruits)

# tapply 함수를 이용하여 과일종류별 판매량의 평균 산출
tapply(Fruits$Sales, Fruits$Fruit, mean)


## Q2) Fruits 데이터에서 Location이 West인 것과 아닌 것으로 그룹을 지정하여 Profit의 평균을 구해보자.

# INDEX인자에 비교구문을 사용하여 그룹을 지정
tapply(Fruits$Profit, Fruits$Location=="West", mean)
