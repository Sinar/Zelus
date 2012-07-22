get "/docs/:name" do
  haml params[:name].to_sym
end