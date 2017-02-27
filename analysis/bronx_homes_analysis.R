bx.clean <- read.csv("data/bronx_rollingsales_homes_clean.csv",header=TRUE)
summary(bx.clean)
plot(log10(bx.clean$gross.sqft),log10(bx.clean$sale.price.n))
bx.clean$price.per.sqft<- bx.clean$sale.price.n / bx.clean$gross.sqft

