module Minty
  module Utils
    extend self

    def dollars(value)
      left, right = value.to_f.to_s.split(".")
      cents = right.ljust(2, "0")
      "$ " << [left, cents].join(".")
    end
  end
end
