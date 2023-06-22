library(tidyverse)

##read in measured data
traits <- read.csv(paste(datpath, "traits-fall-spring-dat.csv", sep = "")) %>%
  select(-2) %>%
  filter(!is.na(date_harvest)) %>%
  unite(col="sample_id",c("code","rep"),sep="",remove = FALSE)

##read in roots and leaf area data and join across experiments
fa_la <- read.csv(paste(datpath, "fall-LA.csv", sep = ""))
fa_roots <- read.csv(paste(datpath, "fall-roots.csv", sep = ""))
fa_la_roots <- left_join(fa_la,fa_roots,by="sample_id") %>%
  select(-2,-4:-5)

sp_la <- read.csv(paste(datpath, "spring-LA.csv", sep = "")) %>%
  select(-3)
sp_roots <- read.csv(paste(datpath, "spring-roots.csv", sep = ""))
sp_la_roots <- left_join(sp_la,sp_roots,by="sample_id") %>%
  select(-3)

la_roots <- rbind(fa_la_roots,sp_la_roots)

##join measured data with roots and la data
traits_all <- left_join(traits,la_roots)

write.csv(traits_all,"fall-sp-traits-clean.csv")



