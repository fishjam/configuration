#!/bin/bash

#multi zookeeper on single machine demo
#usage: ./startHadoop.sh server-1 start
#debug: sh -vx ./startHadoop.sh server-1 print-cmd

basepath=$(cd `dirname $0`; pwd)

if [ "x$ZK_HOME" = "x" ] || ! [ -f "${ZK_HOME}/bin/zkServer.sh" ]
then
  echo "must define ZK_HOME" >&2
  exit 1
fi

ZK_SERVER_SH="${ZK_HOME}/bin/zkServer.sh"

if [ $# -eq 0 ]; then
  echo "must input service dir( server1 )" >&2
fi


if [ -d "${basepath}/$1" ]
then
  ZOO_LOG_DIR=${basepath}/$1/log; export ZOO_LOG_DIR
  ZOOCFGDIR="${basepath}/$1/conf"; export ZOOCFGDIR
  sed -i "s:dataDir=.*:dataDir=${basepath}/$1/data:g" "${ZOOCFGDIR}/zoo.cfg"
  shift
  ${ZK_SERVER_SH} ${@}
else
  echo "the server dir is not exist"
  exit 2
fi

exit 0

