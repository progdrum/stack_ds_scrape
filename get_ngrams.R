# Use Rweka get n-grams
# Based on http://rstudio-pubs-static.s3.amazonaws.com/39014_76f8487a8fb84ed7849e96846847c295.html

library(tm)
library(RWeka)

# Set some defaults for now
ngram_min = 2
ngram_max = 2

# Genericized to get a range of n-gram sizes, if desired
get_ngrams <- function(text) {
  NGramTokenizer(text, Weka_control(min = ngram_min, max = ngram_max))
}
