Rails.application.routes.draw do
  post 'registration' => 'answer#answer', :format => false
  post 'quiz' => 'quiz#quiz'
  root 'welcome#index'
  get 'base' => 'base#base'
end
