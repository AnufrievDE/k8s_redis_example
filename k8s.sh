#!/bin/sh
# overrides env variables, produces k8s.yaml kubernetes config file
case $1 in
    start)
        set -o allexport; . .env; set +o allexport
        j2 k8s-storage.yaml > k8s.yaml
        echo "\n---" >> k8s.yaml
        j2 k8s-redis.yaml >> k8s.yaml
        kubectl apply -f k8s.yaml
    ;;
    stop)
        kubectl delete -f k8s.yaml
    ;;
    *) echo "please provide argument 'start' or 'stop'"
esac