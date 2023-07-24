#20173147 이명진

install.packages("ggmap")
install.packages("ggplot2")
install.packages("openxlsx")
library(ggmap)
library(ggplot2)
library(openxlsx)
register_google(key ="AIzaSyA3OuHF9iggF9pTj5LLRA_16YhyksrC1mY")
df <- read.xlsx(file.choose(), sheet=1, startRow=2)
head(df)

df2 <- data.frame(lon=df[,11], lat=df[,10],freq=df[,7]) # 위도,경도, 사고 빈도수 데이터가 들어있는 10열, 11열,7열
                                                         #만으로 df2 데이터 프레임 생성
str(df2)
head(df2)

df2[,1] <- as.numeric(as.character(df2[,1])) #Factor로 되어 있는 데이터 유형을 계산이 수가능한 숫자형으로 변환
df2[,2] <- as.numeric(as.character(df2[,2]))
df2[,3] <- as.numeric(as.character(df2[,3]))
str(df2)

#지도 중심 좌표 설정
cen <- c((max(df2$lon)+min(df2$lon))/2, #위도의 최댓값+최솟값/2 = 위도 중심 값,경도의 최댓값+최솟값/2 = 경도 중심 값
         (max(df2$lat)+min(df2$lat))/2)
cen
# 지도 출력
map <- get_googlemap(center=cen, zoom=8)
gmap <- ggmap(map)
gmap + geom_point(data=df2,
                  aes(x=lon, y=lat),
                  color="blue",
                  size=df2$freq,
                  alpha=0.6)



