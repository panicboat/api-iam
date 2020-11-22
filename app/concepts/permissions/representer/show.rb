module Permissions::Representer
  class Show < Abstract::Representer
    collection :Permissions do
      property    :effect
      collection  :prn
    end
  end
end
