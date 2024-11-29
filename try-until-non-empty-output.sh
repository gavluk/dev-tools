#!/bin/bash

try_until_non_empty_output() {
  local cmd=$1
  local count=$2
  local i=1
  local value=$(bash -c "$cmd")

  [[ DEBUG == 1 ]] && echo "VALUE=$value count=$count i=$i" 1>&2

  while [[ -z $value ]] && [[ $i -lt $count ]]; do
      [[ DEBUG == 1 ]] && echo "i=$i, value=$value, sleep 1 sec" 1>&2
      sleep 1
      value=$(bash -c "$cmd")
      ((i=i+1))
  done

  echo $value
}


x=$(try_until_non_empty_output "docker-compose exec utils curl -s http://jobmanager:8081/jobs/1dd2fd7445653ab4b5131939ab9f387a/accumulators | jq -r '.\"user-task-accumulators\"[] | select(.name==\"HERE_decoding_point_info_all\") | .value'" 5)
echo $x

#try_until_non_empty_output "docker-compose exec utils curl -s http://jobmanager:8081/jobs/1dd2fd7445653ab4b5131939ab9f387a/accumulators | jq -r .\"user-task-accumulators\"[] | select(.name==\"HERE_decoding_point_info_all\") | .value" 5

#try_until_non_empty_output 'echo -n ' 5

