
if [ ! -d "opscenter-5.1.3" ]; then
  echo "Couldn't find opscenter-5.1.3 directory from current directory"
  exit -1
fi

if [ ! -d "statsd" ]; then
  echo "Couldn't find statsd directory from current directory"
  exit -1
fi

launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.cassandra.plist
launchctl stop homebrew.mxcl.cassandra

sudo ifconfig lo0 alias 127.0.0.2 up
sudo ifconfig lo0 alias 127.0.0.3 up

ccm switch test
ccm start

opscenter-5.1.3/bin/opscenter
opscenter-5.1.3/agent/bin/datastax-agent
opscenter-5.1.3/agent2/bin/datastax-agent
opscenter-5.1.3/agent3/bin/datastax-agent

sudo python /opt/graphite/bin/carbon-cache.py start
sudo python /opt/graphite/bin/run-graphite-devel-server.py /opt/graphite/ &
sudo node statsd/stats.js statsd/config.js &
