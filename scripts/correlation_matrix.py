import pandas as pd
import matplotlib.pyplot as plt

# Assuming 'dataset' is your Power BI dataset
df = dataset

# Select the variables for correlation
variables = ['Age', 'Income', 'GenderDummy', 'Sales']
data_for_corr = df[variables]

# Calculate correlation matrix
corr_matrix = data_for_corr.corr().round(4)  # Round to 4 decimal places

# Create the figure
fig, ax = plt.subplots(figsize=(10, 3))

# Hide axes
ax.axis('off')

# Create table
table = ax.table(cellText=corr_matrix.values,
                 rowLabels=corr_matrix.index,
                 colLabels=corr_matrix.columns,
                 cellLoc='center',
                 loc='center')

# Customize the table
table.auto_set_font_size(False)
table.set_fontsize(12)
table.scale(1.1, 2.5)

# Add title
plt.title("Correlation Matrix", fontsize=16, pad=1)

# Adjust layout and display
plt.tight_layout()
plt.show()