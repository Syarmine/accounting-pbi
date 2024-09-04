# Load required libraries
library(tidyverse)
library(ggplot2)
library(reshape2)

# Assuming 'dataset' is your Power BI dataset
df <- dataset

# Select the variables for correlation
variables <- c('Age', 'Income', 'GenderDummy', 'Sales')
data_for_corr <- df[, variables]

# Calculate correlation matrix
corr_matrix <- round(cor(data_for_corr), 4)  # Round to 4 decimal places

# Melt the correlation matrix for ggplot
melted_corr_matrix <- melt(corr_matrix)

# Create the plot
ggplot(data = melted_corr_matrix, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.4f", value)), vjust = 1) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        legend.justification = c(1, 0),
        legend.position = c(0.6, 0.7),
        legend.direction = "horizontal") +
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5)) +
  ggtitle("Correlation Matrix")

# Display the plot
print(last_plot())
