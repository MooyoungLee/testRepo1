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

(Extra data clean-up)
  1. Divided "sale.price" vector with "gross.sqft".
  2. Removed NA rows using -which(is.na()) .
  3. Removed one max outlier by -which.max() function.

(Linear Fit Model, y~x1+x2+x3+x4)
  4. Where x1, x2, x3, x4 are ‘year.built’, ‘land.sqft’, ‘block’, ‘lot’ accordingly.
  5. Linear model coefficients are found by lm() and summary() functions.
  6. ‘Land.sqft’ and ‘block’ were the most significant inputs with the ‘sale price / gross sqft’
  7. Selected influential variables are checked with correlation function, cor().
  8. Linear fit model is compared with actual ‘sale price / gross sqft’ values in a plot
![SFH ](https://github.com/MooyoungLee/testRepo1/blob/master/analysis/BronxPricePerSqft.png)

Linear Regression Code

```{r}
## Mooyoung 2017/2/27 
# Investigation for the most influential factor to the price/sqft
bk.homes$PricePerSqft = bk.homes$sale.price.n/bk.homes$gross.sqft    # sale price per sqft calculation

bk.homes = bk.homes[-which(is.na(bk.homes$PricePerSqft)),]           # omit NA rows
bk.homes = bk.homes[-which.max(bk.homes$PricePerSqft),]              # delete an outlier
hist(bk.homes$PricePerSqft)                                          # check distribution
summary(bk.homes$PricePerSqft)                                       # check summary stat
plot(bk.homes$PricePerSqft,bk.homes$PricePerSqft)                    # check distribution w/o an outlier

## Linear Model

# assigning only numerical column variables into simple variables for regressino analysis
y = bk.homes$PricePerSqft
x1 = bk.homes$year.built
x2 = bk.homes$land.sqft
x3 = bk.homes$block
x4 = bk.homes$lot

fit = lm(y~x1+x2+x3+x4, data = bk.homes)   # Linear fit model function
summary(fit) # show results of fit model: x2 and x3 are the significant variables

# checking the correlation coefficients
cor(x1, y) 
cor(x2, y)
cor(x3, y)
cor(x4, y)

CorrCoef = cor(x2*0.04216+x3*0.02657-.10092, y)  # Correlation coefficients with model found

# Plot Actual 'Price/Sqft' vs. 'Prediction Model with only significant variables'

yAct = sort(y)                                                  # sort the 'PricePerSqft' values to compare
yfit = sort(x2*0.04216+x3*0.02657-.10092)                       # sorting fit model outputs
plot(c(1:length(yAct)), yAct, type = "l", col = "red",
     main = "Linear Regression Fit", 
     xlab = "Sample Number (Sorted)", ylab = "Price/Sqft")      # plot yAct line
lines(c(1:length(yAct)), xfit, col = "green")                   # Overlaying yFit line
legend(0,1500, c("Price/Sqft", "Model = Land.Sqft + Block"), 
       lty = c(1,1), lwd = c(2.5,2.5), col = c("red","green"))  # adding legend
text(500, 800, labels = paste("Corr.Coef = ", toString(round(CorrCoef,2))))     # Adding CorrCoef text
```
