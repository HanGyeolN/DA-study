# 190520 Review
library(ggplot2)
library(dplyr)

mpg<-as.data.frame(ggplot2::mpg)
mpg_copy$sum<-mpg_copy$cty+mpg_copy$hwy
str(mpg_copy)

# 1-2
mpg_copy$avr <- mpg_copy$sum/2
str(mpg_copy)

# 1-3
mpg_copy
mpg_copy<-arrange(mpg_copy,desc(avr))
head(mpg_copy,3)

# 새로운 col 추가, 정렬
mpg_copy %>% 
  mutate(total=cty+hwy,
         mymean=total/2) %>% 
  arrange(desc(mymean)) %>% 
  head(3)

# 클래스별 평균 [Group_by], 정렬
mpg %>% 
  group_by(class) %>% 
  summarise(meanCty = mean(cty)) %>% 
  arrange(desc(meanCty)) ->
  ctyPerClass

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(meanHwy = mean(hwy)) %>% 
  arrange(desc(meanHwy))->
  hwyPerManu 
print(hwyPerManu)

# 빈도수, 정렬
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) # 47개 행, 5개 그룹을 확인할수 있다.

mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count=n()) %>% 
  arrange(desc(count))
# 모두 dplyr함수

mpg %>% filter(class=="compact") %>% 
  do(as.data.frame(table(mpg$manufacturer)))

c<-table(c$manufacturer)
c<-as.data.frame(c)
c<-arrange(c,desc(Freq))
c

midwest %>% 
  mutate(ratio_child=(poptotal-popadults)/poptotal*100) %>% 
  arrange(desc(ratio_child)) %>% 
  select(county, ratio_child) %>% 
  head(5)


midwest %>% 
  select(county,poptotal,popadults) %>% 
  head(5) %>% 
  arrange(desc(poptotal))

midwest %>% 
  select(county, state, popasian, poptotal) %>% 
  mutate(ratio_asian=(popasian/poptotal)*100) %>% 
  arrange(desc(ratio_asian)) %>% 
  head(10)

mpg %>% 
  filter(!is.na(hwy))

# 원하는 값이 있는지 확인하기 
"f" %in% mpg$drv

# 조건에 따라 가져오기
filter
# 원하는 그룹단위로 계산하기
group_by, summarise


