library(readxl)
csapsel <- as.data.frame(read_excel("Egyek/csapössz.xlsx", 1))
csapsel.xts <- xts(csapsel[,4], csapsel[,1])

oh2rech.w <- White(ohat2jav.xts['2022-04-14 23:50:00/2023-08-31'], Sy = 0.134)

oh2rech.w <- White(ohat2jav.xts['2023-08-01/2023-08-31'], Sy = 0.134)
plot.White(oh2rech.w)
oh2.slope <- oh2rech.w$results[,1]
