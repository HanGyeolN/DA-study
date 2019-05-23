# 2019 - 05 - 17 Day.4 #

library(foreign)
library(ggplot2)
library(KoNLP)
library(dplyr)
library(rJava)
library(stringr)
library(wordcloud)

ggplot(data = mpg, aes(x = drv, y = cty )) + # 배경 ->
  geom_boxplot() 

# Text Mining : 모을수록 패턴이 보임 
# 의미, 주제, 반응별 분류
# 베이지안 필터로 분류기를 만들 수 있다.
# RNN 
# 텍스트 마이닝으로 분석하는 방법/
# 작업 순서: 
# 1. 형태소 분석
# 2. 품사 단어 추출
# 3. 품사 단어별 빈도표 작성
# 4. 시각화
# 5. 머신러닝 모델링
# 6. 분류/예측
# 말뭉치 (CORPUS) : 분석 대상 문서들의 집합.
# > 문서 > 단락 > 문장 > 단어 > 형태소

# Word Cloud

install.packages("rJava")
install.packages("KoNLP")

library(KoNLP)
library(dplyr)
library(rJava)

useNIADic()

txt<-readLines("Data/hiphop.txt")
class(txt)
as_tibble(txt)

install.packages("stringr")
library(stringr)

tolower("Eye for eye")

# 문자개수 세기
nchar('korea')
nchar('대한민국')

sentence <- "Learning R is so interesting"

splits<-strsplit(sentence, split=' ')

# 리스트참조

splits[[1]][1]

splitss<-strsplit(splits[[1]][1], split = '')

a<-list()

for (i in 1:5){
  a[i]<-strsplit(splits[[1]][i], split = '')
}

myletters<-a

paste(myletters[[1]],collapse = "$")

mywords <- list()

for (i in 1:5){
  mywords[i] <- paste(myletters[[i]],collapse = "")
}

mywords

mywords <- paste(mywords, collapse = " ")

mywords

rwiki <- "R is a programming language and free software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing.[6] The R language is widely used among statisticians and data miners for developing statistical software[7] and data analysis.[8] Polls, data mining surveys, and studies of scholarly literature databases show substantial increases in popularity in recent years.[9]. as of May 2019, R ranks 21st in the TIOBE index, a measure of popularity of programming languages.[10]
A GNU package,[11] source code for the R software environment is written primarily in C, Fortran and R itself,[12] and is freely available under the GNU General Public License. Pre-compiled binary versions are provided for various operating systems. Although R has a command line interface, there are several graphical user interfaces, such as RStudio, an integrated development environment.[13][14]"

rwiki_para <- strsplit(rwiki, split="\n")

class(rwiki_para)
rwiki_para[[1]][1]

#문단 -> 문장
rwiki_string <- list()
rwiki_string <- strsplit(rwiki_para[[1]][1], split = "\\.")
rwiki_string

rwiki_sent = rwiki_string

#문장 -> 단어
rwiki_sent[[1]][1]
strsplit(rwiki_sent[[1]][1], split=" ")

test <- rwiki_sent[[1]][2]
test

fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")

?`regular expression`


test = "R?is# a100 programming한 lan"
test <- str_replace_all(test, "\\W", " ")

test

##
txt_origin <- readLines("Data/hiphop.txt")

txt<-txt_origin

txt <- str_replace_all(txt,"\\W"," ")
txt

extractNoun("멀티캠퍼스는 강남구 역삼동에 위치합니다.")

nouns<-extractNoun(txt)
nouns

table(nouns)
# 빈도수를 조사할 수 없다.
# 벡터화 해야함

nouns<-unlist(nouns)
nouns

library(ggplot2)
wordcount<-table(nouns)
wordcount<-as_tibble(wordcount)

wordcount<-sort(wordcount)

df<-as.data.frame(wordcount)
str(df)
df
df[1600:1700,]
str(df)

# 변수명 바꾸기
df<-rename(df, word=nouns, freq=n)
str(df)



# 1글자짜리 제거
df<-str_replace_all(df$word,"[a-z,A-Z]","a")
str(df)

as.character(df)

df<-as.data.frame(df)
df
df<-filter(df, nchar(word)>=2)
str(df)


# 빈도수 출력
# df %>% 
#   arrange(desc(freq)) ->
#   a

df %>% 
  arrange(desc(freq)) ->
  a



head(a,20)
nchar(a[[1]][1])

# 단어구름
install.packages("wordcloud")
library(wordcloud)
library(ggplot2)
?RColorBrewer

pal<-brewer.pal(3, "Dark2")

wordcloud(words = df$word, freq = df$freq, min.freq = 5, max.words = 50, colors=pal, random.order = F)


text<-read.csv("Data/twitter.csv", header = T, fileEncoding = "UTF-8")

text<-rename(text, no=번호, id=계정이름, date=작성일, tw=내용)
str(text)

text$tw <- str_replace_all(text$tw, "\\W", " ")
text<-as_tibble(text)
text$tw

nouns<-extractNoun(text$tw)
nouns

wordcount<-table(unlist(nouns))
class(wordcount)

df<-as.data.frame(wordcount, stringsAsFactors = F)
df
str(df)

df<-rename(df, word=Var1, freq=Freq)
df<-filter(df,nchar(word)>=2 & freq>=2)
df

str(df)
df <- df %>% arrange(desc(freq))
top20<-head(df,20)

wordcloud(top20$word,top20$freq)

arrange(top20, freq)$word

order <- arrange(top20, freq)$word

library(ggplot2)
ggplot(data=top20, aes(x=word,y=freq))+
  ylim(0,2500)+
  geom_col()+
  geom_text(aes(label=freq), hjust = -1) +
  scale_x_discrete(limit=order) +
  coord_flip()

#############

pal<-brewer.pal(8,"Set1")
wordcloud(words = df$word,
          freq = df$freq,
          colors=pal, 
          random.order = F,
          min.freq = 10,
          max.words = 100)


### 데이터 분석

library(foreign)
library(readxl)

a<-read.spss("Data/Koweps.sav", to.data.frame=T)
a<-as_tibble(a)
welfare<-a

str(welfare)

View(welfare)

summary(welfare)

rename(welfare, 
       sex = h10_g3,
       birth = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       income = p1002_8aq1,
       code_job = h10_eco9,
       code_region=h10_reg7
       )->welfare
str(welfare)

# Q. 성별에 따라 월급 차이?
# 1. 전처리
table(welfare$sex)

# 성별에 0이 들어가 있는 경우에는 NA로 처리

# welfare$sex <- ifelse(welfare$sex == 0, NA, welfare$sex)
table(is.na(welfare$sex))

welfare$sex <- ifelse(welfare$sex==1, "male", "female")
welfare<-as_tibble(welfare)
welfare

qplot(welfare$sex)

class(welfaer$income)

summary(welfare$income) #값이 여러개라 빈도수를 구하는 table 함수 x
qplot(welfare$income)+
  xlim(0,1000)

welfare$income
ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(meanIncome=mean(income)) ->
  sex_income
sex_income
ggplot(data=sex_income, aes(x=sex, y=meanIncome)) +
  geom_col()

# Q. 몇살때 최고급여?
summary(welfare$birth)
table(is.na(welfare$birth))
# welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)

welfare$age<-2019-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(meanIncome=mean(income)) ->
  age_income

head(age_income)
ggplot(data=age_income, aes(x=age,y=meanIncome)) +
  geom_col()
  

# welfare %>% 
#   group_by(age) %>% 
  

welfare$generation <- ifelse(welfare$age<=20,"미성년",
                             ifelse(welfare$age<=40,"청년",
                                    ifelse(welfare$age<=60,"중년","노년")))

welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(generation) %>% 
  summarise(meanIncome = mean(income)) ->
  tt

ggplot(data=tt, aes(x=generation,y=meanIncome)) +
  geom_col()

# 2.
welfare %>%
  filter(!is.na(income)) %>% 
  group_by(code_job) %>% 
  summarise(meanIncome=mean(income)) %>% 
  arrange(desc(meanIncome))->
  tt2

head(tt2)

tt3<-read_xlsx("Data/Koweps_Codebook.xlsx", sheet = 2)

str(tt3)
t<-which(tt3$code_job %in% c(120))


tt3[which(tt3$code_job %in% c(tt2[[1]][1])),2] # 직업 명 출력
tt2$job_name <- tt3[which(tt3$code_job %in% c(tt2$code_job)),2]
head(tt2,10)->tt5
tt5


ggplot(data=tt5, aes(x=job_name, y=meanIncome)) +
  geom_col()



























































































































































