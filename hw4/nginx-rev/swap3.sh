#/bin/bash

#./swap3.sh activity2
#kill anything thats currently running
#add new to docker network
#run appropriate swap file


#kill whatever process is currently running (either activity or activity2)

docker ps -a  > /tmp/yy_xx$$
if grep --quiet "activity2" /tmp/yy_xx$$
    then
    echo "killing newer version- activity2"
    docker rm -f `docker ps -a | grep "activity2"  | sed -e 's: .*$::'`
elif grep --quiet "activity" /tmp/yy_xx$$
    then
    echo "killing older version- activity"
    docker rm -f `docker ps -a | grep "activity"  | sed -e 's: .*$::'`
fi



#add arg1 to the network, and run the appropriate swap file

if [ "$1" == "activity" ]; then
  echo "adding activity to docker network"
  docker run --name web1 -d -P --network=ecs189_default activity
  docker exec ecs189_proxy_1 /bin/bash /bin/swap1.sh
fi

if [ "$1" == "activity2" ]; then
  echo "adding activity2 to docker network"
  docker run --name web2 -d -P --network=ecs189_default activity2
  docker exec ecs189_proxy_1 /bin/bash /bin/swap2.sh
fi

echo "swapped and ready to go!"
