# This file is used by Rack-based servers to start the application.


require 'faye'
Faye::WebSocket.load_adapter('thin')
require File.expand_path('../config/environment', __FILE__)

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25


run ClioInOutStub::Application
