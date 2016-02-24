require 'sinatra/base'
#require 'prometheus/client'

class PrometheusExample < Sinatra::Application
  
  # returns a default registry
  #prometheus = Prometheus::Client.registry
  
  # create a new counter metric
  #http_requests = Prometheus::Client::Counter.new(:http_requests, 'A counter of HTTP requests made')
  # register the metric
  #prometheus.register(http_requests)
  
  # equivalent helper function
  #http_requests = prometheus.counter(:http_requests, 'A counter of HTTP requests made')
  
  # start using the counter
  #http_requests.increment
  
  get '/' do
    "hey there"
  end
  
  get '/rand/*' do
    sleep rand(0.0..3.5)
    "simulation of random latency"
  end
  
  
end
