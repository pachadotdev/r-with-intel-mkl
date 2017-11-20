require(magrittr)

benchmark25_url = "http://r.research.att.com/benchmarks/R-benchmark-25.R"
benchmark25_script = paste0(benchmarks_location,"/1-r-benchmark-25.R")
if(!file.exists(benchmark25_script)) {try(download.file(benchmark25_url, benchmark25_script))}
benchmark25_script_correction = readLines(benchmark25_script) %>% 
  iconv(., from = "", to = "ASCII", sub = "") %>% 
  gsub("require\\(SuppDists\\)", "\\#require\\(SuppDists\\)", .) %>% 
  gsub("remove\\(\"a\", \"b\"\\)", "\\#remove\\(\"a\", \"b\"\\)", .)
writeLines(benchmark25_script_correction, benchmark25_script)

revoscript_url = "http://brettklamer.com/assets/files/statistical/faster-blas-in-r/revo-script.R"
revoscript_script = paste0(benchmarks_location,"/2-revo-script.R")
if(!file.exists(revoscript_script)) {try(download.file(revoscript_url, revoscript_script))}
revoscript_script_correction = readLines(revoscript_script) %>% 
  iconv(., from = "", to = "ASCII", sub = "") %>% 
  gsub("if\\(require\\(Revobase\\)\\)\\{", "\\#if\\(require\\(Revobase\\)\\)\\{", .) %>% 
  gsub("\\s+setMKLthreads\\(4\\)", "\\# setMKLthreads\\(4\\)", .) %>% 
  gsub("\\}", "\\#\\}", .)
writeLines(revoscript_script_correction, revoscript_script)
