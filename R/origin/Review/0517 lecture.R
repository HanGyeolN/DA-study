library(ggplot2)
ggplot(data=mpg, aes(x=drv,y=cty))+
  geom_boxplot()
#텍스트마이닝(text mining)
#의미,주제,감성,...분류
#베이즈이론->베이지안필터기,RNN
# 
# #분석절차
# 1)형태소 분석
# 2)품사 단어 추출
# 3)빈도표 작성
# 4)시각화
# #머신러닝
# 5)알고리즘 선택
# 6)모델
# 7)모델-> 분류/예측/카테고리화
# #음성생성,텍스트생성,챗봇,
# #햄/스팸, 
# 
# 말뭉치(CORPUS):분석 대상 문서들의 집합
# > 문서 > 단락 > 문장 > 단어 > 형태소


install.packages("rJava")
install.packages("KoNLP")
library(KoNLP)
library(dplyr)
library(rJava)

useNIADic()

txt<-readLines("Data/hiphop.txt")
txt
txt<-str_replace_all(txt,"\\W"," ")
#특수문자 제거
txt

extractNoun("멀티캠퍼스는 강남구 역삼동에 위치합니다")

nouns<-extractNoun(txt)
nouns

#리스트1~6200번
#각 리스트에 저장된 단어들에 대한 빈도
#벡터화...
wordcount<-table(unlist(nouns))
class(wordcount)

df<-as.data.frame(wordcount,stringsAsFactors =F)
str(df)
df<-rename(df, word=Var1, freq=Freq)
str(df)
#nchar("hello")
df<-filter(df, nchar(word)>=2)
str(df)

# df %>% 
#   arrange(freq) %>% 
#   tail(10)

df %>% 
  arrange(desc(freq)) %>% 
  head(20)

install.packages("wordcloud")
library(wordcloud)

pal<-brewer.pal(10, "Dark2")
wordcloud(words=df$word, freq=df$freq, min.freq = 3, max.words = 100,colors=pal,scale=c(4,0.3),random.order=F)

str(df)


#arrange(desc(df$freq))







letters
LETTERS

letters[5]

install.packages("stringr")
library(stringr)

tolower("Eye for eye")
toupper("Eye for eye")

nchar('korea')
nchar('대한 민국')

mysentence<-"Learning R is so interesting"
mystr<-strsplit(mysentence, split=" ")
mystr[[1]]
mystr[[1]][1]
mystr[[1]][5]

#단어 -> 문자로 분리
strsplit(mystr[[1]][5],split="")




myletters<-list(rep(NA,5))
myletters

for (i in 1:5){
  myletters[i]<-strsplit(mystr[[1]][i],split="")
}
myletters

paste(myletters[[1]],collapse = "")

myletters[[5]]

mywords<-list()
for(i in 1:5){
  mywords[i]<-paste(myletters[[i]],collapse = "")
}
mywords

paste(mywords,collapse = " ")

rwiki<-"R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity in recent years.[9]. as of May 2019, R ranks 21st in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] source code for the R software environment is written primarily in C, Fortran and R itself,[12] and is freely available under the GNU General Public License. Pre-compiled binary versions are provided for various operating systems. Although R has a command line interface, there are several graphical user interfaces, such as RStudio, an integrated development environment"
rwiki

rwiki_para<-strsplit(rwiki,split="\n")
rwiki_para
class(rwiki_para)
str(rwiki_para)

#문단 -> 문장

#strsplit(rwiki_para[[1]]


rwiki_para[[1]]

rwiki_sent<-strsplit(rwiki_para[[1]], split="\\.")

#문장->단어 분리
rwiki_sent

rwiki_sent[[1]][1]
strsplit(rwiki_sent[[1]][1], split=" ")

test<-"R?is# a100 programming한 language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing"
test<-str_replace_all(test,"\\W"," ")
test<-str_replace_all(test,"\\d"," ")
test






str_replace_all()
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
str_replace_all(fruits, "[aeiou]", "-")
str_replace_all(fruits, "[aeiou]", toupper)


text<-read.csv("Data/twitter.csv",header = T, fileEncoding = "UTF-8")
text
str(text)
library(stringr)
library(ggplot2)
library(dplyr)
text<-rename(text, no=번호, id=계정이름, 
             date=작성일, tw=내용)
str(text)
text$tw<-str_replace_all(text$tw, "\\W", " ")
head(text$tw)
library(KoNLP)

nouns<-extractNoun(text$tw)
nouns

wordcount<-table(unlist(nouns))

df<-as.data.frame(wordcount, stringsAsFactors = F)
str(df)

df<-rename(df, word=Var1, freq=Freq)
dfword<-filter(df, nchar(word)>=2)
str(dfword)

top20<-dfword %>% 
  arrange(desc(freq)) %>% 
  head(20)

library(ggplot2)

top20
order<-arrange(top20, freq)$word 
ggplot(data=top20, aes(x=word,y=freq))+
  ylim(0,2500)+
  geom_col()+
  scale_x_discrete(limit=order)+
  coord_flip()+
  geom_text(aes(label=freq), hjust=-0.3)

library(wordcloud)
pal<-brewer.pal(8,"Dark2")
wordcloud(words=df$word,
          freq=df$freq,
          colors=pal,
          min.freq = 10,
          max.words = 100,
          random.order=F)

install.packages("foreign")
library(foreign)
library(readxl)
#spss
raw_welfare<-read.spss(file="Data/koweps.sav", to.data.frame = T)
welfare<-raw_welfare
str(welfare)
View(welfare)
summary(welfare)

#성별, 태어난 연도,혼인,종교,급여,
#직종코드,지역코드
welfare<-rename(welfare,
       sex=h10_g3,  #성별
       birth=h10_g4, #연도
       marriage=h10_g10, #혼인여부
       religion=h10_g11, #종교
       income=p1002_8aq1, #급여
       code_job=h10_eco9, #직종코드
       code_region=h10_reg7) #지역 코드드
str(welfare) 

#성별에 따라 월급 차이?
class(welfare$sex)
table(welfare$sex)
#성별에 0이 들어가 있는 경우에는 NA로 처리
#welfare$sex<-ifelse(welfare$sex==0,NA,welfare$sex)

table(is.na(welfare$sex))

welfare$sex<-ifelse(welfare$sex==1,"male","female")
table(welfare$sex)

qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)

qplot(welfare$income)+
  xlim(0,1000)

#0, 9999
welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

table(is.na(welfare$income))
#na : 12030 => 12044

#성별에 따른 월급 차이 분석하기
sex_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(meanIncome=mean(income))

sex_income
ggplot(data=sex_income, aes(x=sex, y=meanIncome))+  geom_col()

#몇 살때 최고급여?
summary(welfare$birth)
table(is.na(welfare$birth))

welfare$birth<-ifelse(welfare$birth==9999, NA, welfare$birth)
table(is.na(welfare$birth))

welfare$age<- 2019-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

#나이에 따른 평균 급여
age_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(meanIncome=mean(income))
head(age_income)
ggplot(data=age_income,aes(x=age,y=meanIncome))+
  geom_line()











