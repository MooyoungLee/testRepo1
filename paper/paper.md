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
