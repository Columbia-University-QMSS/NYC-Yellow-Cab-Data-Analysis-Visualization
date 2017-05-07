df <- readRDS("df.rds")
df_sp = df
coordinates(df_sp)<- ~ pickup_longitude + pickup_latitude 
nyc_nei <-readOGR("nyc_neighborhood/.", "NEIGHNYC")
df_sp@proj4string <- nyc_nei@proj4string
aa <- over(df_sp, nyc_nei)
aa <- aa[,4]
df <- cbind(aa, df)
names(df)[1] <- "neighborhood"

saveRDS(df, "final_data.rds")
