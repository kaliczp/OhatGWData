csapsel <- read.csv2("Egyek/csapössz.csv")
csapsel.xts <- xts(csapsel[,4], as.Date(csapsel[,1], format = "%Y.%m.%d"))

oh2rech.w <- White(ohat2jav.xts['2022-04-14 23:50:00/2023-08-31'], Sy = 0.134)

intervallum <- '2023-06-25/2023-08-31'
intervallum <- '2023-05-01/2023-06-23'
intervallum <- '2022-12-22/2023-03-01'
intervallum <- '2022-11-01/2022-12-20'
oh2rech.w <- White(ohat2jav.xts[intervallum], Sy = 0.134)
plot.White(oh2rech.w)
oh2.slope <- oh2rech.w$results[,1]
select <- !coredata(csapsel.xts[intervallum])[,1]
oh2.slope[select]
