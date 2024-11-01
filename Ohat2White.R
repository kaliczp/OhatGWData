oh2.w2 <- White(ohat2jav.xts['2023-05-01 23:50:00/2023-07-08'], Sy = 0.085)
oh2all.xts <- oh2.w2$results
oh2.w2 <- White(ohat2jav.xts['2023-07-08 23:50:00/2023-08-03'], Sy = 0.085)
oh2all.xts <- c(oh2all.xts, oh2.w2$results)
oh2.w2 <- White(ohat2jav.xts['2023-08-03 23:50:00/2023-08-08'], Sy = 0.085)
oh2all.xts <- c(oh2all.xts, oh2.w2$results)
oh2.w2 <- White(ohat2jav.xts['2023-08-08 23:50:00/2023-08-31'], Sy = 0.085)
oh2all.xts <- c(oh2all.xts, oh2.w2$results)
oh2.w2 <- White(ohat2jav.xts['2022-05-01 23:50:00/2022-06-30'], Sy = 0.085)
oh2all.xts <- c(oh2all.xts, oh2.w2$results)
oh2.w2 <- White(ohat2jav.xts['2024-06-21 23:50:00/2024-09-30'], Sy = 0.085)
oh2all.xts <- c(oh2all.xts, oh2.w2$results)

write.zoo(oh2all.xts, "GW_ET.csv", sep = ";", dec = ".")


plot.White(oh2.w2)
timeaxtics <- seq(starttime, endtime + 24*60*60, by = "day")

## Talán a plot van eggyel eltolva? csak a meredekség?

## eredmény tábla
oh2.w2$result
