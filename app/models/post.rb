class Post < ActiveRecord::Base

   validates :title, presence: true
   validates :content, length: { minimum: 250 } 
   validates :summary, length: { maximum: 250 }
   validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
   validate :clickbait?

   # the below custom validator method is based off the code written by @changemewtf: 
   # https://github.com/learn-co-students/activerecord-validations-lab-v-000/blob/solution/app/models/post.rb
   CLICKBAIT = [
      /Won't Believe/i,
      /Secret/i,
      /Top [0-9]*/i,
      /Guess/i
    ]
  
    def clickbait?
      if CLICKBAIT.none? { |phrase| phrase.match title }
        errors.add(:title, "title is not clickbait-y enough")
      end
    end

end 

# All posts have a title
# Post content is at least 250 characters long
# Post summary is a maximum of 250 characters
# Post category is either Fiction or Non-Fiction. This step requires an inclusion validates. 
# Post is invalid if not clickbait.
# If the title does not contain "Won't Believe", "Secret", "Top [number]", or "Guess", the validator should add a validation.