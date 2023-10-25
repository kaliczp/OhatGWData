library(readxl)
csapsel <- as.data.frame(read_excel("Egyek/csapössz.xlsx", 1))

oh2rech.w <- White(ohat2jav.xts['2022-04-14 23:50:00/2023-08-31'], Sy = 0.134)
oh2rech.w <- White(ohat2jav.xts['2023-08-08 23:50:00/2023-08-15'], Sy = 0.134)

plot.White(oh2.w)
head(oh2rech.w$results)
