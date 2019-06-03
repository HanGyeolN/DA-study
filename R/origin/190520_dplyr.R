library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

# Welfare 불러오기
raw_welfare<-read.spss(file="Data/koweps.sav", to.data.frame = T)
welfare<-raw_welfare

rename(welfare, 
       sex = h10_g3,
       birth = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       income = p1002_8aq1,
       code_job = h10_eco9,
       code_region=h10_reg7
)->welfare

# welfare sex 추가하기
welfare$sex <- ifelse(welfare$sex==1, "male", "female")

# welfare age 추가하기 
welfare$age<-2019-welfare$birth+1

print(welfare$age)

# welfare ageg 추가하기
welfare %>% 
  mutate(ageg=ifelse(age<30,"young",
                     ifelse(age<=59,
                            "middle","old")))->
  welfare

# welfare ageg 그룹별 평균 데이터 생성
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(meanIncome=mean(income)) ->
  incomeByAgeg

# welfare 그룹별 소득 평균 그래프 생성
ggplot(data=incomeByAgeg, aes(x=ageg, y=meanIncome))+
  geom_col()

# welfare 그래프에서 순서 정렬하기
ggplot(data=incomeByAgeg, aes(x=ageg, y=meanIncome))+
  geom_col()+
  scale_x_discrete(limits=c("young","middle","old"))

# welfare 그룹별 소득 평균 데이터 생성
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(meanIncome = mean(income))->
  incomeBySex 

print(incomeBySex)

# welfare 그래프에서 성별 추가하기 
ggplot(data = incomeBySex, aes(x=ageg, y = meanIncome, fill = sex))+
  geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))

# welfare 성별 추가한 그래프에서 옆으로 추가하기
ggplot(data = incomeBySex, aes(x=ageg, y = meanIncome, fill = sex))+
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young","middle","old"))

# 
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(meanIncome = mean(income))->
  incomeByAge

print(incomeByAge)

# welfare 그래프에 두개의 그래프 출력하기
ggplot(data = incomeByAge, aes(x = age, y = meanIncome, col=sex)) +
  geom_line()

# welfare xlsx파일 읽어오기
welfare$code_job
jobCode<-read_xlsx("Data/Koweps_Codebook.xlsx", sheet = 2, col_names = TRUE) # o:col_names - 첫 줄에 인덱스가 있는경우, 2행부터 데이터를 읽는다.
jobCode

# welfare 객체 dim속성 확인하기 
dim(jobCode)
welfare$code_job
jobCode

# welfare 직업코드 join시키기
welfare <- left_join(welfare, jobCode, id="code_job")

welfare %>% 
  filter(!is.na(job)) %>% 
  select(code_job, job) %>% 
  head(15)

# welfare 그룹으로 나눠서 평균소득 구하기
welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(meanIncome = mean(income)) %>% 
  arrange(desc(meanIncome)) %>% 
  head(10) ->
  top10

top10

## welfare 
# 이름이 길면 가로막대가 좋다.
ggplot(data = top10, aes(x=job, y=meanIncome)) +
  scale_x_discrete() + 
  coord_flip() +
  geom_col()


# reorder 함수, reorder(정렬대상변수 -> factor , 연속형변수)
# 그래프 정렬해서 출력하기 
ggplot(data = top10, aes(x=reorder(job, meanIncome), y=meanIncome)) +
  scale_x_discrete() + 
  coord_flip() +
  geom_col()
  
# 오름차순 정렬하기
ggplot(data = top10, aes(x=reorder(job, -meanIncome), y=meanIncome)) +
  scale_x_discrete() + 
  coord_flip() +
  geom_col()

welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(code_job) %>% 
  summarise(meanIncome = mean(income)) %>% 
  arrange(meanIncome) %>% 
  head(10) ->
  bottom10

bottom10 <- left_join(bottom10,jobCode,"code_job")
bottom10

ggplot(data = bottom10, aes(x=reorder(job, -meanIncome), y=meanIncome)) +
  geom_col() +
  coord_flip()

ggplot(data = bottom10, aes(x=job, y=meanIncome)) +
  geom_col() +
  coord_flip()

ggplot(data = bottom10, aes(x=meanIncome, y=job)) +
  geom_col()
  
welfare %>% 
  filter(!is.na(job) & sex=="male") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% #갯수 세기 
  arrange(desc(n)) ->
  jobMale

View(jobMale)

welfare %>% 
  filter(!is.na(job) & sex=="female") %>% 
  group_by(job) %>% 
  summarise(n=n()) %>% #갯수 세기 
  arrange(desc(n)) ->
  jobFemale

View(jobFemale)  

class(welfare$religion)
table(welfare$religion)

welfare$religion<-ifelse(welfare$religion==1,"yes","no")
table(welfare$religion)

welfare$marriage

welfare$group_marrage <- ifelse(welfare$marriage==1, "marrage", ifelse(welfare$marriage==3, "divorce", NA))

table(welfare$group_marrage)
table(is.na(welfare$group_marrage))

# table함수는 NA가 안나옴. 
qplot(welfare$group_marrage)

help2 <- read_xlsx("Data/Koweps_Codebook.xlsx", sheet = 1, col_names = T)
help2 %>% 
  select("")


welfare$group_marrage

# 
welfare %>% 
  filter(!is.na(group_marrage)) %>% 
  group_by(religion,group_marrage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group,3)) ->
  religion_marriage


religion_marriage

# 각 권역별 연령대별 비율
welfare %>% 
  group_by(code_region, ageg)

data.frame(code_region = c(1:7),
           region = c("서울","경기","경남","경북","충청","강원","전라"))->
  list_region

# welfare 지역코드와 지역명 붙이기 
list_region
welfare$code_region
welfare <- left_join(welfare, list_region, id="code_region")

# 지역별 연령대 표
welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group=sum(n)) %>% 
  mutate(pct=round(n/tot_group*100,2))->
  region_ageg

print(region_ageg)

#60d 60d
ggplot(data = region_ageg, aes(x=region, y=pct, fill = ageg))+
  geom_col(position = "dodge")

region_ageg %>% 
  filter(ageg=="old") %>% 
  arrange(pct) ->
  old_pct

#

install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)
class(USArrests)

head(USArrests)
# 행 인덱스(Alabama ...) 열 인덱스(Murder Assault ...)는 데이터로 사용 못한다
# 사용하려면 따로 처리해줘야함
# 행 인덱스 데이터로 만들기
library(tibble)
crime<-rownames_to_column(USArrests, var="state")
head(crime)

tolower(crime$state) ->
  crime$state

states_map<-map_data("state")

install.packages("maps")
library(maps)
install.packages("mapproj")
library(mapproj)

states_map<-map_data("state")
ggChoropleth(data = crime, 
             aes(fill=Murder,
                 map_id=state),
             map = states_map)

# Plot 옵션
?points

plot(iris$Sepal.Width, iris$Sepal.Length, cex=.5, pch= 20, xlab="width", ylab="length", main="iris", col="#660033")

x<-seq(0,1,0.1)
x

y<-tan(x)
plot(x,y,xlim=c(0,100))
lines(x,y)

# xlim으로 그래프 길이 제한
plot(cars,xlim=c(0,25))
abline(a=5,b=3.5, col="red")

# plot에 새로운 라인을 출력
abline(h=mean(cars$dist))
abline(v=mean(cars$speed))

plot(4:6,4:6)
# plot의 5,5자리에 문자를 출력 
text(5,5,"000")

text(5,5,"023523503", adj=c(0,0))
text(5,5,"013", adj=c(0,1))
text(5,5,"130", adj=c(1,0))
text(5,5,"311", adj=c(1,1))

plot(cars, cex=.5)
text(cars$speed, cars$dist, pos=1)
# 클릭 옵션

identify(cars$speed, cars$dist)

plot(iris$Sepal.Width, iris$Sepal.Length, pch=20, xlab="width", ylab = "Length")
points(iris$Petal.Width, iris$Petal.Length, pch='+', xlab="width", ylab = "Length", col = "red")

# legend 넣기
legend("topright", legend=c("Sepal", "Petal"), pch=c(20,43), col=c("black","red"), bg = "gray")




