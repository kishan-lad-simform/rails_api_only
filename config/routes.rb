Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json }  do
    namespace 'v1' do
      get "/search_comments/:comment", to: "comments#search_comment"
      get "/search/:title", to: "articles#search"
      resources :articles do
        get '/page/:page', to: "articles#pagination", on: :collection
        root to: "articles#index"
        resources :comments
      end
    end
  end
end
