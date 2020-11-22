module Policies::Representer
  class Index < Panicboat::Representer
    collection :Policies do
      property :id
      property :name
      property :description
      property :inline
      property :owner
      property :created_at
      property :updated_at
    end
  end
end
