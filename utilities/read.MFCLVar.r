read.MFCLVar <- function (varfile) 
{
  txt <- readLines(varfile)
  ffmsy <- scan(text = grep("F/Fmsy", txt, value = TRUE), 
                n = 3, quiet = TRUE)[3]
  ffmsy.se <- scan(text = grep("F/Fmsy", txt, value = TRUE), 
                   n = 3, quiet = TRUE)[2]
  pattern <- "adult_rbio(recent) - average_adult_rbio_noeff"
  log.sbsbfo <- scan(text = grep(pattern, txt, fixed = TRUE, 
                                 value = TRUE), n = 3, quiet = TRUE)[3]
  log.sbsbfo.se <- scan(text = grep(pattern, txt, fixed = TRUE, 
                                    value = TRUE), n = 3, quiet = TRUE)[2]
  sbsbfo <- exp(log.sbsbfo)
  sbsbmsy <- scan(text = grep("SB/SBmsy", txt, value = TRUE), 
                  n = 3, quiet = TRUE)[3]
  sbsbmsy.se <- scan(text = grep("SB/SBmsy", txt, value = TRUE), 
                     n = 3, quiet = TRUE)[2]
  out <- c(ffmsy = ffmsy, ffmsy.se = ffmsy.se, log.sbsbfo = log.sbsbfo, 
           log.sbsbfo.se = log.sbsbfo.se, sbsbfo = sbsbfo, sbsbmsy = sbsbmsy, 
           sbsbmsy.se = sbsbmsy.se)
  out
}