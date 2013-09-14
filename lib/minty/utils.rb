module Minty
  module Utils
    extend self

    def dollars(value)
      dollars, right = value.to_f.to_s.split(".")
      cents = right.ljust(2, "0")
      "$ #{dollars}.#{cents}"
    end
  end
end
