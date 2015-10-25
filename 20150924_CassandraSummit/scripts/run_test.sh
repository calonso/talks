
if [ ! -d "opscenter-5.1.3" ]; then
  echo "Couldn't find opscenter-5.1.3 directory from current directory"
  exit -1
fi

ccm stop

kill -9 $(<"opscenter-5.1.3/agent/datastax-agent.pid")
kill -9 $(<"opscenter-5.1.3/agent2/datastax-agent.pid")
kill -9 $(<"opscenter-5.1.3/agent3/datastax-agent.pid")
kill -9 $(<"opscenter-5.1.3/twistd.pid")

ccm switch test
ccm start

opscenter-5.1.3/bin/opscenter
opscenter-5.1.3/agent/bin/datastax-agent
opscenter-5.1.3/agent2/bin/datastax-agent
opscenter-5.1.3/agent3/bin/datastax-agent
