require 'uri'
require 'net/http'
require 'json'

## url
uri = URI('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY')
res = Net::HTTP.get_response(uri)
puts res.body if res.is_a?(Net::HTTPSuccess)

## seperated params
uri = URI('https://api.nasa.gov/planetary/apod')
params = { :api_key => 'DEMO_KEY' }
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
puts res.body if res.is_a?(Net::HTTPSuccess)

## Post Request
uri = URI('https://jsonplaceholder.typicode.com/posts')
res = Net::HTTP.post_form(uri, 'title' => 'foo', 'body' => 'bar', 'userID' => 1)
puts res.body  if res.is_a?(Net::HTTPSuccess)


## Example from private project
## GET request
class PostcodeApiService
  def self.get_address(zipcode, house_number, house_number_addition)
    url = "https://api.postcode.eu/nl/v1/addresses/postcode/#{zipcode}/#{house_number}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(ENV['POSTCODE_API_KEY'], ENV['POSTCODE_API_SECRET'])
    response = http.request(request)

    JSON.parse response.body
  end
end

## POST request
class GoogleTranslateService
  def self.translate(text, source: 'nl', target: 'en')
    return 'This will be automatically translated' if !Rails.env.production?

    uri = URI.parse('https://www.googleapis.com/language/translate/v2')
    res = Net::HTTP.post_form(
      uri, source: source, target: target, q: text, format: 'text',
      key: ENV['GOOGLE_TRANSLATE_KEY']
    )

    body = JSON.parse res.body
    body['data']['translations'].first['translatedText']
  end
end

## terminal command
# ruby app/services/nethttp.rb

## resources
## https://rubyapi.org/3.2/o/net/http
## https://docs.ruby-lang.org/en/master/Net/HTTP.html
## https://www.twilio.com/blog/5-ways-make-http-requests-ruby
