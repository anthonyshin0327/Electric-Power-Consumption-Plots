# Plot 2

# Read data 
df = read.table('/Users/anthonyshin/Downloads/household_power_consumption.txt', sep = ';', header = TRUE)
View(df)

#Tidy data
df <- df %>%
        mutate(
                DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
                Global_active_power = as.numeric(Global_active_power)
        )

# Filter the data to the specific days (e.g., Thursday to Saturday)
df_filtered <- df %>%
        filter(DateTime >= as.POSIXct("2007-02-01") & DateTime <= as.POSIXct("2007-02-03"))

# Create the plot

png(filename = 'plot2.png')

ggplot(data = df_filtered, aes(x = DateTime, y = Global_active_power)) +
        geom_line() +
        labs(
                x = NULL,
                y = "Global Active Power (kilowatts)",
                title = "Global Active Power Over Time"
        ) +
        theme_minimal() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day")

dev.off()
