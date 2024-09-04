# Load required libraries
library(dplyr)
library(ggplot2)
library(broom)

# Assuming 'dataset' is your Power BI dataset
df <- dataset

# Prepare the data
X <- df %>% select(Income, GenderDummy)
y <- df$Sales

# Fit the model without intercept
model <- lm(Sales ~ Income + GenderDummy + 0, data = df)

# Calculate confidence intervals
conf_int <- confint(model, level = 0.95)

# Prepare the summary data for Multiple Regression Summary
summary_data <- tidy(model) %>%
  mutate(
    stars = case_when(
      p.value <= 0.01 ~ "***",
      p.value <= 0.05 ~ "**",
      p.value <= 0.1 ~ "*",
      TRUE ~ ""
    ),
    lower_ci = conf_int[,1],
    upper_ci = conf_int[,2]
  ) %>%
  select(term, estimate, std.error, statistic, p.value, lower_ci, upper_ci)

# Add a row for the intercept (which is now 0)
summary_data <- rbind(
  data.frame(
    term = "Intercept",
    estimate = 0,
    std.error = NA,
    statistic = NA,
    p.value = NA,
    lower_ci = NA,
    upper_ci = NA
  ),
  summary_data
)

# Prepare regression statistics
n <- nrow(df)
k <- ncol(X)
df_total <- n - 1
df_residual <- n - k - 1
df_regression <- k

SST <- sum((y - mean(y))^2)
SSR <- sum((fitted(model) - mean(y))^2)
SSE <- sum(resid(model)^2)

R_squared <- summary(model)$r.squared
adjusted_R_squared <- summary(model)$adj.r.squared
multiple_R <- sqrt(R_squared)
std_error <- sqrt(SSE / df_residual)

reg_stats <- data.frame(
  Statistic = c("Multiple R", "R Square", "Adjusted R Square", "Standard Error", "Observations"),
  Value = c(multiple_R, R_squared, adjusted_R_squared, std_error, n)
)

# Calculate F-statistic and its p-value
F_statistic <- summary(model)$fstatistic[1]
F_p_value <- pf(F_statistic, df_regression, df_residual, lower.tail = FALSE)

# Prepare ANOVA table
anova_data <- data.frame(
  Source = c("Regression", "Residual", "Total"),
  df = c(df_regression, df_residual, df_total),
  SS = c(SSR, SSE, SST),
  MS = c(SSR/df_regression, SSE/df_residual, NA),
  F = c(F_statistic, NA, NA),
  `Significance F` = c(F_p_value, NA, NA)
)

# Create the plot
plot <- ggplot() +
  theme_void() +
  theme(plot.margin = margin(20, 20, 20, 20))

# Regression statistics table
plot <- plot +
  annotation_custom(
    tableGrob(reg_stats, rows = NULL, theme = ttheme_minimal(base_size = 10)),
    xmin = -1, xmax = 0, ymin = 0.7, ymax = 1
  ) +
  annotate("text", x = -0.5, y = 1.05, label = "Regression Statistics", fontface = "bold")

# ANOVA table
plot <- plot +
  annotation_custom(
    tableGrob(anova_data, rows = NULL, theme = ttheme_minimal(base_size = 10)),
    xmin = -1, xmax = 1, ymin = 0.3, ymax = 0.7
  ) +
  annotate("text", x = 0, y = 0.75, label = "ANOVA", fontface = "bold")

# Multiple Regression Summary table
plot <- plot +
  annotation_custom(
    tableGrob(summary_data, rows = NULL, theme = ttheme_minimal(base_size = 10)),
    xmin = -1, xmax = 1, ymin = -0.3, ymax = 0.3
  ) +
  annotate("text", x = 0, y = 0.35, label = "Multiple Regression Summary", fontface = "bold")

# Display the plot
print(plot)
