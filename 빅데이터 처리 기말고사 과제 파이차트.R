#20173147 이명진  
# 지역별 로드킬 분포 파이차트
city <- c("수도권", "강원", "충북","대전충남", "전북","광주전남","대구경북","부산경남")
pm25 <- c(51, 141, 98, 208, 36, 15, 14, 4) #지역별 로드킬 사고건수   
colors <- c("red", "orange", "yellow", "green", "lightblue", "blue", "violet")

pie(pm25,
    labels=city,
    col=colors,
    main="지역별 로드킬 사고 분포",
    init.angle=190, clockwise=T)
#######################
install.packages("RColorBrewer")
library(RColorBrewer)
blues <- brewer.pal(7, 'Blues')
pct <- round(pm25/sum(pm25)*100, 0)
city_label <- paste(city, ", ", pct, "%", sep="")
pie(pm25,
    labels=city_label,
    col=blues,
    main="지역별 로드킬 사고 분포",
    init.angle=190, clockwise=T)
