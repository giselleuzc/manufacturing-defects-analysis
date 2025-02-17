![Manufacturing Defects Image](manufacturing_image.png)
# manufacturing-defects-analysis
Analysis of manufacturing defects using R to explore defect types, trends, and costs. Aims to enhance quality control processes through detailed data visualization and trend analysis.


## Data Source

### Dataset Overview
The dataset for this project was sourced from [Kaggle](https://www.kaggle.com), a platform hosting a variety of community-contributed datasets. This particular dataset focuses on manufacturing defects observed during quality control processes.

### Details
- **Title**: Manufacturing Defects
- **Contributor**: Fahmida Chowdhury
- **Accessed**: [February 16, 2025]
- **Direct Link**: [Manufacturing Defects Dataset](https://www.kaggle.com/datasets/fahmidachowdhury/manufacturing-defects)

### Content
The dataset includes comprehensive details on various types of manufacturing defects such as defect type, detection date, product location, severity, inspection method used, and repair costs. These data points are crucial for analyzing defect patterns and improving quality control measures within manufacturing processes.

### Usage
This dataset is utilized in this project to analyze defect patterns, examine trends over time, and assess the effectiveness of different inspection methods. The insights derived are aimed at enhancing the quality control processes in manufacturing.

### License
For details on the dataset's usage rights and licensing, please refer to the [Kaggle dataset page](https://www.kaggle.com/datasets/fahmidachowdhury/manufacturing-defects).

## Data Cleaning
### Overview
This section outlines the procedures followed to clean and preprocess the dataset, ensuring the data is accurate, complete, and appropriate for analysis.

### Steps Involved

1. **Loading the Data**:
   - The raw data is loaded into R using the `read_csv()` function from the `readr` package, part of the `tidyverse`.

2. **Handling Missing Values**:
   - Missing values were checked and handled appropriately. Depending on their significance and the potential impact on analysis, missing values were either imputed or rows containing them were removed.

3. **Date Formatting**:
   - The `defect_date` column was converted from a string to a Date object to facilitate time-series analysis. This was accomplished using the `as.Date()` function, with the date format specified to match the dataset.

### Script Location
- The script for data cleaning can be found in the repository at: `scripts/01_data_cleaning.R`

### Additional Notes
- It is recommended to verify the processed data file to ensure all cleaning steps have been properly applied before proceeding to the analysis phase.
- Details on how to run the cleaning script and the required packages are documented within the script comments for ease of use.

## Manufacturing Defects Analysis
### Overview
Ok, let's go for the interesting part.
If you got here through my LinkedIn profile, you have noticed that I am a Production Engineer. So I took this project to show my analytical skills in a field related to my engineering: manufacturing and quality control.

This project will be focusing on (using R):
- **Defect frequency trends** over time.
- **Defect-location relationships** within the product.
- **Repair cost distributions** and anomaly detection.
- **Inspection method effectiveness** in detecting defects.
- **Severity vs. repair cost correlation** to find inefficiencies.

The analyses help identify **potential quality control issues** and **optimize repair cost allocation**.
**NOTE:** The script where all of these findings were obtained is [`02_EDA.R`](scripts/02_EDA.R)  

## 🚀 **Key Analyses & Findings**

### **1. Most Common Defects**
**Question:** What are the most frequent defect types?  
**Visualization:** Bar chart of defect counts.  
📂 **Script:** [`scripts/common_defects.R`](scripts/common_defects.R)  
📝 **Insight:** *[Summary of findings]*  

### 2️⃣ **Defect Trends Over Time**
📌 **Question:** How do defects vary over time (monthly)?  
📊 **Visualization:** **Facet-wrapped histograms** of defect counts.  
📂 **Script:** [`scripts/defect_trends.R`](scripts/defect_trends.R)  
📝 **Insight:** *[Summary of findings]*  

### 3️⃣ **Defect Types vs. Locations**
📌 **Question:** Are defect types correlated with specific locations?  
📊 **Visualization:** **Heatmap of defect types vs. locations**  
📂 **Script:** [`scripts/defect_vs_location.R`](scripts/defect_vs_location.R)  
📝 **Insight:** *[Chi-Square test results and interpretation]*  

### 4️⃣ **Repair Cost Analysis**
📌 **Question:** What are the typical repair costs for each defect type?  
📊 **Visualization:** **Boxplot & bar chart of repair costs**  
📂 **Script:** [`scripts/repair_costs.R`](scripts/repair_costs.R)  
📝 **Insight:** *[Summary of cost distributions, outliers, and inefficiencies]*  

### 5️⃣ **Effectiveness of Inspection Methods**
📌 **Question:** Which inspection methods detect defects most effectively?  
📊 **Visualization:** **Grouped bar chart comparing defect detection rates**  
📂 **Script:** [`scripts/inspection_methods.R`](scripts/inspection_methods.R)  
📝 **Insight:** *[Chi-square test result & efficiency analysis]*  

### 6️⃣ **Severity vs. Repair Cost Correlation**
📌 **Question:** Does defect severity correlate with repair costs?  
📊 **Visualization:** **Scatter plot with regression line**  
📂 **Script:** [`scripts/severity_vs_cost.R`](scripts/severity_vs_cost.R)  
📝 **Insight:** *[Correlation coefficient & interpretation]*  

### 7️⃣ **Anomalies & Outliers in Defect Costs**
📌 **Question:** Are there unusual patterns in defect severity or cost?  
📊 **Visualization:** **Boxplots of repair costs across products**  
📂 **Script:** [`scripts/anomaly_detection.R`](scripts/anomaly_detection.R)  
📝 **Insight:** *[Identified anomalies and recommendations for further investigation]*  

---

## 🛠 **Installation & Usage**
### 📌 **1️⃣ Install Dependencies**
Before running the scripts, install necessary R packages:  
```r
install.packages(c("ggplot2", "dplyr", "tidyr", "readr", "corrplot"))

