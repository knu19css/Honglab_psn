data <- read.csv("JLB_overall.csv")

# Function to calculate z-scores for each column (gene)
calculate_z_scores <- function(df) {
  z_score_df <- df
  
  # Apply z-score calculation to each gene column
  for (gene in names(df)[-1]) {  # Skip the first column (Sample)
    mean_value <- mean(df[[gene]], na.rm = TRUE)
    std_dev <- sd(df[[gene]], na.rm = TRUE)
    
    if (std_dev == 0) {
      stop(paste("Standard deviation cannot be zero for", gene))
    }
    
    z_score_df[[gene]] <- (df[[gene]] - mean_value) / std_dev
  }
  
  return(z_score_df)
}

z_score_data <- calculate_z_scores(data)

print(z_score_data)

write.csv(z_score_data,"JLB_zscore_overall.csv")
