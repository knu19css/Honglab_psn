library(Hmisc) #Correlation
library(ggplot2)
library(ggcorrplot)
library(reshape2)
library(cowplot)

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

#Correlation
result <- rcorr(mat, type = "pearson")

#plot
melted <- melt(result$r)

ggplot(data = melted, aes(x=Var1, y=Var2, fill = value)) +
  geom_tile()+
  scale_fill_gradient(low = "yellow", high = "red",
                      limit = c(-1, 1), space = "Lab", name = "Correlation") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
        panel.grid = element_blank()) +
  labs(caption = paste0("total: ", ncol(mat), " var"))
  coord_fixed()



