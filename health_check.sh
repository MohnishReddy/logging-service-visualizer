#!/bin/bash

echo Health check started

HEALTH_CHECK_URL="http://127.0.0.1:9090"

response=$(curl -s -w "\n%{http_code}" $HEALTH_CHECK_URL)
http_code=$(tail -n1 <<< "$response")  # get the last line

while [ "$http_code" != "200" ]
do
    response=$(curl -s -w "\n%{http_code}" $HEALTH_CHECK_URL)
    http_code=$(tail -n1 <<< "$response")  # get the last line
    sleep 2
done

echo Health check completed