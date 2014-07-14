# This file is used by Rack-based servers to start the application.

<<<<<<< HEAD
require ::File.expand_path('../config/environment',  __FILE__)
=======
require 'faye'
Faye::WebSocket.load_adapter('thin')
require File.expand_path('../config/environment', __FILE__)

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25



>>>>>>> f213513f799935cd92e2460be823efb2a44a9a19
run ClioInOutStub::Application
