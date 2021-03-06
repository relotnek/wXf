require 'wXf/wXfui'
module WXf
module WXfmod_Factory

 
class Mod_Factory

  include WXf::WXflog::ModuleLogger
  include WXf::WXfui::Console::ShellIO::Medium
  
  attr_accessor :options, :name, :version, :license, :framework
  attr_accessor :description, :references, :author, :datahash, :pay # Do not change pay to payload BUG
       
  def initialize(hash_info = {})
    store_vals(hash_info)
  end
  
  def store_vals(hash_info)
   self.options = OptsPlace.new
   self.datahash = ModDataHash.new(self)
   self.name = hash_info['Name'] 
   self.version = hash_info['Version'] 
   self.description = hash_info['Description'] 
   self.references = hash_info['References'] 
   self.author = hash_info['Author'] 
   self.license = hash_info['License']
   self.pay = hash_info['Payload'] || false  
  end
   
  
  #
  # This is where we first add some options specified
  # ...in the module.
  #
  def init_opts(opts)
   self.options.add_opts(opts)
   self.datahash.validate_store_items(self.options)    
  end
  
  
  #
  # We created the options, we should have the
  # ...power to take them away when necessary
  #
  def delete_opts(opts)
    self.options.delete_option(opts)
  end
  
  #
  # This method essentially
  #
  def convert_params(param)
    parry = []
    unless param.kind_of?(String)
      return prnt_err("Error, please provide convert_params a string value")
    end   
    begin 
      param_to_arry = param.split('&')
        param_to_arry.reverse.each do |pair|
          pair_arry = pair.split('=')
          parry.push(["#{pair_arry[0]}", "#{pair_arry[1]}"])
        end
    rescue
      prnt_err("Error during convert_params conversion, check input")   
    end
    return parry
  end
  
end

end end
