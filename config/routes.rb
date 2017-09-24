Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'

  namespace :api do
    # Session
    resource :session, only: [:create, :destroy]

    # User (Tested)
    get :user, to: 'users#show'
    post :registration, to: 'users#create', as: :registration

    # Boards
    get 'user/boards', to: 'boards#all'
    get 'board/:id', to: 'boards#show', as: :board
    post :board, to: 'boards#create'
    put 'board/:id', to: 'boards#update', as: :board_update

    # Columns
    get 'board/columns', to: 'columns#all'
    get 'column/:id', to: 'columns#show', as: :column
    post :column, to: 'column#create'
    put  'column/:id', to: 'column#update', as: :column_update

    # Tickets
    get 'column/tickets', to: 'tickets#all'
    get 'ticket/:id', to: 'tickets#show', as: :ticket
    post :ticket, to: 'ticket#create'
    put  'ticket/:id', to: 'ticket#update', as: :ticket_update

    # Checkpoints
    get 'ticket/checkpoints', to: 'checkpoints#all'
    get 'checkpoint/:id', to: 'checkpoints#show', as: :checkpoint
    post :checkpoint, to: 'checkpoint#create'
    put  'checkpoint/:id', to: 'checkpoint#update', as: :checkpoint_update

    # Comments
    get 'ticket/comments', to: 'comments#all'
    post :comment, to: 'comments#create'
  end
end
