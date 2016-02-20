# Create a term document matrix and a wordcloud

library(tm)
library(wordcloud)

text_data <- read_and_pp(file.path("~", "Code", "stack_ds_scrape"))

# Create term document matrix
tdmatrix <- TermDocumentMatrix(text_data)

freq_vector <- sort(rowSums(as.matrix(tdmatrix)), decreasing = TRUE)
text_frame <- data.frame(word = names(freq_vector), freq = freq_vector)

# Generate a word cloud
set.seed(999)

#wordcloud(words = text_frame$word, freq = text_frame$freq,
#          random.order = FALSE, rot.per = 0.35, max.words = 200,
#          scale = c(2, 0.25), colors = brewer.pal(8, "Dark2"))

# Re-read original text plainly (no corpus) for n-gram analysis
plain_text <- read_pt_and_pp(file.path("~", "Code", "stack_ds_scrape", "corpus", "qa_output.txt"))

# Generate a bigram matrix
bigram_matrix <- TermDocumentMatrix(Corpus(VectorSource(plain_text)), 
                                    control = list(tokenize = get_ngrams))
