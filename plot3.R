# Plot 3

# Read data 
df = read.table('/Users/anthonyshin/Downloads/household_power_consumption.txt', sep = ';', header = TRUE)
View(df)

# Convert 'Date' and 'Time' into a proper datetime object
df <- df %>%
        mutate(
                DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
                Sub_metering_1 = as.numeric(Sub_metering_1),
                Sub_metering_2 = as.numeric(Sub_metering_2),
                Sub_metering_3 = as.numeric(Sub_metering_3)
        )

# Filter the data to the specific days (e.g., Thursday to Saturday)
df_filtered <- df %>%
        filter(DateTime >= as.POSIXct("2007-02-01") & DateTime <= as.POSIXct("2007-02-03"))


## save to png.

png(filename = 'plot3.png')

# Create the plot
ggplot(data = df_filtered) +
        geom_line(aes(x = DateTime, y = Sub_metering_1, color = "Sub_metering_1")) +
        geom_line(aes(x = DateTime, y = Sub_metering_2, color = "Sub_metering_2")) +
        geom_line(aes(x = DateTime, y = Sub_metering_3, color = "Sub_metering_3")) +
        scale_color_manual(values = c("black", "red", "blue")) +
        labs(
                x = NULL,
                y = "Energy sub metering",
                color = NULL,  # Removes the legend title
                title = "Energy Sub Metering Over Time"
        ) +
        theme_minimal() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day")

dev.off()