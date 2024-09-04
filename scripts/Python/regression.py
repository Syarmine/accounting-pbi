import pandas as pd
import numpy as np
import statsmodels.api as sma
import matplotlib.pyplot as plt
from scipy import stats

# Assuming 'dataset' is your Power BI dataset
df = dataset

# Prepare the data
X = df[['Age', 'Income', 'GenderDummy']]
y = df['Sales']
X_with_const = sm.add_constant(X)

# Fit the model
model = sm.OLS(y, X_with_const).fit()

# Calculate confidence intervals
conf_int = model.conf_int(alpha=0.05)

# Prepare the summary data for Multiple Regression Summary
summary_data = []
for idx, name in enumerate(model.params.index):
    coef = model.params[idx]
    std_err = model.bse[idx]
    t_stat = model.tvalues[idx]
    p_val = model.pvalues[idx]
    lower_ci, upper_ci = conf_int.iloc[idx]
    stars = ''
    if p_val <= 0.01:
        stars = '***'
    elif p_val <= 0.05:
        stars = '**'
    elif p_val <= 0.1:
        stars = '*'
    summary_data.append([name, f"{coef:.5f}", f"{std_err:.5f}", f"{t_stat:.5f}", f"{p_val:.5f}", f"{lower_ci:.5f}", f"{upper_ci:.5f}"])

# Prepare regression statistics
n = len(y)
k = X.shape[1]  # number of predictors (excluding constant)
df_total = n - 1
df_residual = n - k - 1
df_regression = k

SST = np.sum((y - np.mean(y))**2)
SSR = np.sum((model.fittedvalues - np.mean(y))**2)
SSE = np.sum(model.resid**2)

R_squared = model.rsquared
adjusted_R_squared = model.rsquared_adj
multiple_R = np.sqrt(R_squared)
std_error = np.sqrt(SSE / df_residual)

reg_stats = [
    ["Multiple R", f"{multiple_R:.5f}"],
    ["R Square", f"{R_squared:.5f}"],
    ["Adjusted R Square", f"{adjusted_R_squared:.5f}"],
    ["Standard Error", f"{std_error:.5f}"],
    ["Observations", f"{n}"]
]

# Calculate F-statistic and its p-value
F_statistic = model.fvalue
F_p_value = model.f_pvalue

# Prepare ANOVA table
anova_data = [
    ["Regression", f"{df_regression}", f"{SSR:.5f}", f"{SSR/df_regression:.5f}", f"{F_statistic:.5f}", f"{F_p_value:.5f}"],
    ["Residual", f"{df_residual}", f"{SSE:.5f}", f"{SSE/df_residual:.5f}", "", ""],
    ["Total", f"{df_total}", f"{SST:.5f}", "", "", ""]
]

# Create the figure with three subplots
fig, (ax1, ax2, ax3) = plt.subplots(nrows=3, ncols=1, figsize=(12, 12), gridspec_kw={'height_ratios': [2, 1, 1.5]})

# Multiple Regression Summary table
ax1.axis('tight')
ax1.axis('off')
summary_table = ax1.table(cellText=summary_data,
                          colLabels=["Variable", "Coefficient", "Std. Error", "t-Statistic", "p-value", "Lower 95% CI", "Upper 95% CI"],
                          cellLoc='center', loc='center')
summary_table.auto_set_font_size(False)
summary_table.set_fontsize(10)
summary_table.scale(1.2, 1.2)
ax1.set_title("Multiple Regression Summary", fontsize=14, pad=5)

# Regression statistics table
ax2.axis('tight')
ax2.axis('off')
reg_stats_table = ax2.table(cellText=reg_stats,
                            colLabels=["Statistic", "Value"],
                            cellLoc='center', loc='center')
reg_stats_table.auto_set_font_size(False)
reg_stats_table.set_fontsize(10)
reg_stats_table.scale(1.2, 1.2)
ax2.set_title("Regression Statistics", fontsize=14, pad=5)

# ANOVA table
ax3.axis('tight')
ax3.axis('off')
anova_table = ax3.table(cellText=anova_data,
                        colLabels=["", "df", "SS", "MS", "F", "Significance F"],
                        cellLoc='center', loc='center')
anova_table.auto_set_font_size(False)
anova_table.set_fontsize(10)
anova_table.scale(1.2, 1.2)
ax3.set_title("ANOVA", fontsize=14, pad=5)

# Adjust layout and display
plt.tight_layout()
plt.show()