require './results/result'

class Failure < Result
  def success?
    false
  end
end