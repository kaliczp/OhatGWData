SoilColor <- "#92745B"
library(readxl)
Terr1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "A2:B249", col_names = FALSE))
GW1 <- as.data.frame(read_excel("GW_section_2025_KPnek.xlsx", range = "D1:N125"))
GW1 <- GW1[, -c(3:5,9)] # Remove repeated and empty cols

