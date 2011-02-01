Rubyday::Application.routes.draw do |map|
  root :to => "welcome#index"
  Jammit::Routes.draw(map)
end
