install_github("mrchypark/tqk")

library(tqk)

?code_get
?tqk_get

code<-code_get("all")
codeinstall_github("mrchypark/tqk")


library(dplyr)
library(magrittr)

code %>% 
  glimpse()

code %>% 
  group_by(market) %>% 
  summarise(n())

code %>% 
  slice(grep("현대자동차", name)) %$% 
  tqk_get(code, from = "2019-01-01") ->
  hdc

arrange(hdc,desc(date))
?tqk_get

iris
head(iris)
as_tibble(iris)

select(hdc, date, volume)
hdc

?read.csv # 파일을 data.frame으로 읽는다. 

do.call(rbind,data)
class(data)
View(data)

install.packages("plyr")
library(plyr)

ldply(data, rbind)
install.packages("data.table")
library(data.table)
rbindlist(data)
