module MapGroupUsers::Representer
  class Show < Panicboat::Representer
    property  :id
    property  :group_id
    property  :user_id
    property  :created_at
    property  :updated_at
  end
end
