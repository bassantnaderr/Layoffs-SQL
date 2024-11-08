# Data Analysis and Cleaning - Layoffs Dataset

This project involves cleaning and analyzing a layoffs dataset using **SQL** to extract insights on layoffs by company, industry, country, and other factors. The dataset was first cleaned by removing duplicates, handling null values, and standardizing certain fields. Afterward, exploratory data analysis (EDA) was performed to derive meaningful patterns from the data.

## Data Cleaning Process:

### 1. **Removing Duplicates**
### 2. **Standardizing Data**
   - Trimmed extra spaces from company and country names to ensure consistency.
   - Standardized the `industry` column to group similar values under common labels (e.g., "crypto" industries were consolidated into a single category).
   - Converted date formats to `DATE` type for consistency and easier analysis.
### 3. **Handling Null or Blank Values**
### 4. **Removing Unnecessary Columns**

##  Data Analysis:

### 1. **Exploratory Data Analysis (EDA)**
   - **Maximum and Minimum Layoffs:** Analyzed the highest and lowest number of layoffs across companies and industries.
   - **Total Laid Off by Company:** Aggregated total layoffs per company to identify the largest layoffs.
   - **Total Laid Off by Industry:** Grouped data by industry to understand which sectors were most affected.
   - **Total Laid Off by Country:** Examined layoffs by country to uncover geographical patterns.
   - **Yearly Layoffs:** Analyzed trends over time by grouping layoffs by year to identify any seasonal patterns or significant changes.
   - **Rolling Sum of Layoffs**
   - **Ranked Companies by Total Layoffs**
   - **Percentage of Total Laid Off**
   - **Funds Raised Analysis**


## Dataset Structure:

The dataset includes the following columns:

- **company** 
- **location** 
- **industry** 
- **total_laid_off** 
- **percentage_laid_off** 
- **date** 
- **stage**
- **country** 
- **funds_raised_millions** 

## Tools Used:

- **SQL** 


