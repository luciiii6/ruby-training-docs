require './results/result'

class Success < Result
  def success?
    true
  end
end