class StaticPagesController < ApplicationController

def sub
   if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
   end
end

def home
end

def help
end

def about
end

def contact
end

end
