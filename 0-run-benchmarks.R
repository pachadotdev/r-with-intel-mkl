r_option = 3 # 1 = R CRAN 3.4.2 (with Intel MKL)
             # 2 = R CRAN 3.4.2 (with openBLAS)
             # 3 = R CRAN 3.4.2 (defaults)

benchmarks_location = "00-benchmark-scripts"
try(dir.create(benchmarks_location))

source(paste0(benchmarks_location,"/0-download-scripts.R"))

if(r_option == 1) {
  results_location = "01-intel-mlk-results"
  try(dir.create(results_location))
}

if(r_option == 2) {
  results_location = "02-openblas-results"
  try(dir.create(results_location))
}

if(r_option == 3) {
  results_location = "03-defaults-results"
  try(dir.create(results_location))
}

#############################################################################

#install.packages("SuppDists")

log = paste0(results_location, "/results-benchmark25.log")
if(!file.exists(log)) {try(file.create(log))}
con = file(log, open = "wt")
sink(log)
sink(con, append = TRUE, type = "message")
  
  sessionInfo()
  source(benchmark25_script, echo = TRUE, max.deparse.length = 10000)

sink(type="message")
sink()

list = ls()[!(ls() %in% c(ls(pattern = "script"), ls(pattern = "location")))]
rm(list = list)
gc()

#############################################################################

log = paste0(results_location, "/results-revoscript.log")
if(!file.exists(log)) {try(file.create(log))} 
con = file(log, open = "wt")
sink(log)
sink(con, append = TRUE, type = "message")

  sessionInfo()
  source(revoscript_script, echo = TRUE, max.deparse.length = 10000)

sink(type="message")
sink()

list = ls()[!(ls() %in% c(ls(pattern = "script"), ls(pattern = "location")))]
rm(list = list)
gc()
