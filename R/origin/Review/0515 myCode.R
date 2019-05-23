# UTF - 8 #

library(dplyr)
library(magrittr)

?read.csv # na.strings 옵션: 


# 1. 테이블 합치기 
rbind(c(1,2,3), c(4,5,6))
x<-data.frame(id=c(1,2), name=c("a","b"), stringsAsFactors = F)
x

y<-rbind(x,c(3,"c"))
y

# 2. APPLY함수 사용하기 
?apply
a<-matrix(1:9, nrow = 3, ncol = 3)
a

apply(iris[1:4],2,sum)
iris_tbl<-as_tibble(iris)
iris_tbl
head(iris)

colSums(iris_tbl[,1:4])
res<-lapply(1:3, function(x) {x*2})
res[3]
class(res)

sapply(iris[,1:4], function(x){x>3})
rep(1,10)

tapply(iris$Sepal.Length,iris$Sepal.Width,mean)

install.packages("doBy")
library(doBy)

summary(iris)
quantile(iris$Sepal.Length,seq(0,1,by=0.99))

?summaryBy
summaryBy(Sepal.Length~Species, iris)

iris[order(iris$Sepal.Length,iris$Sepal.Width,decreasing = T),]
# order는 index가 출력된다.

sample(1:5, 1)
sample(150,1)

as_tibble(split(iris, iris$Species))

iris[, !names(iris) %in% c("Species","Sepal.Length")]
#선택적으로 열 추출 

iris[,"Species"]

x<-data.frame(name=c("c","b","a"), math=c(2,3,4))
y<-data.frame(name=c("c","b","a"), eng=c(4,7,9))
cbind(x,y)
merge(x,y)

x<-data.frame(name=c("c","b","a"), math=c(2,3,4))
y<-data.frame(name=c("c","b","d"), eng=c(4,7,9))

cbind(x,y)
merge(x,y)
merge(x,y,all=T)

x<-c(5,2,1,4,3)
x
x<-sort(x)
x
x<-sort(x,decreasing = T)
x
x<-arrange(x)
x
class(x)
x<-data.frame(x)
class(x)
desc(x)
arrange(desc(x))

order(x) # return index

data=list()
data
class(data)
typeof(data)

c=0
n=10
for(c in 1:n){
  data[[c]]<-data.frame(Index=c,
                 myChar=sample(letters,1),
                 z=runif(1))
}


df
print(data[1])

mean(iris$Sepal.Length)
with(iris,{
  mean(Sepal.Length)
})

iris$Species=="setosa"

which(iris$Species=="Setosa")
which.min(iris$Sepal.Length)

x<-c(1,1,2,2,2,3,3,1,3,3)
which.max(table(x))
x[which.max(table(x))]
table(x)
which.max(table(x)[2,])
a<-table(x)
a[3]
class(a)

# SQL 연동하기
install.packages("RMySQL")
library(RMySQL)
con<-dbConnect(MySQL(),user="root", password="1234", host="127.0.0.1", dbname="rprogramming") # DB까지 연결 
dbListTables(con)
a<-dbGetQuery(con, "select * from rtest2")
class(a)
typeof(a)
str(a)
a

install.packages("mlbench")
library(mlbench)
data(Ozone)
head(Ozone)
?Ozone
plot(Ozone$V8, Ozone$V9, xlab="Temp1", ylab="Temp2",main="Ozone", pch=20, cex=0.2, col="#7fcd9f", col.axis="#0000ff", col.lab="#7f9999", xlim=c(-100,100), ylim=c(-100,100))
help(par)

min(Ozone$V8, na.rm=T)
min(Ozone$V9, na.rm=T)
min(Ozone$V10, na.rm=T)
min(Ozone$V11, na.rm=T)

plot(cars)
library(dplyr)

a<-cars %>% 
  group_by(speed) %>% 
  summarise(distMean=mean(dist))

plot(a$speed, a$distMean, xlab="Temp1", ylab="Temp2",main="Ozone", pch=20, cex=1, col="#7fcd9f", col.axis="#0000ff", col.lab="#7f9999", type="o")

tapply(cars, 2, mean)

par()
myPar<-par(mfrow=c(1,2))
plot(Ozone$V8, Ozone$V9, main="Ozone")
plot(Ozone$V8, Ozone$V9, main="Ozone2")
par(myPar) 
par(mfrow=c(1,1))


str(cars)
##############################################################################3
library(dplyr)
library(magrittr)
library(tqk)
code<-code_get("all")
codeinstall_github("mrchypark/tqk")

code %>% 
  slice(grep("현대자동차", name)) %$% 
  tqk_get(code, from = "2019-01-01") ->
  hdc

plot(hdc$date,hdc$adjusted, type="l")

library(ggplot2)
ggplot(data=mpg, aes(x=displ, y=hwy))+
  geom_()+
  xlim(0,10)+
  ylim(0,50)

df<-mpg %>% 
  group_by(drv) %>% 
  summarise(meanHwy=mean(hwy))
class(df)
df
df<-as_tibble(df)
df
class(df)
ggplot(data=df, aes(x=reorder(drv,-meanHwy),y=meanHwy))+geom_col()
ggplot(data=mpg, aes(x=cty))+geom_bar()

economics
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()
