#Author: Giselle Uzcategui
# file name: 01_data_cleaning.R
#Date: February 16, 2025


#Load necessary libraries
library(tidyverse)
library(lubridate)

#Load data
defects_data <- read_csv("data/raw/defects_data.csv")
defects_data

#Clean data
defects_data <- defects_data %>%
  mutate(defect_date = mdy(defect_date)) %>%  # Convert dates
  drop_na()  # Drop missing values if any

# Save cleaned data
write_csv(defects_data, "data/cleaned/defects_data_cleaned.csv")
