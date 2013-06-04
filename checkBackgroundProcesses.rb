processes = `ps aux | grep createTime.pl`
createTimeRunning = false
createTimeRunning = true if processes.match(/perl/)
if createTimeRunning == false
  system("/usr/bin/perl /blazeds/tomcat/webapps/alive5/Alive6_HiRes/createTime.pl &")
end

processes = `ps aux | grep gpc_server.rb`
createTimeRunning = false
createTimeRunning = true if processes.match(/ruby/)
if createTimeRunning == false
  system("/bin/rm /tmp5/em-websocket/examples/nohup.out")
  system("/usr/bin/nohup /usr/bin/ruby /tmp5/em-websocket/examples/gpc_server.rb > /dev/null &")
end
