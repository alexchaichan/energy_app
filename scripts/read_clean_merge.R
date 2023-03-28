# read all dataframes 

data1 <- read.csv('data/2022_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = dmy_hm(date_time)) %>% 
  select(-starts_with("de_"), -ends_with("_de")) %>% 
  distinct(date_time, .keep_all = TRUE)

data2 <- read.csv('data/2021_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  select(-starts_with("de_"), -ends_with("_de")) %>% 
  rename('hydro_pump' = pump) %>% 
  distinct(date_time, .keep_all = TRUE)

data3 <- read.csv('data/2020_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  select(-starts_with("de_"), -ends_with("_de")) %>% 
  rename('hydro_pump' = pump) %>% 
  distinct(date_time, .keep_all = TRUE)

data4 <- read.csv('data/2019_Agorameter.csv', fileEncoding = "Latin1") %>% 
  janitor::clean_names() %>% 
  mutate(date_time = mdy_hms(date_time)) %>% 
  select(-starts_with("de_"), -ends_with("_de")) %>% 
  rename('hydro_pump' = pump) %>% 
  distinct(date_time, .keep_all = TRUE)

# combine them into a single data frame
data <- bind_rows(data1, data2, data3, data4)

# save data as an rdata file
save(data, file = "data/data.RData")