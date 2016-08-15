
## This is a test code for function "discretize.R"
setwd("/home/afrooz/Rcodes/ABIDE/RF/dim.red")

dump("add2", file="discretize.R")
source("discretize.R")

data <- matrix(data=cbind(rnorm(30, 0), rnorm(30, 2), rnorm(30, 5)), nrow=30, ncol=3)
data
summary(data)

discret_data <- apply(data, 2, function(x) discretize(x,4))
discret_data
summary(discret_data)
###my data
strt<-Sys.time()
#data.ifc.462<- read.table("/home/afrooz/Rcodes/ABIDE/RF/CRF2/CRF2/ABIDE_n462.txt",header=FALSE,sep=" ")
data.ifc.252<- read.table("/home/afrooz/Rcodes/ABIDE/RF/dim.red/ABIDE_data.txt",header=FALSE,sep=" ")

#data.clinic=read.csv("/home/afrooz/Rcodes/ABIDE/RF/CRF2/CRF2/DATA.csv")
label=data.ifc.252$V1
#data=cbind(label,data.ifc.462)
#print(Sys.time()-strt)

#strt<-Sys.time()
discret_data <- apply(data.ifc.252[,-1], 2, function(x) discretize(x,6))
#print(Sys.time()-strt)

final_data = data.frame(V1 = as.factor(data.ifc.252[,1]), discret_data)
write.csv(final_data,file="discrete.252.2per.csv", row.names=FALSE)
readBack = read.csv("discrete.252.2per.csv")
Sys.time() - strt
#Time diff was 3.45 min
