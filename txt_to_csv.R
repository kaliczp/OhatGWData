setwd("C:/Users/Admin/Documents/TDK/TDK3/Egyek aszálymonitoring adatok/Relatív páratart")
filelist = list.files(pattern = ".txt")
for (i in 1:length(filelist)){
  input<-filelist[i]
  output<-paste0(input, ".csv")
  print(paste("Processing the file:", input))
  data = read.csv2(input, header = TRUE)   
  write.table(data, file=output, sep=";", col.names=TRUE, row.names=FALSE)
  
}
