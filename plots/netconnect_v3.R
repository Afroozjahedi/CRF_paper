# Updates in v3 - formatting for heatmaps, fixed differences in from and to

# Format CSV file columns as follows: Frequency, Network-from, Network-to
net=read.csv("/Users/artnasamran/Documents/Rfiles/CRF252_net8RFNorm.csv",sep = ",",header = T)
attach(net)
# Vector of unique networks from csv file
# Assumes that unique networks in network-from are identical to networks in network-to
# Note: this does not work if the number of unique networks in network-from is different than
# the unique networks in network-to.

# All possible networks
networks = c("Auditory", "Cerebellar", "CinguloOpercTC", "DefaultMode", "DorsalAttention",
             "FrontoParietalTC", "MemoryRetrieval", "Salience", "SMHand", "SMMouth",
             "Subcortical", "Uncertain", "VentralAttention", "Visual")
num_unique = length(networks)

M = matrix(0, num_unique, num_unique)

library(gdata)
# Vector of "Connected Networks" column
fac.from = net[,2]
fac.from = factor(fac.from, levels = networks)

# Vector of "Net-to" column
fac.to = net[,3]
fac.to = factor(fac.to, levels = networks)

# Create data frame 
#(map.from <- mapLevels(x=fac.from))
(map.from = mapLevels(x=networks))
(int.from <- as.integer(fac.from))
#(map.to=mapLevels((x=fac.to)))
(map.to = mapLevels((x=networks)))
(int.to = as.integer(fac.to))
net=data.frame(net,int.from,int.to)

# Fill dataframe with frequencies of connections
for (i in 1:length(int.from)){
  M[int.from[i],int.to[i]]=net[i, 1]
}
for (k in 1:nrow(M)){
  for (l in 1:k) {
    if (l ==k) {
      next     
    }
    M[k,l]=M[l,k]=M[k,l]+M[l,k]
  }
}

# write.csv(M,file = "M.csv")
library(gplots) # for heatmap.2()
library(lattice) # for levelplot
colnames(M)=sort(networks)
rownames(M)=sort(networks)

my_palette = colorRampPalette(c("light yellow", "orange", "red"))(n = 30)
# Heatmap with no dendrograms
print(levelplot(M, 
                col.regions=my_palette,
                scales = list(x = list(rot = 90)),
                xlab = "Networks",
                ylab = "Networks",
                # Change the title according to the data
                main = "Dimensional Reduction 9"))

# Euclidean, average
mclust <- hclust(dist(M, method = "euclidean"), method = "average")
#plot(mclust, labels=colnames(M))
#my_palette = colorRampPalette(c("light yellow", "orange", "red"))(n = 12)
heatmap.2(as.matrix(M),
          key = TRUE, 
          Rowv = as.dendrogram(mclust), 
          col = my_palette,
          Colv = as.dendrogram(mclust),
          cexRow = 1,
          cexCol = 1,
          margins = c(8,8),
          # Change the title according to the data
          main = "Dimensional Reduction 9",
          trace = "none")

# Euclidean, complete
mclust <- hclust(dist(M, method = "euclidean"), method = "complete")
plot(mclust, labels=colnames(M))
my_palette = colorRampPalette(c("light gray", "blue", "navy blue"))(n = 12)
heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(mclust), col=my_palette,
          Colv=as.dendrogram(mclust), trace="none")

# Pearson, average
#hr <- hclust(as.dist(1-cor(t(M), method="pearson")), method="average") # Clusters 
#plot(hr)

#hc <- hclust(as.dist(1-cor(M, method="pearson")), method="average")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=rev(heat.colors(10)),
#          Colv=as.dendrogram(hc), trace="none")

# Pearson, complete
#hr <- hclust(as.dist(1-cor(t(M), method="pearson")), method="complete") # Clusters 
#plot(hr)

#hc <- hclust(as.dist(1-cor(M, method="pearson")), method="complete")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=rev(heat.colors(10)),
#          Colv=as.dendrogram(hc), trace="none")

# Pearson, single
#hr <- hclust(as.dist(1-cor(t(M), method="pearson")), method="single") # Clusters 
#plot(hr)

#hc <- hclust(as.dist(1-cor(M, method="pearson")), method="single")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=rev(heat.colors(10)),
#          Colv=as.dendrogram(hc), trace="none")

# Spearman, average
#hr <- hclust ( as.dist(1-cor(t(M), method="spearman")), method="average") 
#hc <- hclust (as.dist(1-cor(M, method="spearman")), method="average" )
#plot(hc)

#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=colorRampPalette(c("white", "red")),
#          Colv=as.dendrogram(hc), trace="none")

# Spearman, complete
#hr <- hclust(as.dist(1-cor(t(M), method="spearman")), method="complete" ) # Clusters 
#plot(hr)

#hc <- hclust(as.dist(1-cor(M, method="spearman")), method="complete")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=colorRampPalette(c("light gray", "blue")),
#          Colv=as.dendrogram(hc), trace="none")

# Kendall, average
#hr <- hclust(as.dist(1-cor(t(M), method="kendall")), method="average" ) # Clusters 
#plot(hr)
#hc <- hclust(as.dist(1-cor(M, method="kendall")), method="average")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=colorRampPalette(c("beige", "darkgreen")),
#          Colv=as.dendrogram(hc), trace="none")

# Kendall, complete
#hr <- hclust(as.dist(1-cor(t(M), method="kendall")), method="complete" ) # Clusters 
#plot(hr)
#hc <- hclust(as.dist(1-cor(M, method="kendall")), method="complete")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=rev(heat.colors(10)),
#          Colv=as.dendrogram(hc), trace="none")

# Kendall, single
#hr <- hclust(as.dist(1-cor(t(M), method="kendall")), method="single" ) # Clusters 
#plot(hr)
#hc <- hclust(as.dist(1-cor(M, method="kendall")), method="single")
#heatmap.2(as.matrix(M),key=TRUE, Rowv=as.dendrogram(hr), col=rev(heat.colors(10)),
#          Colv=as.dendrogram(hc), trace="none")


library(pvclust)
library(parallel)
cl <- makeCluster(2, type = "PSOCK")
## parallel version of pvclust

pv<-parPvclust(cl, M, method.hclust="average",
           method.dist="euclidean",
           nboot=1000)
pv <- parPvclust(cl, scale(t(M)) , nboot=10)
plot(pv) 
plot(mclust)
#print(pv)
ask.bak <- par()$ask
par(ask=TRUE)
## highlight clusters with high au p-values
pvrect(pv)

stopCluster(cl)

- names(net.code)[match(Net.from, net.code)]
