Debrecen1901_2022 <- read.csv2("Debrecen/r_o_Debrecen_19012022.csv", dec = ".")
Debrecen2023 <- read.csv2("Debrecen/HABP_1RD_20230101_20230831_64309.csv", dec = ".", skip = 5)

library(xts)

DebrecenCs.xts <- xts(as.numeric(Debrecen1901_2022[,2]),
                      seq.Date(as.Date("1901-01-01"), as.Date("2022-12-31"), "1 day"))

tail(Debrecen2023)
DebrecenCs.xts <- c(DebrecenCs.xts,
                    xts(as.numeric(Debrecen2023[,3]),
                        seq.Date(as.Date("2023-01-01"), as.Date("2023-08-31"), "1 day")
                        )
                    )
plot(DebrecenCs.xts)

## Monthly sum
DebrCsmonth.xts <- apply.monthly(DebrecenCs.xts, sum)
plot(DebrCsmonth.xts, type = "h", ylim = c(0, 250), col = "blue", lwd = 2, lend = 2)
## Yearly sum
DebrCsyear.xts <- apply.yearly(DebrecenCs.xts["/2022"], sum)
plot(DebrCsyear.xts, type = "h", ylim = c(0, 1000), col = "blue", lwd = 2, lend = 2)

## Weekly sum
DerCsweek.xts <- period.apply(DebrecenCs.xts['2020-08-30/2023-09-01'], endpoints(DebrecenCs.xts['2020-08-30/2023-09-01'], "weeks"), sum)

DebrYearliAve <- mean(DebrCsyear.xts)
DerbCscumsum <- cumsum(DebrCsyear.xts - DebrYearliAve)
plot(DerbCscumsum)

## Temperature
DebrTemp <- read.csv2("Debrecen/t_h_Debrecen_19012021.csv", dec = ".")
DebrTemp.xts <- xts(as.numeric(DebrTemp[,2]),
                    seq.Date(as.Date("1901-01-01"), as.Date("2021-12-31"), "1 day"))

DebrTempYear <- apply.yearly(DebrTemp.xts,mean)

DebrTempMean <- mean(DebrTempYear)
DerbTcumsum <- cumsum(DebrTempYear - DebrTempMean)
plot(DerbTcumsum)
