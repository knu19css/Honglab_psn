#data_example
group_name <- c("CON1", "CON2", "CON3", "CON4",
                "RSL1", "RSL2", "RSL3", "RSL4",
                "OA1", "OA2", "OA3", "OA4",
                "Era1", "Era2", "Era4")
gene_name <- 1:100

mat <- matrix(runif(length(gene_name) * length(group_name), min = -2, max = 2),
              nrow = length(gene_name),
              ncol = length(group_name),
              dimnames = list(gene_name, group_name))

#Heatmap
library(gplots)

png("Heatmap.png", width = 2000, height = 2000, res = 300)
heatmap.2(mat[1:50,], trace = "none", scale = "none", density.info = "none",
          col = bluered(100), #color
          Colv = F, #Row clustering
          dendrogram = "none", #dendrogram
          cexRow = 0.8, #Row font size
          cexCol = 1, #Col font size
          ColSideColors = rep(c("green", "orange", "blue", "pink"), times = c(4, 4, 4, 3)), #color of the group
          key.par = list(mar=c(5, 3, 5, 3)), #Color Key size, bottom, left, top, right's margin
          key.title = "log2FC" #color key title
          )
dev.off()
