library(ggplot2)
library(ggalluvial)
library(tidyverse)

# 데이터

name <- c("Neu", "Eos", "Baso", "Macro", "NK")


A<- c(50, 20, 15, 5, 10)
B <- c(30, 5, 45, 10, 10)
A2 <- c(A-1, rep(0.5, 10))
B2 <- c(B-1, rep(0.5, 10))


gap <- c(name, paste0(name, "_tgap"), paste0(name, "_bgap"))

df <- data.frame(name = name, A = A, B = B)

df2 <- data.frame(name = gap, A = A2, B = B2)
df <- df %>%
  pivot_longer(cols = c(A, B),
               names_to = "group",
               values_to = "value")
df2 <- df2 %>%
  pivot_longer(cols = c(A, B),
               names_to = "group",
               values_to = "value")

cell_colors <- c(
  "Neu" = "#E64B35",
  "Eos" = "#4DBBD5",
  "Baso" = "#00A087",
  "Macro" = "#3C5488",
  "NK" = "#F39B7F",
  # gap은 흰색
  "Neu_tgap" = "white",
  "Eos_tgap" = "white",
  "Baso_tgap" = "white",
  "Macro_tgap" = "white",
  "NK_tgap" = "white",
  "Neu_bgap" = "white",
  "Eos_bgap" = "white",
  "Baso_bgap" = "white",
  "Macro_bgap" = "white",
  "NK_bgap" = "white"
)

df2$name <- factor(df2$name, levels = c("Neu_tgap", "Neu", "Neu_bgap",
                                       "Eos_tgap", "Eos", "Eos_bgap",
                                       "Baso_tgap", "Baso","Baso_bgap",
                                       "Macro_tgap", "Macro","Macro_bgap",
                                       "NK_tgap", "NK","NK_bgap"))
df$name <- factor(df$name, levels = c("Neu", "Eos", "Baso", "Macro", "NK"))
# Plot
ggplot(df2,
       aes(x = group, 
           y = value, 
           alluvium = name,
           stratum = group,
           fill = name)) +
  geom_alluvium(position = "identity",
                alpha = 0.7, 
                width = 0.3,
                na.rm = TRUE,
                curve_type = "sigmoid")+
  geom_stratum(data = df,
               mapping = aes(x = group, y = value, stratum = name, fill = name),
               width = 0.3, 
               alpha = 1,
               color = "white",
               size = 1,
               na.rm = TRUE) +
  geom_text(stat = "stratum", 
            aes(label = paste0(name, "\n", value)),
            size = 4,
            fontface = "bold",
            color = "black",
            na.rm = TRUE) +
  scale_fill_manual(values = cell_colors[1:5], na.translate = F) +
  scale_x_discrete(labels = c("Group A", "Group B")) +
  labs(title = "Cell Type Distribution Changes",
       x = NULL,
       y = "Cell Count") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )

