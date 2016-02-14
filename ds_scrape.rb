require 'rest-client'
require 'nokogiri'

# THIS SEEMS TO WORK SO FAR, BUT ISN'T GETTING COMMENTS! Use the questions/{id}/comments
# API method to get these!

data_science = Nokogiri::HTML(RestClient.get('http://stats.stackexchange.com/questions/195034'))

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
