# Read in and pre-process text data

library(tm)

# Takes the path to the text file(s) for processing
read_and_pp <- function(tpath) {
  text_data <- Corpus(DirSource(tpath))
  text_data <- tm_map(text_data, removePunctuation)
  text_data <- tm_map(text_data, tolower)
  text_data <- tm_map(text_data, removeNumbers)
  text_data <- tm_map(text_data, removeWords, stopwords("english"))
  text_data <- tm_map(text_data, removeWords, c("etc"))
  text_data <- tm_map(text_data, stemDocument)
  text_data <- tm_map(text_data, stripWhitespace)
  text_data <- tm_map(text_data, PlainTextDocument)
}
