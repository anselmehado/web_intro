require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'tp_test.html.erb')

server.mount('/tp_indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'tp_indicate.rb')
server.mount('/tp_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'tp_goya.rb')


server.mount('/tp1_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'tp1_goya.rb')
server.start
