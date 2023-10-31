csapsel <- read.csv2("Egyek/csapössz.csv")
csapsel.xts <- xts(csapsel[,4], as.Date(csapsel[,1], format = "%Y.%m.%d"))

## Teljes időszak: '2022-04-14 23:50:00/2023-08-31'
intervallum <- '2023-06-25/2023-08-31'
intervallum <- '2023-05-01/2023-06-23'
intervallum <- '2022-12-22/2023-03-01'
intervallum <- '2022-11-01/2022-12-20'
## 2022-05-01/2022-08-31
intervallum <- '2022-05-01/2022-06-24'
intervallum <- '2022-06-26/2022-08-31'
## '2021-11-01/2022-02-28' adathiányig
## intervallum <- '2021-11-01/2021-11-26' négy óránként
intervallum <- '2021-11-30/2021-12-27'

oh2rech.w <- White(ohat2jav.xts[intervallum], Sy = 0.134)
plot.White(oh2rech.w)
oh2.slope <- oh2rech.w$results[,1]
select <- !coredata(csapsel.xts[intervallum])[,1]
oh2.slope[select]

intervallumok <- c('2023-06-25/2023-08-31'
,'2023-05-01/2023-06-23'
,'2022-12-22/2023-03-01'
,'2022-11-01/2022-12-20'
## 2022-05-01/2022-08-31
,'2022-05-01/2022-06-24'
,'2022-06-26/2022-08-31'
## '2021-11-01/2022-02-28' adathiányig
,'2021-11-30/2021-12-27'
)

oh2rech.w <- White(ohat2jav.xts[intervallumok[1]], Sy = 0.134, median = FALSE)
oh2.slope <- oh2rech.w$results[,1]
select <- !coredata(csapsel.xts[intervallumok[1]])
slope.xts <- oh2.slope[select]

##Lefuttatja, és összefűzi
for(intervallum in intervallumok[-1]){ 
    oh2rech.w <- White(ohat2jav.xts[intervallum], Sy = 0.134, median = FALSE)
    oh2.slope <- oh2rech.w$results[,1]
    select <- !coredata(csapsel.xts[intervallum])
    slope.xts <- c(slope.xts, oh2.slope[select])
}

plot(slope.xts[,1], type ="p")

slopeSummer.xts <- slope.xts['2022-05-01/2022-08-31']
slopeSummer.xts <- c(slopeSummer.xts, slope.xts['2023-05-01/2023-08-31'])
plot(slopeSummer.xts[,1], type ="p")

slopeSummer.xts[slopeSummer.xts[,1] < 0, 1]

write.zoo(slopeSummer.xts, "NyáriMeredekségAdatok.csv", sep = ";", dec = ",")

## Negítív törlése
slopeSummer.xts[slopeSummer.xts[,1] < 0, 1] <- NA


slopeonlyDate.xts <- xts(coredata(slopeSummer.xts[,1]), as.Date(index(slopeSummer.xts[,1])))
slopeDatnona2022 <- slopeonlyDate.xts['2022']
slopeDatnona2022 <- slopeDatnona2022[!is.na(slopeDatnona2022)]

plot(as.numeric(index(slopeDatnona2022)),
     coredata(slopeDatnona2022)[,1])
lines(lowess(as.numeric(index(slopeDatnona2022)),
             coredata(slopeDatnona2022)[,1],
             f = 1/4) # Simítás
      )

slopeDatnona2023 <- slopeonlyDate.xts['2023']
slopeDatnona2023 <- slopeDatnona2023[!is.na(slopeDatnona2023)]

plot(as.numeric(index(slopeDatnona2023)),
     coredata(slopeDatnona2023)[,1])
lines(lowess(as.numeric(index(slopeDatnona2023)),
             coredata(slopeDatnona2023)[,1],
             f = 3/4) # Simítás
      )

## 1-es kútra átírni!
## Teljes időszak: '2021-06-22 13:00:00/2023-08-31'
intervallum <- '2023-05-01/2023-06-23'
intervallum <- '2023-06-25/2023-08-31'
intervallum <- '2022-12-22/2023-03-01'
intervallum <- '2022-11-01/2022-12-20'
## 2022-05-01/2022-08-31
intervallum <- '2022-05-01/2022-06-24'
intervallum <- '2022-06-26/2022-08-31'
## '2021-11-01/2022-02-28' adathiányig
## intervallum <- '2021-11-01/2021-11-26' négy óránként
intervallum <- '2021-11-30/2021-12-27'

oh1rech.w <- White(ohat1.xts[intervallum], Sy = 0.134)
plot(oh1rech.w$ori.gw)
plot.White(oh1rech.w)
oh2.slope <- oh2rech.w$results[,1]
select <- !coredata(csapsel.xts[intervallum])[,1]
oh2.slope[select]
