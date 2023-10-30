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
select <- !coredata(csapsel.xts[intervallumok[1]])[,1]
slope.xts <- oh2.slope[select]

##Lefuttatja, és összefűzi
for(intervallum in intervallumok[-1]){ 
    oh2rech.w <- White(ohat2jav.xts[intervallum], Sy = 0.134, median = FALSE)
    oh2.slope <- oh2rech.w$results[,1]
    select <- !coredata(csapsel.xts[intervallum])[,1]
    slope.xts <- c(slope.xts, oh2.slope[select])
}

plot(slope.xts, type ="p")

slopeSummer.xts <- slope.xts['2022-05-01/2022-08-31']
slopeSummer.xts <- c(slopeSummer.xts, slope.xts['2023-05-01/2023-08-31'])
plot(slopeSummer.xts, type ="p")

slopeSummer.xts[slopeSummer.xts < 0]
