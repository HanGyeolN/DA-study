var1<-c(1,3,5,7,9) #벡터
var2<-c(1:5) #벡터
#벡터는 c함수를 이용해 만들 수 있다.

var3<-seq(1,5)
var3
#벡터는 seq함수를 이용해 만들수있다.

var4<-seq(1,5,2)
var4
#3번째 인자로 간격을 나눠줄수있다.

var5<-c(1:5,2)
var5

var6<-c(1:5,0.1)
var6

var7<-seq(1,5,0.1)
var7

var8=seq(1,5)
var8
var8=var8+1 #이런 연산도 가능.(벡터화 연산)
var8

print(var1+var2)

str1<-"a"
str2<-"text"
str3<-"hello world"

str4<-c(str1, str2, str3)
#벡터의 길이 

# str4+2 #에러


x<-c(1,2,3)
mean(x)

str4
paste(str4, collapse = ", ")

x<-c('ab','a','b','c')
x

qplot(x)

mpg

qplot(data=mpg, x=manufacturer, y=hwy)
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv, y=hwy, geom = "line")
# Front Wheel Drive
# Rear Wheel Drive (Rear: 후방)
qplot(data=mpg, x=drv, y=hwy, geom = "boxplot")
qplot(data=mpg, x=drv, y=hwy, geom = "boxplot", colour=drv)


# 연습문제 
# 3명의 점수가 80 90 50점이다.
# 변수 3개에 저장한다
# 변수 3개의 평균을 출력
# 벡터 하나에 저장한다
# 벡터 평균을 출력

a1<-80
a2<-90
a3<-50
mean1<-(a1+a2+a3)/3


v1<-c(a1,a2,a3)
vmean1<-sum(v1)/length(v1)



#데이터 프레임
eng<-c(90,100,70,60)
math<-c(50,60,100,9)
class(eng) # 파이썬 type함수

df<-data.frame(eng,math)
df
class(df)

df3<-data.frame(eng,math,class)
df3
#eng의 평균 출력
df3.eng
ef3[0]
df3[1]
sum(df3[1])
mean(df3[1])
length(df3[1])
df$eng
df3$class
mean(df3$math)

df4<-data.frame(eng<-c(1,2,3,4),math<-c(10,20,30,40),class<-c(1,2,3,4))
df4
df4<-data.frame(eng=c(1,2,3,4),math=c(10,20,30,40),class=c(1,2,3,4))
df4

mydata<-read.csv(file="googleplaystore.csv")

example02<-data.frame(fruitName=c('포도','사과','배'),price=c(1000,2000,500),rem=c(20,10,5))
example02Mean<-mean(example02$price)
example02Mean2<-mean(example02$rem)
example02
example02Mean
example02Mean2


df5<-read_excel("Data/excel_exam.xlsx")
df5$science
mean(df5$science)

df6<-read_xlsx("Data/excel_exam_novar.xlsx")
df6<-read_excel("Data/excel_exam_novar.xlsx", col_names = FALSE)

df7<-read_excel("Data/excel_exam_sheet.xlsx", sheet = 3)
df7


df8<-read.csv("Data/csv_exam.csv")
df8
str(df8)

df5<-data.frame(a=c(1,2,3),a=c(1,2,3),a=c(1,2,3))
df5

exam<-read.csv("Data/csv_exam.csv")
head(exam)
tail(exam)
exam[,3]
exam[3,]
View(exam)
dim(exam)
median(exam$math)
summary(exam)
# Mean < Median -> 극단적으로 낮은 값이 있다 라는 의미.

summary(mpg)
class(mpg)
head(mpg)
mpg<-as.data.frame(mpg) # 자료형 변환.
str(mpg)

df<-data.frame(var1=c(1,2,1),var2=c(2,3,2))
df
df_new <- df

qplot(test)



df
df8
df8
structure(df8)
str(df8)
df5<-data.frame(a=c(1,2,3),a=c(1,2,3),a=c(1,2,3))
df5
a.1
df5$a.1
write.csv(df5, file="df5.csv")
save(df5, file="df5_s.rda")
rm(df5)
df5
load("df5_s.rda")
df5
rm("df5")
rename
rename(df5,df6)
exam<-read.csv("Data/csv_exam.csv")
exam
head(exam)
tail(exam)
weist(exam)
exam(1)
exam["10"]
exam[1]
exam[1,1]
exam[,1]
exam
exam[2]
exam[:,2]
exam[2,:]
exam[2,2]
exam[3,3]
exam[:,3]
exam[,3]
exam[3,]
view(exam)
View(exam)
dim(exam)
size(exam)
exam.example
qplot(exam,geom="boxplot")
qplot(exam,geom="boxplot",x=math)
qplot(exam,geom="boxplot",x="math")
median(exam$math)
summary(exam)
summary(mpg)
class(mpg)
head(mpg)
mpg<-as.data.frame(mpg)
str(mpg)
View(mpg)
files
pwd
ls
test<-read("Data/Koweps_Codebook.xlsx")
test<-read_xlsx("Data/Koweps_Codebook.xlsx")
View(test)
test<-read_xlsx("Data/SongList.xlsx")
summary(test)
str(test)
test<-as.data.frame(test)
str(test)
df<-data.frame(var1=c(1,2,1),var2=c(2,3,2))
df
df_new <- df
qplot(test)
rename(df_new)
rename(df_new, v2=var2)
library(plyr)
rename(df_new, v2=var2)
df_new
rename(df_new, var2=var3)
rename(df_new, replace("var2" = "number"))
rename(df_new, replace("v2" = "number"))
help rename
rename(df_new, replace("var2"="f"))
df_new
rename(df_new, replace = c("var2"="f"))
install.packages("dplyr")
install.packages("dplyr")
install.packages("dplyr")
install.packages("dplyr")
library(dplyr)
install.packages("dplyr")
install.packages("dplyr")
library(dplyr)
df_new<-rename(df_new,v1=var1)
df_new
mydf<-data.frame(eng=c(70,80,90),mat=c(50,60,70))
mydf
mydf$sum<-mydf$eng+mydf$mat
mydf
mydf$avrerage<-mydf$sum/2
mydf
ㅡㅔㅎ
ㅎ
mpg
mpg$tot<-mpg$cty + mpg$hwy
mpg
View(mpg)
mpg$tot<-mpg$tot/2
View(mpg)
ok
TRUE
mpg$tot
mean(mpg$tot)
for(i)
for(var in mpg$tot)
+var
mpg$tot
sum=0
for(var in mpg$tot) sum=sum+var
sum
sum/length(mpg$tot)
summary(mpg$tot)
host(mpg$tot)
hist(mpg$tot)
mpg$grade<-ifelse(mpg$tot>=23,"gr_h","gr_l")
View(mpg)
table(mpg)
table9mpg$we
e awe wapofjaw
ef jwe
pfojweoa
p j\
table(mpg$test)
table(mpg$grade)
table(mpg$tot)
table(mpg$grade)
qplot(mpg$test)
qplot(mpg$greade)
qplot(mpg$grade)
library(qplot)
library(ggplot2)volkswagen<-mpg %>% filter(manufacturer="volkswagen")


library(qplot)
qplot(mpg$grade)

exam %>% filter(class!=3)
exam %>% filter(class!=3 & science>=50)
exam %>% filter(class!=3 & science>=50 & math >= 70)
exam %>% filter(class!=3 & science>=50 & math >= 70 | english>=90)
exam %>% filter(class!=3 & science>=50 & (math >= 70 | english>=90))
exam %>% filter(class!=3 & science>=50 & (math >= 70 | english>=90))
exam %>% filter(class %in% c(1,4,5))
exam %>% filter(class=3)
exam %>% filter(class==3)
a<-exam %>% filter(class==3)



mpg3<-mpg %>% filter(displ<=3)
mpg3
mpg5<-mpg %>% filter(displ>=5)
mpg5
mpg3_mean<-mean(mpg3$hwy)
mpg5_mean<-mean(mpg5$hwy)
mpg3_mean
mpg5_mean

volkswagen<-mpg %>% filter(manufacturer=="volkswagen")
volkswagen
audi<-mpg %>% filter(manufacturer=="audi")
audi
cty1<-mean(volkswagen$cty)
cty2<-mean(audi$cty)
cty1
cty2



