# 1-1
mpg<-as.data.frame(ggplot2::mpg)
mpg_copy<-mpg
mpg_copy$sum<-mpg_copy$cty+mpg_copy$hwy
str(mpg_copy)

# 1-2
mpg_copy$avr <- mpg_copy$sum/2
str(mpg_copy)

# 1-3
mpg_copy
mpg_copy<-arrange(mpg_copy,desc(avr))
head(mpg_copy,3)

# 1-4
mpg<-mpg %>% mutate(total=mpg$cty+mpg$hwy, avr=total/2)
str(mpg)

# 1-5
a<-mpg %>% 
  group_by(class) %>% 
  summarise(meanCty=mean(cty))

# 1-6
arrange(a,desc(meanCty))

# 1-7
b<-mpg %>%
  group_by(manufacturer) %>% 
  summarise(meanHwy=mean(hwy))

b<-arrange(b,desc(meanHwy))
head(b,3)

# 1-8
c<-mpg %>% filter(class=="compact")
c<-table(c$manufacturer)
c<-as.data.frame(c)
c<-arrange(c,desc(Freq))
c

# 2-1
mw<-midwest
mw$kidsPerTotal <- ((mw$poptotal - mw$popadults)/mw$poptotal)*100
str(mw)

# 2-2
mw<-arrange(mw,desc(kidsPerTotal))
View(mw)

# 2-3
mw$grade<-ifelse(mw$kidsPerTotal>=40 , "large", ifelse(mw$kidsPerTotal >= 30, "middle", "small"))
View(mw)
table(mw$grade)

# 2-4
mw$asianPerTotal <- (mw$popasian / mw$poptotal) * 100
mw<-arrange(mw,asianPerTotal)
mw[1:10,c("state","county","asianPerTotal")]

# 3-1
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"] <- NA
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# 3-2
mpg %>% 
  filter(!is.na(mpg$hwy)) %>% 
  group_by(drv) %>% 
  summarise(meanHwy = mean(hwy)) %>% 
  arrange(desc(meanHwy))

# 4-1

mpg<-as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"] <- "k"
mpg[c(29,43,129,203), "cty"] <- c(3,4,39,42)

table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% "k", NA, mpg$drv )
table(mpg$drv)

# 4-2
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty <= 9 | mpg$cty >= 26, NA, mpg$cty)
boxplot(mpg$cty)

