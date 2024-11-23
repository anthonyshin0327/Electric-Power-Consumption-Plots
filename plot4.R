# plot 4

# Read data 
df = read.table('/Users/anthonyshin/Downloads/household_power_consumption.txt', sep = ';', header = TRUE)
df = as_tibble(df) 

# tidy data
## Fix the date and time into days

df <- df %>%
        mutate(
                DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
                Sub_metering_1 = as.numeric(Sub_metering_1),
                Sub_metering_2 = as.numeric(Sub_metering_2),
                Sub_metering_3 = as.numeric(Sub_metering_3),
                Global_active_power = as.numeric(Global_active_power),
                Voltage = as.numeric(Voltage),
                Global_reactive_power = as.numeric(Global_reactive_power)
        )

# Filter the data to the specific days (e.g., Thursday to Saturday)
df_filtered <- df %>%
        filter(DateTime >= as.POSIXct("2007-02-01") & DateTime <= as.POSIXct("2007-02-03"))

# Plot them

p1 = ggplot(data = df_filtered, aes(x = DateTime, y = Global_active_power)) +
        geom_line() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +
        theme_classic() +
        labs(
                x = NULL,
                y = 'Global Active Power'
        )

p2 = ggplot(
        data = df_filtered,
        aes(
                x = DateTime,
                y = as.numeric(Voltage)
        )
) +
        geom_line() + 
        theme_classic() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day") +
        labs(
                x = 'datetime',
                y = 'Voltage'
        )

p3 = ggplot(data = df_filtered) +
        geom_line(aes(x = DateTime, y = Sub_metering_1, color = "Sub_metering_1")) +
        geom_line(aes(x = DateTime, y = Sub_metering_2, color = "Sub_metering_2")) +
        geom_line(aes(x = DateTime, y = Sub_metering_3, color = "Sub_metering_3")) +
        scale_color_manual(values = c("black", "red", "blue")) +
        labs(
                x = NULL,
                y = "Energy sub metering",
                color = NULL,  # Removes the legend title
        ) +
        theme_classical() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day")

p4 = ggplot(df_filtered)+
        geom_line(
                aes(
                        x = DateTime,
                        y = Global_reactive_power
                )
        ) +
        labs(
                x = NULL, 
                y = 'Global_reactive_power'
        ) +
        theme_classic() +
        scale_x_datetime(date_labels = "%a", date_breaks = "1 day")

png(filename = 'plot4.png')
grid.arrange(p1, p2, p3, p4)
dev.off()
