# Paper

### Data sourcing and clean-up

The source data file (link) contains data on property sold during a twelve-month period in New York City's Bronx borough for all tax classes, including the neighborhood, building type, square footage and more.

The data file was obtained on February 27, 2017 from New York City Dept. of Finance [website](http://www1.nyc.gov/site/finance/taxes/property-rolling-sales-data.page).

The following procedures were carried out to clean the data:

1. Flagging of non-numerics in sale price variable
2. Change date from factor to date
3. Lower casing of all variable names for consistency
4. Eliminating lead digits for the gross.sqft and year.built variables
5. Removal of observations which did not appear to be real sales
6. Removal of outliers (log(sale.price) > 5)

### Analysis

The log (base 10) of the sales price was compared to the log (base 10) of the square footage.
![SFH ](https://github.com/Xibalba1/testRepo1/blob/master/analysis/logsalepriceVlogsqft.png)


## Fitting Linear Model

Following procedures were carried out to find the most influential variable to the home price per square feet value.
*(Extra data clean-up)
  1. Divided "sale.price" vector with "gross.sqft".
  2. Removed NA rows using -which(is.na()) .
  3. Removed one max outlier by -which.max() function.
*(Linear Fit Model, y~x1+x2+x3+x4)
  4. Where x1, x2, x3, x4 are ‘year.built’, ‘land.sqft’, ‘block’, ‘lot’ accordingly.
  5. Linear model coefficients are found by lm() and summary() functions.
  6. ‘Land.sqft’ and ‘block’ were the most significant inputs with the ‘sale price / gross sqft’
  7. Selected influential variables are checked with correlation function, cor().
  8. Linear fit model is compared with actual ‘sale price / gross sqft’ values in a plot
![SFH ](https://github.com/MooyoungLee/testRepo1/blob/master/analysis/BronxPricePerSqft.png)
