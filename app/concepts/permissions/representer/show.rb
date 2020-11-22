module Permissions::Representer
  class Show < Panicboat::Representer
    collection :Permissions do
      property    :effect
      collection  :prn
    end
  end
end
