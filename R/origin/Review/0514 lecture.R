var1<-c(1,3,5,7,9)
var1+1 #벡터화 연산
var1
var2<-c(1:5)
var2

var1+var2#벡터화 연산(요소간 덧셈)

var3<-seq(1,5)
var3
var4<-seq(1,5,by=3)
var4

str1<-"a"
str2<-"text"
str3<-"hello world"

c(str1,str2)
str4<-c(str1,str2,str3)
str4+2
str1+str2 #오류 -> c함수 사용
#문자에 대해서는 이항연산자를 적용 못함

x<-c(1,2,3)
mean(x)
max(x)
min(x)

str4
paste(str4, collapse=",")
str5<-paste(str4, collapse=" ")

x_mean<-mean(x)
x_mean

install.packages("ggplot2")
library(ggplot2)

x<-c("a","a","b","c")
x

qplot(x)#빈도그래프

mpg

str(mpg)
qplot(data=mpg, x=hwy)

qplot(data=mpg, x=drv,y=hwy)

qplot(data=mpg, x=drv,y=hwy, geom="line")

qplot(data=mpg, x=drv,y=hwy, geom="boxplot")

qplot(data=mpg, x=drv,y=hwy, geom="boxplot", colour=drv)

#1.3명 점수(80,90,50)를 변수 3개 저장하세요.
#2.변수 3개에 저장된 값들의 평균점수 출력
s1<-80
s2<-90
s3<-50
avg<-(s1+s2+s3)/3
avg

s<-c(80,90,50)
avg<-mean(s)
avg

#데이터프레임:시트(행:한 사람의 정보, 열:속성)
eng<-c(90,100,70,60)
math<-c(50,60,100,9)
class(eng) #파이썬 type함수
data

df<-data.frame(eng)#eng 벡터, 열이 1개인 표
df
class(df)

df2<-data.frame(eng,math)#eng,math 벡터, 열이 2개인 표
df2
class(df2)
str(df2)

class<-c(1,1,2,3)
df3<-data.frame(eng,math,class)
df3

#eng의 평균 출력
mean(df3$eng)


df4<-data.frame(eng=c(90,100,70,60),
math=c(50,60,100,9),
class=c(1,1,2,3)) # <- 연산자 사용x
df4

df5<-data.frame(fruit=c("포도","사과","배"),
           price=c(1000,2000,500),
           volume=c(20,10,5))
df5
mean(df5$price)
mean(df5$volume)

# cafe.naver.com/ai4you
# 
# gspark@kw.ac.kr

install.packages("readxl")
library(readxl)

df<-read_excel("Data/excel_exam.xlsx")
df
mean(df$science)

df2<-read_excel("Data/excel_exam_novar.xlsx",col_names = F)
df2

df3<-read_excel("Data/excel_exam_sheet.xlsx", sheet=3)
df3

df4<-read.csv('Data/csv_exam.csv')
df4
str(df4)

df5<-data.frame(a=c(1,2,3),
                b=c(1,2,3),
                c=c(1,2,3))
df5

write.csv(df5, file="mydf.csv")
#파일 용량 작고 빠르게...
save(df5, file="mydf_s.rda")
rm(df5) #제거

df5
load("mydf_s.rda") #불러오기

df5

df6<-df5



exam<-read.csv("Data/csv_exam.csv")
exam

head(exam,10)
tail(exam)

View(exam)
str(exam)

dim(exam)

summary(exam)

a<-c(1,2,3,4)
median(a)

class(mpg)
head(mpg)

mpg<-as.data.frame(mpg)
str(mpg)
class(mpg)

View(mpg)
dim(mpg)
str(mpg)

summary(mpg)

#데이터 변경
df<-data.frame(var1=c(1,2,1),
           var2=c(2,3,2))
df
df_new <- df #데이터프레임 복사
df_new

library(plyr)
df_new<-rename(df_new, replace = c("var2"="v2"))
df_new

install.packages("dplyr")
library(dplyr)
df_new<-rename(df_new, v1=var1)
df_new

#변수(features
#제공되는 데이터 -> 가공 -> 새로운 변수(feature):파생변수

mydf<-data.frame(eng=c(70,80,90),
                 mat=c(50,60,70))
mydf$sum<-mydf$eng+mydf$mat
mydf

mydf$mymean<-mydf$sum/2
mydf

str(mpg)
mpg$tot<-(mpg$cty+mpg$hwy)/2
mpg$tot

head(mpg)
mean(mpg$tot)#tot컬럼 평균
summary(mpg$tot)

#삼항연산자
#if 조건식: 참: 거짓

#평균연비가(tot) 23이상이면-> gr_h, 미만이면 gr_l
mpg$test<-ifelse(mpg$tot>=23, "gr_h", "gr_l")
#ifelse(조건식, 참, 거짓)
mpg$test

table(mpg$test) #빈도표

qplot(mpg$test)

#tot
#28이상 -> grade:A
#20이상 28미만 -> grade:B
#나머지 -> grade:C
#ifelse(조건,참,ifelse(조건,참,거짓))
mpg$grade<-ifelse(mpg$tot>=28, "A", ifelse(mpg$tot>=20, "B", "C"))
mpg$grade

table(mpg$grade)
qplot(mpg$grade)

#library(dplyr)

exam<-read.csv("Data/csv_exam.csv")
exam
#filter기능:원하는 자료만 추출
exam %>% filter(class==3)

exam %>% filter(class!=3)
#3반이 아니면서, sci 50점이상

exam %>% filter(class!=3 & science>=50)
#math가 70점 이상 이거나 eng가 90점 이상인경우

exam %>% filter(math >=70 | english>=90)

#클래스가 1, 4, 5반 추출
exam %>% filter(class==1 | class==4 | class==5 )

exam %>% filter(class %in% c(1,4,5))

class3<-exam %>% filter(class==3)
mean(class3$english)

str(mpg)

#displ값이 3이하를 추출->mpg3
#displ값이 5이상을 추출->mpg5
#mpg3 hwy평균
#mpg5 hwy평균
mpg3<-mpg %>% filter(displ<=3)
mpg5<-mpg %>% filter(displ>=5)
mean(mpg3$hwy)
mean(mpg5$hwy)

head(mpg$manufacturer,10)
table(mpg$manufacturer)
#volkswagen과 audi중 cty(도시연비)
#가 평균적으로 어디가 더 높은지 출력
mpgv<-mpg %>% filter(manufacturer=="volkswagen")
mpga<-mpg %>% filter(manufacturer=="audi")

mean(mpgv$cty) #20.92
mean(mpga$cty) #17.61

#현대(hyundai), 쉐보레, 닛산 => 데이터추출
#cty의 전체 평균

mpgd<-mpg %>% filter(manufacturer %in% c("chevrolet", "hyundai","nissan"))
mean(mpgd$cty)

#컬럼 추출 : select함수
exam %>% select(science)

exam %>% select(science,math,class)

exam %>% select(-science, -math)

# %>% : dplyr패키지 설치&로드된 상태에서 사용가능

#3반 추출 -> math 추출
imsi<-exam %>% filter(class==3)
#imsi$math
#imsi %>% select(math)

exam %>% 
  filter(class==3) %>% 
  select(math) %>%
  head(2)

exam %>% arrange(math)

exam %>% arrange(desc(math))

exam %>% arrange(math, english)

exam %>% arrange(class, science)






