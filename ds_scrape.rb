require 'rest-client'
require 'nokogiri'
require 'json'

API_BASE = 'https://api.stackexchange.com/2.2/'

# Retrieve information from the API methods
question = RestClient.get(API_BASE + 'questions/195034?site=stats&filter=withbody')
comments = RestClient.get(API_BASE + 'questions/195034/comments?site=stats&filter=withbody')
answers = RestClient.get(API_BASE + 'questions/195034/answers?site=stats&filter=withbody')

# Parse the returned JSON
qjson = JSON.parse(question)
cjson = JSON.parse(comments)
ajson = JSON.parse(answers)

# Glue all the text together into a corpus, beginning with question text
big_text = Nokogiri::HTML(qjson['items'][0]['body']).text + "\n"

# Process the question comments
comments_list = cjson['items']

comments_list.each do |comment|
  big_text = big_text + ' ' + Nokogiri::HTML(comment['body']).text + "\n"
end

# Now process the answers and their comments
answers_list = ajson['items']

answers_list.each do |answer|
  big_text = big_text + ' ' + Nokogiri::HTML(answer['body']).text + "\n"

  # Retrieve the comments for each and process those as well
  answer_comments = RestClient.get(API_BASE + 'answers/' + answer['answer_id'].to_s +
                                   '/comments?site=stats&filter=withbody')

  aclistjson = JSON.parse(answer_comments)

  aclistjson['items'].each do |acomment|
    big_text = big_text + ' ' + Nokogiri::HTML(acomment['body']).text + "\n"
  end
end

File.open('qa_output.txt', 'w') do |file|
  file.write(big_text)
end
