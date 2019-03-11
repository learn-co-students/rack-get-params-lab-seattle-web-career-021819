class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}".join("\n")
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write check_cart
   elsif req.path.match(/add/)
     item = req.params["item"]
     resp.write add(item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def check_cart
    if @@cart.empty?
      return "Your cart is empty"
    else
      @@cart.map do |item|
       "#{item}"
     end.join("\n")
   end
end

 def add(item)
   if @@items.include?(item)
     @@cart << item
     return "added #{item}"
   else
     return "We don't have that item"
   end
 end

end
