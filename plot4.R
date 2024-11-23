# plot 4

# Read data 
df = read.table('/Users/anthonyshin/Downloads/household_power_consumption.txt', sep = ';', header = TRUE)
df = as_tibble(df) 

# tidy data
## Fix the date and time into days

