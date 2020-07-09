# edward_favourite_motifs.R
# quick and dirty script to select 3'UTRs from the Cheng et al dataset, that contain favourite motifs
library(tidyverse)
favourite_motifs <- c("ATATTC","UGUAHMNUA","HWNCAUUWY")

UTR_cheng <- read_rds("../data/Sun_mutation_UTRs.rds")
UTR_cheng_subtable <- UTR_cheng %>%
    select(geneName = genename, UTR3_length, UTR3_seq, tAI)

ref_motifs <- 
    read.csv("../data/ref_motif_counts_UTR3_cheng_fungidb.csv")

favourite_table_all3 <- 
    ref_motifs %>%
    select(geneName, ATATTC, UGUAHMNUA, HWNCAUUWY) %>%
    filter(ATATTC >= 1, UGUAHMNUA >= 1, HWNCAUUWY >= 1) %>%
    left_join( UTR_cheng_subtable ) %>%
    filter(UTR3_length < 300)

write.csv(favourite_table_all3,"../data/favourite_motifs_UTR3_all3_maxlength300.csv")

favourite_table_just2 <- 
    ref_motifs %>%
    select(geneName, ATATTC, UGUAHMNUA, HWNCAUUWY) %>%
    filter(ATATTC >= 1, HWNCAUUWY >= 2) %>%
    left_join( UTR_cheng_subtable ) %>%
    filter(UTR3_length < 300)

write.csv(favourite_table_just2,"../data/favourite_motifs_UTR3_2xHWNCAUUWY_maxlength300.csv")

favourite_table_just2_tAI <- 
    ref_motifs %>%
    select(geneName, ATATTC, UGUAHMNUA, HWNCAUUWY) %>%
    filter(ATATTC >= 1, HWNCAUUWY >= 2) %>%
    left_join( UTR_cheng_subtable ) %>%
    filter(UTR3_length < 300, tAI > 0.55)

write.csv(favourite_table_just2,"../data/favourite_motifs_UTR3_2xHWNCAUUWY_maxlength300_mintAI0p55.csv")
