library(ggplot2)
library(dplyr)
library(foreign)

# Preprocessing the data
raw_welfare<-read.spss("Koweps.sav", to.data.frame=TRUE)
welfare<-raw_welfare

welfare<-rename(welfare,
                sex=h10_g3,
                birth=h10_g4,
                marriage=h10_g10,
                religion=h10_g11,
                income=p1002_8aq1,
                code_job=h10_eco9,
                code_region=h10_reg7)
welfare$age <- (2019 - welfare$birth)
welfare$income<-ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

# Income comparison based on age group

welfare$ageGroup <- with(welfare, {
  ifelse(age>=60, "60대 이상", 
         ifelse(age>=50, "50대", 
                ifelse(age>=40, "40대", 
                       ifelse(age>=30, "30대", 
                              ifelse(age>=20, "20대", "20대 미만")))))
})

ageGroupIncome <- welfare %>% 
  group_by(ageGroup) %>% 
  filter(!is.na(income)) %>% 
  summarise(meanIncome=mean(income))

ggplot(data=ageGroupIncome, aes(x=ageGroup, y=meanIncome)) +
  geom_col()

# Income comparison based on job code

jobIncome <- welfare %>% 
  group_by(code_job) %>% 
  filter(!is.na(code_job) & !is.na(income)) %>%
  summarise(meanIncome=mean(income))
  
ggplot(data=jobIncome, aes(x=code_job, y=meanIncome)) +
  geom_col()
