# read all dataframes 

data1 <- read.csv('data/2022_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = dmy_hm(date_time)) %>% 
  distinct(date_time, .keep_all = TRUE)

data01 <- data1 %>% 
  select(-starts_with("de_"), -ends_with("_de")) 
save(data1, file = "data/data1.RData")

data2 <- read.csv('data/2021_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  distinct(date_time, .keep_all = TRUE)

data02 <- data2 %>%
  select(-starts_with("de_"),-ends_with("_de"))
save(data2, file = "data/data2.RData")

data3 <- read.csv('data/2020_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  distinct(date_time, .keep_all = TRUE)

data03 <- data3 %>% 
  select(-starts_with("de_"), -ends_with("_de"))
save(data3, file = "data/data3.RData")

data4 <- read.csv('data/2019_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  distinct(date_time, .keep_all = TRUE)

data04 <- data4 %>% 
  select(-starts_with("de_"), -ends_with("_de"))
save(data4, file = "data/data4.RData")

# combine them into a single data frame
data <- bind_rows(data01, data02, data03, data04)

# save data as an rdata file
save(data, file = "data/data.RData")