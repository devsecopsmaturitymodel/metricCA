#!/bin/bash

source .env
export URL="http://localhost:8086"

curl --request POST \
"http://localhost:8086/api/v2/write?org=${INFLUXDB_INIT_ORG}&bucket=${INFLUXDB_INIT_BUCKET}&precision=ns" \
  --header "Authorization: Token ${INFLUXDB_INIT_ADMIN_TOKEN}" \
  --header "Content-Type: text/plain; charset=utf-8" \
  --header "Accept: application/json" \
  --data-binary '
    airSensors,sensor_id=TLM0201 temperature=73.97038159354763,humidity=35.23103248356096,co=0.48445310567793615 1700040640141284933
    airSensors,sensor_id=TLM0201 temperature=73.97038159354763,humidity=35.23103248356096,co=0.48445310567793615 1700040640541284932
    airSensors,sensor_id=TLM0202 temperature=75.30007505999716,humidity=35.651929918691714,co=0.5141876544505826 1630424257000000000
'
