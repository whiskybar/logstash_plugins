require "logstash/outputs/tcp"
require "logstash/namespace"

class LogStash::Outputs::TcpCustom < LogStash::Outputs::Tcp

  config_name "tcp_custom"
  milestone 1

  config :mapping, :validate => :hash  
  
  public
  def receive(event)
    return unless output?(event)

    if @mapping
      evt = Hash.new
      @mapping.each do |k,v|
        evt[k] = event.sprintf(v)
      end
    else
      evt = event.to_hash
    end

    @codec.encode(evt)
  end
end
