# 1
sol1<-mpg %>% select(class, cty)
print(sol1)

# 2
cty_suv <- mpg %>% filter(class=="suv")
cty_suv <- mean(cty_suv$cty)
cty_suv

cty_compact <- mpg %>% filter(class=="compact")
cty_compact <- mean(cty_compact$cty)
cty_compact

# 3
audi <- mpg %>% filter(manufacturer=="audi")
audi <- audi %>% arrange(desc(hwy))
audi[1:5,]

# 4
midwest <- as.data.frame(midwest)
str(midwest)
View(midwest)

# 5
midwest <- rename(midwest, total=poptotal)
str(midwest)
midwest <- rename(midwest, asian=popasian)

# 6
midwest$asianpertotal = (midwest$asian/midwest$total)*100
hist(midwest$asianpertotal)

# 7
asianRateMean <- mean(midwest$asianpertotal)
print(asianRateMean)
midwest$asianrate <- ifelse(midwest$asianpertotal>=asianRateMean,"large","small")
View(midwest)

# 8 
table(midwest$asianrate)
qplot(midwest$asianrate)
