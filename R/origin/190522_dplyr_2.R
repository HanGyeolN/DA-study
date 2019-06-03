# github 다운로드 패키지 
install.packages("devtools")
install_github("cardiomoon/kormaps2014")

callLibrary<-function(){
  library(devtools)
  library(kormaps2014)
  library(ggplot2)
  library(ggiraphExtra)
  library(dplyr)
}


#################################################################
# 인코딩 문제 처리
korpop1<-changeCode(korpop1)
View(korpop1)



rename(korpop1, pop="총인구_명", name="행정구역별_읍면동") ->
  korpop1

# 지도
ggChoropleth(data = korpop1, # 지도에 표시할 데이터
             aes(fill=pop, # 색상별로 표현할 변수 = pop
                 map_id=code, # 지역 기준 = code
                 tooltip=name), # 지도 위 표시할 지역 이름
             map=kormap1, # 사용할 지도에대한 정보
             interactive = T # Interactive 
             )


##
tbc<-kormaps2014::tbc
str(changeCode(tbc))
tbc<-changeCode(tbc)
View(tbc)

ggChoropleth(data = tbc,
             aes(fill=NewPts,
                 map_id=code,
                 tooltip=name),
             map=kormap1,
             interactive = T)


# Interactive 하지 않은 그래프 
install.packages("plotly")
library(plotly)
ggplot(data=mpg,
        aes(x=displ,y=hwy,col=drv))+
  geom_point()

# Interactive 그래프 만들기 

p<-ggplot(data=mpg,
       aes(x=displ,y=hwy,col=drv))+
  geom_point()

ggplotly(p) ###

str(diamonds)
View(diamonds)
ggplot(data = diamonds, aes(x=cut,fill=clarity)) +
  geom_bar(position = "dodge")

###
library(tqk)
library(magrittr)
code<-code_get("all")
code %>% 
  glimpse()

code %>% 
  group_by(market) %>% 
  summarise(n())

code %>% 
  slice(grep("멀티캠퍼스", name)) %$%
  tqk_get(code, from = "2019-01-01") %>% 
  arrange(desc(date)) ->
  multicampus
View(multicampus)

###
# 
ggplot(data = multicampus, aes(x = date, y=adjusted)) +
  geom_line() -> g

ggplotly(g)



## 시계열 그래프(dygraphs) 그리기
install.packages("dygraphs")
library(dygraphs)
library(xts)
eco<-xts(economics$unemploy,
         order.by = economics$date)
dygraph(eco)

# 시계열 그래프 범위 선택 옵션 주기 
dygraph(eco) %>% 
  dyRangeSelector()

# 여러개의 값을 그래프에 나타내기
xts(economics$psavert,
    order.by=economics$date) ->
  eco_a
xts(economics$unemploy/1000,
    order.by=economics$date) ->
  eco_b

eco2 <- cbind(eco_a, eco_b) # 동일 인덱스끼리 bind된다.

head(eco2) 
# 행 인덱스가 eco_a, eco_b인게 거슬림
colnames(eco2)
# 행 이름이 출력됨
colnames(eco2)<-c("psavert","unemploy")
head(eco2)
# 행이름이 바뀜

dygraph(eco2) %>% 
  dyRangeSelector()

# -- 
mtc<-xts(multicampus$adjusted,
         order.by = multicampus$date)
dygraph(mtc) %>% 
  dyRangeSelector()

exam<-read.csv("Data/csv_exam.csv")

# 2번째 열 추출
exam[2,]
# 클래스가 1인 행 추출
exam %>% 
  filter(class==1)
# Boolean값으로 참조하기
str(exam$class)
exam[exam$class==1,]
# 수학 80이상 행 추출
exam[exam$math>=80,]
exam[exam$class==2 & exam$english>=70,]

exam[exam$english<90 | exam$science<50,]

exam[,1]
exam[,c("class","math")]
exam[5,"math"]
exam[exam$math>=50,c("english","science")]
exam
exam[exam$math>=50 & exam$english>80,]

exam %>% 
  filter(math>=50 & english>=80) %>% 
  mutate(mean = (math+english+science)/3) %>% 
  group_by(class) %>% 
  summarise(myMean=mean(mean)) # 집계함수 


exam$mean<-(exam$math + exam$english + exam$science)/3
?aggregate

exam$class == 1


exam[math>=50]

aggregate(data = exam[exam$math>=50 & exam$english>=80,], mean~class,mean)

mpg %>% 
  filter(class=="suv" | class=="compact") %>% 
  group_by(class) %>% 
  mutate(tot = (hwy+cty)) %>% 
  select("class","tot")

mpg %>% 
  filter(class=="suv" | class=="compact") %>% 
  group_by(class) %>% 
  summarise(meanTot=mean())

var1 = c(1,2,3,1,2)
var2 <- factor(c(1,2,3,1,2))
var1 # numbers
var2 # factors

var1+1
var2+1

levels(var1)
var3 <- c("1","2","3","1","2")
var4 <- factor(c("1","2","3","1","2"))

var3 = c(1,2,"a","c",0.34)
var3
var4

matrix(c(1:10), ncol=2)->c
array(c(1:10), dim=c(5,2))->b
list(f1=c(1:5),f2=c(6:10))->a
a
rownames(c)
colnames(c)
a


##
myvector<-c(1:6,'a')
myvector

mylist<-list(1:6,"a")
mylist<-list(c(1:4),c(6:10))
mylist
mylist<-list(1,2,mylist)
mylist
mylist[[3]][[1]][2]

unlist(mylist)

myvector<-c(1:6,'a')
mylist<-list(1:6,'a')
unlist(mylist)==myvector
mylist[[1]][1:6]







# list -> vector
unlist()

# list 조회
list[[1]][1:6]

#
name<-c('갑','을','병','정')
gender<-c(2,1,1,2)
mydata<-data.frame(name, gender)
attributes(mydata)
# 
mydata$name


# 데이터 설명해주는 함수 
attr(mydata$name, "what the variable means")<-"이름"
mydata$name
View(mydata)

attr(mydata$gender, "what the vriable means")<-"성별"
mydata$gender

mydata$gender.character<-attr(mydata$gender,"what the")
mydata
mylist<-list(1:4,6:10,list(1:4, 6:10))
lapply(mylist,mean)
mtlist


wordlist<-c("the","is","a","the")
doc1freq<-c(3,4,2,4)
doc2freq<-rep(1,4)
tapply(doc1freq,wordlist, length)
tapply(doc2freq,wordlist, length)
tapply(doc1freq,wordlist, sum)
tapply(doc2freq,wordlist, sum)
doc1freq
doc2freq


######################################################################################

a<-"the function to be applied to each element of X: see ‘Details’. In the case of functions like +, %*%, the function name must be backquoted or quoted."


sent1<-c("earth", "to", "earth")
sent2<-c("ash", "to", "ash")
sent3<-c("dust", "to", "dust")
wordlist<-c(sent1,sent2,sent3)
wordlist
table(wordlist)

myfreq<-c(rep(1,length(sent1)),rep(1,length(sent2)),rep(1,length(sent3)))

myfreq
sent1
tapply(myfreq, c(sent1,sent2,sent3), sum)

tapply()

what<-function(x){
  print(class(x))
  print(str(x))
  View(x)
}

mysentence<-"Learning R is so interesting"
what(mysentence[1])

mysentence<-"Learning R is so interesting"
strsplit(mysentence, split=" ") ->
  myWords
len <- length(myWords[[1]])

myLetters=list()
for (i in 1:len){
  myLetters[i] <- strsplit(myWords[[1]][i], split="")
}
what(myLetters)
myLetters

what(myWords)

mywords<-strsplit(mysentence, split=" ")

mywords
strsplit(mywords[[1]][5], split="")

myletters <- list()
for(i in mywords){
  myletters[i]<-print(strsplit(i,split=""))
}

myletters

mywords2<-list()
for(i in 1:5){
  mywords2[i]<-paste(myletters[[i]],collapse ="")
}
mywords2

a<-c("a","b")
what(a)
paste(a,collapse = "")

R_wiki<-"R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls, surveys of data miners, and studies of scholarly literature databases show that R's popularity has increased substantially in recent years.
R is a GNU package. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. While R has a command line interface, there are several graphical front-ends available."
rWiki<-R_wiki
strsplit(rWiki, split="\n") -> rWikiPara
length(rWikiWord)
rWikiSent

strsplit(rWikiPara[[1]], split="\\. ") -> rWikiSent

strsplit(rWikiSent[[1]], split=" ") -> rWikiWord

strsplit(rWikiWord[[1]], split="") -> rWikiLett

rWikiWord<-strsplit(rWikiSent[[1]],split=" ")

rWikiWord

library()
mySent<-"Learning R is so intersting"
gregexpr('ing', mySent)
?regexpr

as.vector(regexpr('ing', mySent)) ->
  loc.begin

for (i in rWikiPara){
  print(i)
  strsplit(i, split=)
}

loc.begin<-as.vector(regexpr('ing',mySent))
loc.length<-attr(regexpr('ing',mySent),"match.length")
loc.end<-loc.begin+loc.length-1

loc.end <- loc.begin + loc.length - 1
as.vector(regexpr('ing', mySent))
as.vector(gregexpr('ing', mySent)) -> a
View(a)

regexec('so (interest)', mySent)
rWikiSent
mysentences<-unlist(rWikiSent)
mysentences
gregexpr("software", mysentences)->myTemp
as.vector(myTemp)->my.begin
my.begin[my.begin==-1]<-NA
my.begin<- as.vector(my.begin)
my.begin
my.length <- attr(gregexpr('software',mySent),"match.length")
my.length
my.end <- my.begin + my.length -1

length(my.begin)
mylocs <- matrix(NA, nrow=length(my.begin), mylocs)

colnames(mylocs) <- c('begin', 'end')
rownames(mylocs) <- paste('sentence', 1:length)
mylocs

cbind(my.begin[2], my.end[2])

my.begin
for (i in 1:length(my.begin)){
  mylocs[i,]
}

# 문장 list들에서 원하는 단어가 있는지 확인하기 
mysentences
grep('software',mysentences)
grepl('software',mysentences)


# 문장 1개에서 원하는 단어 찾아서 치환하기
stat(mysentence)
str(mysentence)
class(mysentence)
head(mysentence)

sub('ing', 'ING', mysentence)
mysentence

sent1 <- rWikiSent[[1]][1]
sent1
# 고유명사화 : _붙이면 고유명사화 시킨거임 
gsub("R Foundation for Statistical Computing", "R_Foundation_for_Statistical_Computing",sent1) ->
  new.sent1
sent1
sum(table(strsplit(new.sent1,split=" ")))

# 조사, 특정단어 제거
gsub("and |by |for |the ","",new.sent1) ->
  drop.sent1
sum(table(strsplit(drop.sent1,split=" ")))

# 패턴 저장하기기
mypattern <- regexpr('ing',mysentence)
#패턴과 매치되는 문자열 추출
regmatches(mysentence, mypattern)
# 여러개
gregexpr('ing',mysentence) -> mypattern
regmatches(mysentence, mypattern)
# invert 옵션: 해당 패턴을 제외한 것을 추출
mypattern<-regexpr('ing',mysentence)
regmatches(mysentence, mypattern, invert =TRUE)

# ing 앞에 글자 보기
my2sentence <- c("Learning R is so intersting", "He is a fascinating singer")
mypattern1 <- gregexpr("[[:alpha:]]{1,}(ing)", my2sentence) # {1,} 1글자 ~ 무한대
regmatches(my2sentence, mypattern1)

# ing로 끝나는거 보기
my2sentence <- c("Learning R is so intersting", "He is a fascinating singer")
mypattern2 <- gregexpr("[[:alpha:]]{1,}(ing)\\b", my2sentence)
regmatches(my2sentence, mypattern2)

# +는 {1,}과 같은 의미
mypattern3 <- gregexpr("[[:alpha:]]+(ing)\\b", my2sentence)
regmatches(my2sentence, mypattern3)

# 대소문자를 일괄 통일

mypattern <- gregexpr("[[:alpha:]]+(ing)\\b", tolower(mysentences))
myings<-regmatches(tolower(mysentences),mypattern)
myings
table(unlist(myings))

#
mysentences<-unlist(rWikiSent)

#1
mysentences
mypattern01 <- gregexpr("(stat)[[:alpha:]]{1,}", tolower(mysentences))
p01 <- regmatches(tolower(mysentences), mypattern01)
table(unlist(p01))

#Sol 대소문자 구분 없이
gregexpr("(stat)[[:alpha:]]+",tolower(mysentences)) ->
  mypattern
regmatches(tolower(mysentences), mypattern) -> my.alphas

table(unlist(my.alphas)) -> mytable

#대소문자 구분
mypattern<-gregexpr("[[:upper:]]", mysentences) # mysentences에서 모든 "대문자"를 뽑아온다.
regmatches(mysentences, mypattern) ->  my.uppers
my.uppers

mypattern<-gregexpr("[[:lower:]]", mysentences) # mysentences에서 모든 "대문자"를 뽑아온다.
regmatches(mysentences, mypattern) -> my.lowers
my.lowers

table(unlist(my.lowers))->mt # 리스트를 풀고 빈도수를 조사한다.
my.lowers[mt == max(mt)]

# ----------------그래프 그리기 ---------------
pressure<-datasets::pressure
pressure$
ggplot(pressure, aes())
# x축은 온도, y축은 압력으로 하고싶다.
ggplot(pressure, aes(x=temperature, y=pressure)) +
  geom_point(color='red') +
  # 선을 입히고 싶다.
  geom_line()
  # 색을 바꾸고 싶다.

# 점이 위로 가도록 하고싶다.
ggplot(pressure, aes(x=temperature, y=pressure)) +
  # 선을 입히고 싶다.
  geom_line(size=2, color='deepskyblue') +
  # 색을 바꾸고 싶다.
  geom_point(size=2,color='red') +
  # 이름을 주고싶다.
  ggtitle('pressure data') +
  # x, y축에도 이름을 주고싶다.
  xlab('Temperature') +
  ylab('Pressure') +
  # 배경 테마를 바꾸고싶다.
  theme_bw()# theme_classic()  theme_grey()
  
# 막대 그래프를 만들고싶다.
# 1. x축만 지정 -> 빈도
# 빈도수 막대그래프를 만들고싶다.
ggplot(diamonds, aes(cut))

ggplot(diamonds, aes(cut)) +
  geom_bar()

# default가 count이고 y축은 빈도수를 의미한다.
ggplot(diamonds, aes(cut)) +
  geom_bar(stat='count')

# 일반 막대 그래프를 만들고싶다.
View(sleep)
# x,y를 길게쓰기 귀찮다.
ggplot(sleep, aes(ID, extra))

ggplot(sleep, aes(ID, extra)) +
  geom_bar(stat='identity') # statistc = 'identity' -> y축을 기반으로 만들겠다.
# ID별로 extra값이 합쳐진다. 

# 자동으로 합쳐지는 값들을 구분하고싶다.
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity')

# 옆으로 떨어지게 해서 구분하고싶다.
ggplot(sleep, aes(ID, extra, fill=group)) +
  geom_bar(stat='identity', position="dodge")

View(diamonds)
# 빈도수를 출력하고, 그안에서 다른 기준으로 그룹을 구분하고싶다. 
ggplot(diamonds, aes(color, fill=cut)) +
  geom_bar()

# 구분 한것에 대한 비율을 시각화 하고싶다.
ggplot(diamonds, aes(color, fill=cut)) +
  geom_bar(position="fill") 
  # 색이 J이면 Fair 비율이 높다. 라는 것을 알 수 있다.

# 가로로 눕혀서 출력하고싶다.
# x축 이름이 너무 길어서 겹친다.
ggplot(diamonds, aes(color, fill=cut)) +
  geom_bar(position="fill") +
  coord_flip()

#---------------------------
# dataFrame이 아닌 데이터를 그래프로 그리고 싶다.
mydata<-data.frame(mytable)
class(mydata)
View(mydata)

# 빈도수 그래프를 만들고 싶다.
ggplot(mydata, aes(x=Var1, y=Freq)) +
  geom_bar(stat='identity')

# 색을 채우고싶다.
ggplot(mydata, aes(x=Var1, y=Freq, fill=Var1)) +
  geom_bar(stat='identity')

# 옆에 fill guide 범례를 없애고싶다.
ggplot(mydata, aes(x=Var1, y=Freq, fill=Var1)) +
  geom_bar(stat='identity') +
  guides(fill=FALSE)


# ------------190522 연습문제-----------------

# 대소문자 구분 없이
gregexpr("[[:lower:]]",tolower(mysentences)) ->
  mypattern
regmatches(tolower(mysentences), mypattern) -> my.alphas



max(table(unlist(my.alphas))) # 빈도수에서 가장 큰 수
table(unlist(my.alphas))["max(table(unlist(my.alphas)))"]

#2 가장 많이 등장한 문자.
paste(mysentences[1:7],collapse = "")->words
gsub(" and | by | for | the | a |\\.|\\,|\\'| is | of | are | in "," ",words) -> words2
strsplit(words2, split=" ")->words3
words3<-tolower(words3)
words3
table(words3)->words4
as.data.frame(words4)->words4

words4 %>% 
  arrange(desc(words4$Freq)) %>% 
  filter(words3!="has" & words3!="a") %>% 
  head(10)

# Sol.2 



#3
words <- tolower(words)
gsub("\\.|\\,|\\'|\\-| ","",words)->words5
strsplit(words5,split="")->words6
length(words6[[1]])

#4
table(words6) -> words7
as.data.frame(words7) -> words7
words7 %>% 
  arrange(desc(Freq)) %>% 
  head(10)

#-------------------------------------
grepe
