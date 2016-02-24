require 'sinatra/base'
require 'json'
#require 'prometheus/client'

class PrometheusExample < Sinatra::Application

  helpers do
    def random_status
      status_list = [ 200, 404, 403, 401 ]
      status_weight = [ 20, 7, 3, 4 ]
      weight_sum = status_weight.reduce :+
      rand_num = rand(weight_sum)
      weight_sum = 0

      status_list.each_with_index do |status,i|
          weight_sum += status_weight[i];
           
          if rand_num <= weight_sum
               return status_list[i]
          end
      end 
    end
  end
  
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
    "Hello World"
  end
  
  get '/latency/*' do
    sleep rand(0.0..3.5)
    "Simulate random latency"
  end

   
  get '/jackpot/*' do
    status random_status 
    "Weighted-random status: #{random_status}"
  end

  post '/echo/*' do
    params_str = params.delete_if { |key, value| key.to_s.match(/splat|captures/) }
    JSON.pretty_generate(params_str)
  end

end
