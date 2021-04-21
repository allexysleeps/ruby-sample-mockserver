Rails.application.routes.draw do
  post 'mockserver/mock', to: 'mockserver#create'
  match '*path', to: 'mockserver#resolve', via: :all
end
