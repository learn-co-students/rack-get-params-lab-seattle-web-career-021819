class Application
  @@items = %w[Apples Carrots Pears]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path =~ /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path =~ /search/
      search_term = req.params['q']
      resp.write handle_search(search_term)
    elsif req.path =~ /cart/
      if !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write 'Your cart is empty'
      end

    elsif req.path =~ /add/
      item = req.params['item']
      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end
end
