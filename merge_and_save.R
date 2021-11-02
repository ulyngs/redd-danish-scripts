library(tidyverse)
library(writexl)

# grab participant id & email from the consent survey
consent <- read_csv("redd_dk_consent.csv") %>% 
  select(participant_identifier, signature, email, start_time = created, end_time = ended)

# grab participant id & workshop time from the workshop time survey
workshop_time <- read_csv("redd_dk_workshop_time.csv") %>% 
  filter(!is.na(participant_identifier)) %>%   # drop those without participant id
  select(participant_identifier, workshop_time = workshop_times_start, workshop_time_other = workshop_times_start_text)

# join the data frames
joined_data <- workshop_time %>% 
  left_join(consent)

# save it out as an excel file
write_xlsx(joined_data, "joined_data.xlsx")
