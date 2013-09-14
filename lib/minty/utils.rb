module Minty
  module Utils
    extend self

    def dollars(value)
      int, point = value.to_f.to_s.split(".")
      point = point.ljust(2, "0")
      "$ " << [int, point].join(".")
    end
  end
end
