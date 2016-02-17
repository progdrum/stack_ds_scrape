# Create a term document matrix and a wordcloud

library(tm)
library(wordcloud)

text_data <- read_and_pp(file.path("~", "Code", "stack_ds_scrape"))

# Create term matrices
tdmatrix <- TermDocumentMatrix(text_data)
dtmatrix <- DocumentTermMatrix(text_data)

freq_vector <- sort(rowSums(as.matrix(tdmatrix)), decreasing = TRUE)
text_frame <- data.frame(word = names(freq_vector), freq = freq_vector)

# Generate a word cloud
set.seed(999)

wordcloud(words = text_frame$word, freq = text_frame$freq,
          random.order = FALSE, rot.per = 0.35, max.words = 200,
          scale = c(2, 0.25), colors = brewer.pal(8, "Dark2"))
