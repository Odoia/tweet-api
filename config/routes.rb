Rails.application.routes.draw do
  post 'api/v1/tweet' => 'api/v1/tweet#create'
end
