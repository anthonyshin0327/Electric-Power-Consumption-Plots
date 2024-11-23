df = read.table('/Users/anthonyshin/Downloads/household_power_consumption.txt', sep = ';', header = TRUE)
View(df)

df = as_tibble(df)

df %>%
        filter(dmy(Date) == '2007-02-01' | dmy(Date) == '2007-02-02') %>%
        {. ->> df_2days}

# Plot 1

png(filename = 'plot1.png')

df_2days$Global_active_power = as.numeric(df_2days$Global_active_power)

par(mfrow=c(1,1))

with(df_2days,
     hist(Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = 'Frequency', main = 'Global Active Power', col = 'red')
     )

dev.off()
