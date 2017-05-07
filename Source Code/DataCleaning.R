setwd("/Users/stevenjia93/Desktop/CU_Spring/DataVis/Project/Data")
load("yl_data.RData")

yl$pickup_date <- sub(" .*", "", yl$tpep_pickup_datetime)

# Only use one week data as an illustration
one_week <-  c("2016-04-04", "2016-04-05", "2016-04-06" ,
               "2016-04-07", "2016-04-08", "2016-04-09", "2016-04-10")
week <- filter(yl, pickup_date %in% one_week)

# Remove obs that have distance = 0;
df <- week
remove.rows <- which(df$trip_distance == 0)
df <- df[-remove.rows,]

# Generate new vars;
df$pickup_time <- sub(".* ", "", df$tpep_pickup_datetime)
df$dropoff_date <- sub(" .*", "", df$tpep_dropoff_datetime)
df$dropoff_time <- sub(".* ", "", df$tpep_dropoff_datetime)

# Calculate time duration between pickup time and dropoff time;
i <- strptime(df$tpep_dropoff_datetime, "%Y-%m-%d %H:%M:%S")
j <- strptime(df$tpep_pickup_datetime, "%Y-%m-%d %H:%M:%S")
df$duration <- as.numeric(i - j, units = "secs")

# Calculate the fare amount per minute;
df$pickup_hour <- sub(":.*", "", df$pickup_time)
df$fare_per_min <- df$fare_amount / df$duration * 60


# Further remove outliers that have extremely high fare per min;
non_outliers <- with(df, which(!fare_per_min %in% boxplot.stats(fare_per_min)$out))
df <- df[non_outliers,]
df$day <- weekdays(as.Date(df$pickup_date))

# data.table(df)
# write.csv(df, file = "df.csv")
saveRDS(df, file = "df.rds")

# Load Data
df <- readRDS("df.rds")
