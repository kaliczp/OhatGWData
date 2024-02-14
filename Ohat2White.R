oh2.w <- White(ohat2jav.xts['2023-08-03 23:50:00/2023-08-08'], Sy = 0.134)
oh2.w <- White(ohat2jav.xts['2023-08-08 23:50:00/2023-08-31'], Sy = 0.134)

plot.White(oh2.w)
timeaxtics <- seq(starttime, endtime + 24*60*60, by = "day")

## Talán a plot van eggyel eltolva? csak a meredekség?

## eredmény tábla
oh2.w$result
