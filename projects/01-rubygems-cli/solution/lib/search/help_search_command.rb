class HelpSearchCommand
  def result
    'Introduce exactly the name of the gem without spaces: 
    ./cli.rb search <query>
    
    Options: --most-downloads-first
             --license <license_name>'
  end
end
