library(readxl)
GW_daily <- as.data.frame(read_excel("adatok_abrakhoz_Peternek.xlsx", sheet = "GW_daily", skip = 1))
names(GW_daily) <- c("Date",
                     paste(rep(c("shall", "medi", "deep"),each=3),
                           c("reference","passive","active"),
                           sep = "_")
                     )
GW_daily$Date <- as.Date(GW_daily$Date)
