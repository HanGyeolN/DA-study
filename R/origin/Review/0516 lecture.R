rbind(c(1,2,3), c(4,5,6))
x<-data.frame(id=c(1,2),name=c("a","b"),stringsAsFactors = F)
x
str(x)

x
y<-rbind(x,c(3,"c"))
y

cbind(c(1,2,3), c(4,5,6))


a<-matrix(1:9,ncol=3)
a
apply(a,2,sum)#~자료에~함수를 적용해라

head(iris)
str(iris)
#1~4열까지 각 열의 합계 출력
apply(iris[ ,1:4], 2, sum)
apply(iris[ ,1:4], 2, mean)
apply(iris[ ,1:4], 2, max)
apply(iris[ ,1:4], 2, min)
apply(iris[ ,1:4], 2, sd)

rowSums(iris[,1:4])#colSums
rowMeans(iris[,1:4])#colMeans

res<-lapply(1:3, function(x) {x*2})
res

res[[3]]
class(res)#list

#list -> vector
res<-unlist(res)
res
class(res)


x<-list(a=1:3, b=4:6)
x

lapply(x, mean)

as.data.frame(lapply(iris[,1:4], mean))

class(iris[,1:4])
class(lapply(iris[,1:4], mean))
class(as.data.frame(lapply(iris[,1:4], mean)))

class(lapply(iris[,1:4], mean))#리스트
class(sapply(iris[,1:4], mean))#벡터
sapply(iris, class)

sapply(iris[,1:4], function(x){x>3})



tapply(1:10,rep(1,10),sum)
#tapply(벡터,그룹색인,그룹단위적용함수)      

1:10 %% 2==1
1 0 1 0 1 0...0
T F T F...    F

tapply(1:10,1:10%%2==1,sum)

tapply(iris$Sepal.Length,iris$Species,mean)

#doBy패키지:데이터를 그룹단위 처리
install.packages("doBy")
library(doBy)
summary(iris)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length,seq(0,1,by=0.1))

summaryBy(Sepal.Length+Sepal.Width~Species,iris)

iris[order(iris$Sepal.Length,iris$Sepal.Width,decreasing = TRUE), ]

orderBy(~Sepal.Width+Sepal.Length,iris)

sample(1:45, 6)#비복원추출
sample(1:45, 6, replace =TRUE)#복원추출

# 요구사항분석->계획
# data수집(db,web,...)
# data전처리(na,상관,차원축소(pca,lda,t-sne...),특징선택...)
# data분석(dplyr,..., numpy, pandas, seaborn, matplot...) -> EDA
# 모델링 알고리즘 선택(ML(kmeans,knn,dt,rf,...nn /DL(cnn,rnn,..reinforcement leanring.....)
# 모델링
# 모델(y=ax+b)
# validation check(k-fold)->TP,TN,FP,FN...
# 성능평가 -> 개선
# 척도:precision, recall, f-measure, support

NROW(iris)#150

iris[sample(NROW(iris), NROW(iris)),]

iris

sampleBy( ~Species,frac=0.1,data=iris)

class(split(iris, iris$Species))

subset(iris, Species=="setosa")

subset(iris, Species=="setosa" & Sepal.Length>5.0)

subset(iris, select=c(Species,Sepal.Length))
subset(iris, select=-c(Species,Sepal.Length))

iris[, !names(iris) %in% c("Species","Sepal.Length")]
#iris[,c("Species","Sepal.Length")]
names(iris)

x<-data.frame(name=c("a","b","c"),math=c(1,2,3))
y<-data.frame(name=c("c","b","a"),eng=c(4,7,9))

cbind(x,y)#단순 컬럼 연결
merge(x,y)#name 기준병합

x<-data.frame(name=c("a","b","c"),math=c(1,2,3))
y<-data.frame(name=c("c","b","d"),eng=c(4,7,9))
merge(x,y)
merge(x,y,all=TRUE)

x<-c(5,2,1,4,3)
sort(x)
sort(x,decreasing = TRUE)
x


x<-c(5,2,1,4,3)
order(x)
order(x,decreasing = TRUE)

data=list()
n=10
for(c in 1:n){
  data[[c]]=data.frame(Index=c,
                myChar=sample(letters,1),
                z=runif(1))
}
data




# df=data.frame(Index=1,
#            myChar=sample(letters,1),
#            z=runif(1))
# df

#여러 데이터 프레임 병합
#1. rbind
do.call(rbind,data)
class(do.call(rbind,data))

install.packages("plyr")
library(plyr)
#2. ldply
ldply(data, rbind)

#3. rbindlist
install.packages("data.table")
library(data.table)
rbindlist(data)

#rbindlist가 가장 빠름

mean(iris$Sepal.Length)
# mean(iris$Sepal.Length)
# mean(iris$Sepal.Length)
# mean(iris$Sepal.Length)


with(iris,{
  mean(Sepal.Length)
})

which(iris$Species=="setosa")

which.min(iris$Sepal.Length)
which.max(iris$Sepal.Length)

x<-c(7,7,5,5,5,3,3,7,3,7)
#x<-c(1,1,2,2,2,3,3,1,3,2)
#최빈수 출력
table(x)
which.max(table(x))
names(which.max(table(x)))

install.packages("RMySQL")
library(RMySQL)
con<-dbConnect(MySQL(),user="root",
               password="1234", host="127.0.0.1",
               dbname="rprogramming")
dbListTables(con)
df<-dbGetQuery(con, "select name from rtest2")
df

install.packages("mlbench")
library(mlbench)
data(Ozone)
head(Ozone)

plot(Ozone$V8, Ozone$V9,xlab="Temp1", ylab="Temp2",main="Ozone",pch="+", cex=0.5, col="#ff0000", col.axis="#0000ff",col.lab="#ff00ff",xlim=c(0,100),ylim=c(0,100))
#000000~ffffff
help(par)

min(Ozone$V8,na.rm=T)
min(Ozone$V9,na.rm=T)
max(Ozone$V8,na.rm=T)
max(Ozone$V9,na.rm=T)

cars
plot(cars)

plot(cars,type="l")
plot(cars,type="b")
plot(cars,type="o")

#speed로 그룹화->각 그룹별 dist평균 출력
#tapply함수 사용
ds<-tapply(cars$dist,cars$speed,mean)
plot(ds, xlab="speed", ylab="dist", type="o", cex=0.5, lty="dashed")

par()

myPar<- par(mfrow=c(2,1))
plot(Ozone$V8, Ozone$V9, main="Ozone")
plot(Ozone$V8, Ozone$V9, main="Ozone2")

par(myPar)#myPar설정하기 전으로 되돌아가는

plot(Ozone$V8, Ozone$V9, main="Ozone")

#ggplot2패키지 시각화
#1단계:배경(axes-axis,axis)
#2단계:그래프
#3단계:축,색상...

library(ggplot2)
#1.배경설정
ggplot(data=mpg, aes(x=displ, y=hwy))+
  geom_point()+
  xlim(0,10)+
  ylim(0,50)

#ggplot():세부조작
#qplot():간단 데이터 확인

library(dplyr)
#바 그래프 출력
df<-mpg %>% 
  group_by(drv) %>% 
  summarise(meanHwy=mean(hwy))
df
ggplot(data=df, aes(x=drv, y=meanHwy))+geom_col()

ggplot(data=df, aes(x=reorder(drv,meanHwy), y=meanHwy))+geom_col()
ggplot(data=df, aes(x=reorder(drv,-meanHwy), y=meanHwy))+geom_col()

#빈도 바 그래프
ggplot(data=mpg, aes(x=drv))+geom_bar()
ggplot(data=mpg, aes(x=hwy))+geom_bar()
#geom_col():평균->그래프
#geom_bar():빈도->그래프


#finance.yahoo.com

str(economics)
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()







