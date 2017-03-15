module TweetsHelper

	def get_tagged(tweet)
		message_arr = tweet.message.split

		punctuation = %w(. , ? ! ; - : & *)
		temp_word = ""

    message_arr.each_with_index do |word, index|
      if word[0] == "#"
      	temp_word = word
      		if punctuation.include?(temp_word[-1])
      		temp_word = temp_word[0...-1]
      		end
        	if Tag.pluck(:phrase).include?(temp_word)
          	tag = Tag.find_by(phrase: temp_word)
        	else
          	tag = Tag.create(phrase: temp_word)
       	end  
       tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
       message_arr.delete(word)
       message_arr[index] = "<a href=' /tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    tweet.message = message_arr.join(" ")
    return tweet
  end
end
