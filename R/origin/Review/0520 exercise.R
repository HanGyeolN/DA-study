library(dplyr)
library(readxl)
library(foreign)
# 1
# welfare 불러오기 

welfareO <- read.spss(file = "Data/Koweps.sav", to.data.frame = T)
welfare <- welfareO
View(welfare)
rename(welfare, 
       sex = h10_g3,
       birth = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       income = p1002_8aq1,
       code_job = h10_eco9,
       code_region=h10_reg7
)->welfare

codeBook <- read_xlsx("Data/Koweps_Codebook.xlsx", col_names = T, sheet = 2)

# 직업, 종교유무 추가 
welfare <- left_join(welfare, codeBook, "code_job")

table(welfare$religion)
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")

# 종교, 직종, 직종 수 뽑아오기
welfare %>% 
  filter(!is.na(job) & !is.na(religion)) %>% 
  group_by(religion, job) %>% 
  summarise(n=n()) %>% 
  select("religion", "job", n)->
  jobByRel

# 종교 유무에 따른 직종 순위 정렬
jobByRel %>% 
  filter(religion == "yes") %>% 
  arrange(desc(n))

jobByRel %>% 
  filter(religion == "no") %>% 
  arrange(desc(n))


# ============================
# 변수명 바꾸기 
welfare <- welfareO
welfare <- rename(welfare, code_region=h10_reg7,
                  income=p1002_8aq1)

# 지역코드 데이터프레임 만들기 
region <- data.frame(code_region = c(1:7), region = c("서울","경기","경남","경북","충청","강원","전라"))

# welfare에 지역명 추가
welfare <- left_join(welfare, region, "code_region")

# 지역별 평균 임금 순위로 정렬하기
welfare %>% 
  filter(!is.na(income) & !is.na(region)) %>% 
  group_by(region) %>% 
  summarise(meanIncome=mean(income)) %>% 
  arrange(desc(meanIncome))


# ============================
# 3. 
ttn <- read.csv("Data/titanic.csv")

ttn %>% 
  filter(!is.na(Pclass) & !is.na(Survived)) %>%
  group_by(Pclass) %>% 
  summarise(total=n()) ->
  tt2

ttn %>% 
  filter(!is.na(Pclass) & !is.na(Survived)) %>% 
  group_by(Pclass) %>% 
  filter(Survived == 1) %>% 
  summarise(survivor=n())->tt3

tt2<-left_join(tt2,tt3,"Pclass")
tt2$survivRate<-tt2$survivor/tt2$total*100
tt2


# =============================
# 4.Sex별 생존자 비율

ttn %>% 
  filter(!is.na(Sex)) %>% 
  group_by(Sex) %>% 
  summarise(total=n()) ->
  tt3

ttn %>% 
  filter(!is.na(Sex)) %>% 
  group_by(Sex, Survived) %>% 
  filter(Survived == 1) %>% 
  summarise(surv=n()) ->
  tt4

tt3 <- left_join(tt3,tt4,"Sex")
tt3 %>% 
  mutate(surviveRate = round(surv/total*100,2)) ->
  tt3

tt3

# =============================
# 5. sibsp/parch별 생존자 비율
View(ttn)

table(ttn$SibSp)
table(ttn$Parch)

ttn %>% 
  filter(!is.na(Survived) & !is.na(SibSp)) %>% 
  group_by(SibSp, Survived) %>% 
  summarise(n=n()) %>% 
  mutate(total = sum(n)) %>% 
  mutate(survivRate = round(n/total*100,2)) %>% 
  filter(Survived == 1) ->
  tt5

tt5

# =============================
# 6. 항구별 생존자 비율

table(ttn$Embarked)

ttn %>% 
  filter(!is.na(Survived) & !is.na(Embarked) & Embarked != "") %>% 
  group_by(Embarked, Survived) %>% 
  summarise(n=n()) %>% 
  mutate(total = sum(n)) %>% 
  mutate(survivRate = round(n/total*100,2)) %>% 
  filter(Survived == 1) ->
  tt6

tt6
