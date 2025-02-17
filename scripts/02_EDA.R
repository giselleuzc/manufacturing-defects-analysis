#Author: Giselle Uzcategui
# file name: 02_EDA.R
#Date: February 16, 2025

#loading libraries as needed
library(tidyverse)
library(lubridate)
library(corrplot)

# Load cleaned data
defects_data <- read_csv("data/cleaned/defects_data_cleaned.csv")

#Inspect the datqaset structure
glimpse(defects_data)




# Question 1: Summary of defect types
(defect_type_summary <- defects_data %>%
  count(defect_type, sort = TRUE))

# Plot defect types
ggplot(defect_type_summary, aes(x = reorder(defect_type, n), y = n, 
                                fill = defect_type)) +
  geom_col() +
  labs(title = "Frequency of Defect Types", x = "Defect Type", y = "Count")

# Save plot
ggsave("figures/defect_type_frequency.png")




# Question 2: Trends by defect type

# Trends by defect type over time using a histogram faceted plot

# Prepare the data: Group by month and defect type
monthly_trends <- defects_data %>%
  mutate(month = floor_date(as.Date(defect_date), unit = "month")) %>%  # Extract month
  group_by(month, defect_type) %>%
  summarise(total_defects = n(), .groups = "drop")  # Count total defects per month and type

# Plot: Monthly trends with defects grouped by defect type
ggplot(monthly_trends, aes(x = month, y = total_defects, fill = defect_type)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +  # Grouped bar plot
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +  # Format months
  scale_fill_brewer(palette = "Dark2") +  # Use a darker, distinct color palette
  labs(title = "Monthly Trends of Defects by Type",
       x = "Month",
       y = "Number of Defects",
       fill = "Defect Type") +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "top")

# Save plot
ggsave("figures/defect_distribution_histogram.png")




# Question 3: Correlation defects vs.defect locations

# Step 1: Contingency Table
location_defect_table <- table(defects_data$defect_location, defects_data$defect_type)
print(location_defect_table)

# Step 2: Chi-Square Test of Independence
chi_square_test <- chisq.test(location_defect_table)
print(chi_square_test)

# Step 3: Visualize the Relationship (Heatmap)
library(reshape2)

# Prepare data for heatmap
heatmap_data <- as.data.frame(as.table(location_defect_table))
colnames(heatmap_data) <- c("Defect_Location", "Defect_Type", "Count")

# Plot heatmap
ggplot(heatmap_data, aes(x = Defect_Type, y = Defect_Location, fill = Count)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(title = "Heatmap of Defect Types by Location",
       x = "Defect Type",
       y = "Defect Location",
       fill = "Frequency") +
  theme_minimal(base_size = 14)

# Save plot
ggsave("figures/heatmap_defect_types_vs_location.png")




# Question 4: 

# Step 1: Summarize repair costs by defect type
repair_cost_summary <- defects_data %>%
  group_by(defect_type) %>%
  summarise(
    mean_cost = mean(repair_cost, na.rm = TRUE),
    median_cost = median(repair_cost, na.rm = TRUE),
    min_cost = min(repair_cost, na.rm = TRUE),
    max_cost = max(repair_cost, na.rm = TRUE),
    sd_cost = sd(repair_cost, na.rm = TRUE),
    .groups = "drop"
  )

print(repair_cost_summary)

# Step 2: Visualize typical repair costs using a bar chart (mean repair costs)
ggplot(repair_cost_summary, aes(x = reorder(defect_type, -mean_cost), y = mean_cost)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  geom_text(aes(label = scales::dollar(mean_cost)), vjust = -0.5, size = 4) +
  labs(
    title = "Average Repair Cost by Defect Type",
    x = "Defect Type",
    y = "Mean Repair Cost"
  ) +
  theme_minimal(base_size = 14)

# Save plot
ggsave("figures/average_repair_cost.png")

# Step 3: Visualize repair cost distribution using boxplots
ggplot(defects_data, aes(x = defect_type, y = repair_cost, fill = defect_type)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red", outlier.shape = 16) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Distribution of Repair Costs by Defect Type",
    x = "Defect Type",
    y = "Repair Cost"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

# Save plot
ggsave("figures/repair_cost_distribution.png")




# Question 5: Effectiveness of inspection methods

# Step 1: Count defects detected by each inspection method
inspection_effectiveness <- defects_data %>%
  group_by(inspection_method, defect_type) %>%
  summarise(detected_count = n(), .groups = "drop")

print(inspection_effectiveness)

# Step 2: Create a grouped bar plot
ggplot(inspection_effectiveness, aes(x = defect_type, y = detected_count, fill = inspection_method)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +  # Grouped bars for comparison
  labs(
    title = "Effectiveness of Inspection Methods in Detecting Defects",
    x = "Defect Type",
    y = "Number of Defects Detected",
    fill = "Inspection Method"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save plot
ggsave("figures/inspection_efectiveness.png")

# Step 4: Perform Chi-Square Test (Optional)
table(defects_data$inspection_method, defects_data$defect_type)
chi_test <- chisq.test(inspection_table)
print(chi_test)





# Question 6: correlation between defects and increased repair costs

# Step 1: Check the structure of the dataset bc severity is categorical
str(defects_data)

# Step 2: Convert severity to numeric if it's a factor or character
severity_levels = c("Minor", "Moderate", "Critical") #ensure order is correct
if (!is.numeric(defects_data$severity)) {
  defects_data <- defects_data %>%
    mutate(severity = as.numeric(as.factor(severity, levels = severity_levels,
                                           ordered = TRUE)))  # Convert severity to numeric scale
}

# Step 3: Compute correlation between severity and repair cost
severity_cost_correlation <- cor(defects_data$severity, defects_data$repair_cost, use = "complete.obs")
print(paste("Correlation between defect severity and repair costs:", round(severity_cost_correlation, 2)))

# Step 4: Create scatter plot with regression line
ggplot(defects_data, aes(x = severity, y = repair_cost)) +
  geom_point(alpha = 0.6, color = "blue") +  # Scatter points
  geom_smooth(method = "lm", se = TRUE, color = "red") +  # Linear regression line
  labs(
    title = "Correlation Between Defect Severity and Repair Cost",
    x = "Severity Level",
    y = "Repair Cost"
  ) +
  theme_minimal(base_size = 14)

# Save plot

ggsave("figures/severity_vs_repaircost.png")




# Question 7: Anomalies & Patterns

# Step 2: Detect outliers using Interquartile Range (IQR)
(Q1 <- quantile(defects_data$repair_cost, 0.25, na.rm = TRUE))  # First quartile (25%)
(Q3 <- quantile(defects_data$repair_cost, 0.75, na.rm = TRUE))  # Third quartile (75%)
(IQR_value <- Q3 - Q1)  # Interquartile range

# Define threshold for outliers
lower_bound <- Q1 - 1.5 * IQR_value
upper_bound <- Q3 + 1.5 * IQR_value

# Filter outliers
anomalies <- defects_data %>%
  filter(repair_cost < lower_bound | repair_cost > upper_bound)

print(paste("Number of anomaly cases detected:", nrow(anomalies)))
print(anomalies)

# Step 3: Visualize severity vs. repair cost (Scatter plot with anomalies)
ggplot(defects_data, aes(x = as.numeric(severity), y = repair_cost)) +
  geom_jitter(alpha = 0.6, color = "blue") +  # Spread points slightly for visibility
  geom_smooth(method = "lm", se = TRUE, color = "red") +  # Regression trendline
  geom_point(data = anomalies, aes(x = as.numeric(severity), y = repair_cost), color = "red", size = 3) +  # Highlight anomalies
  scale_x_continuous(breaks = 1:3, labels = severity_levels) +  # Label severity levels correctly
  labs(
    title = "Defect Severity vs. Repair Cost (with Anomalies Highlighted)",
    x = "Severity Level",
    y = "Repair Cost"
  ) +
  theme_minimal(base_size = 14)

# Save plot
ggsave("figure/severity_vs_repair_cost_anomalies.png")

# Step 4: Show tye top 10 most defective products

# Select top 10 products with most defects
product_defect_counts <- defects_data %>%
  count(product_id) %>%
  arrange(desc(n))

top_products <- product_defect_counts$product_id[1:10]

# Filter dataset for these products only
top_defect_products <- defects_data %>%
  filter(product_id %in% top_products)

# Boxplot with distinct colors for each product_id
ggplot(top_defect_products, aes(x = factor(product_id), y = repair_cost, fill = factor(product_id))) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, alpha = 0.7) +
  scale_fill_brewer(palette = "Set3") +  # Use a colorblind-friendly Brewer palette
  labs(
    title = "Repair Cost Distribution for Top 10 Most Defective Products",
    x = "Product ID",
    y = "Repair Cost",
    fill = "Product ID"
  ) +
  theme_minimal(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels

# Save plot
ggsave("figures/top_10_colored_repair_cost_by_product.png")
