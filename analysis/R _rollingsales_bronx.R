# Author: Benjamin Reddy
# Taken from pages 49-50 of O'Neil and Schutt

#require(gdata)
#require(plyr) #Added by Monnie McGee
#install the gdata and plyr packages and load in to R.
library(plyr)
library(gdata)
setwd("/Users/iankinskey/Google_Drive/Education/Data_Science/DS@SMU/Courses/Doing_Data_Science_6306/Unit_6/")



# So, save the file as a csv and use read.csv instead
bx <- read.csv("rollingsales_bronx.csv",skip=4,header=TRUE)

## Check the data
head(bx)
summary(bx)
str(bx) # Very handy function!
help(str)
## clean/format the data with regular expressions
## More on these later. For now, know that the
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# We create a new variable that is a "clean' version of sale.price.
# And sale.price.n is numeric, not a factor.
bx$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", bx$SALE.PRICE))
count(is.na(bx$SALE.PRICE.N))

names(bx) <- tolower(names(bx)) # make all variable names lower case
## Get rid of leading digits
bx$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", bx$gross.square.feet))
bx$land.sqft <- as.numeric(gsub("[^[:digit:]]","", bx$land.square.feet))
bx$year.built <- as.numeric(as.character(bx$year.built))

## do a bit of exploration to make sure there's not anything
## weird going on with sale prices
attach(bx)
hist(sale.price.n) 
# detach(bx)

## keep only the actual sales
bx.sale <- bx[bx$sale.price.n!=0,]
plot(bx.sale$gross.sqft,bx.sale$sale.price.n)
plot(log10(bx.sale$gross.sqft),log10(bx.sale$sale.price.n))

## for now, let's look at 1-, 2-, and 3-family homes
bx.homes <- bx.sale[which(grepl("FAMILY",bx.sale$building.class.category)),]
dim(bx.homes)
plot(log10(bx.homes$gross.sqft),log10(bx.homes$sale.price.n))
summary(bx.homes[which(bx.homes$sale.price.n<100000),])


## remove outliers that seem like they weren't actual sales
bx.homes$outliers <- (log10(bx.homes$sale.price.n) <=5) + 0
bk.homes <- bx.homes[which(bx.homes$outliers==0),]
plot(log10(bx.homes$gross.sqft),log10(bx.homes$sale.price.n))