require 'rest-client'
require 'nokogiri'
require 'json'

# THIS SEEMS TO WORK SO FAR, BUT ISN'T GETTING COMMENTS! Use the questions/{id}/comments
# API method to get these!

# UPDATE: I don't need to scrape at all! I should just be able to use the API straight up!
# Between the API and JSON gem, I should be able to easily get all the comments and answers.
# From there, I can use R to process the shit out of the gathered text!

API_BASE = 'https://api.stackexchange.com/2.2/'

data_science = Nokogiri::HTML(RestClient.get('http://stats.stackexchange.com/questions/195034'))
comments = RestClient.get(API_BASE + 'questions/195034/comments?site=stats')

# Extract the question and answer text and list text
qa_text = data_science.css('.post-text p')
list_text = data_science.css('.post-text ul li')

# Glue text together into a document (order is irrelevant)
big_text = ''

# Run for each set of text items, leaving a space between each one
qa_text.each do |item|
  big_text = big_text + item.text + "\n"
end

list_text.each do |item|
  big_text = big_text + item.text + "\n"
end

File.open('qa_output.txt', 'w') do |file|
  file.write(big_text)
end
