# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise

# ex. library(tidyverse)
library(readr)
library(tidyr)
library(ggplot2)
# Load data here ----------------------
# Load each file with a meaningful variable name.
metadata <- read_csv("GSE60450_filtered_metadata.csv")

data <- read_csv("GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")



# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.

## Expression data
dim(metadata)
dim(data)

## Metadata


# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

expr <- data[, -c(1,2)]
expr$gene_symbol <- data$`gene_symbol`


expr_long <- pivot_longer(expr,
                          cols = -gene_symbol,
                          names_to = "sample",
                          values_to = "expression")

metadata$sample <- rownames(metadata)
combined_data <- left_join(expr_long, metadata, by = "sample")
combined_data$cell_type <- as.factor(combined_data$cell_type)
# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2



p<-ggplot(combined_data, aes(x = cell_type, y = expression)) +
  geom_boxplot(fill = "skyblue", color = "darkblue") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Gene Expression by Cell Type",
       x = "Cell Type",
       y = "Expression")
p

ggplot(mtcars, aes(x = factor(cyl), y= mpg))+ geom_boxplot()

## Save the plot
### Show code for saving the plot with ggsave() or a similar function
ggsave("D:/Final sem/job/gene_expression_boxplot.png",
       plot = p,
       width = 8,
       height = 6,
       dpi = 300)
