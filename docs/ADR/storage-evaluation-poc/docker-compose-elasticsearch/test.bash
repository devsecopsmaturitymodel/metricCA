curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "action.auto_create_index": "my-index-000001,index10,-index1*,+ind*" 
  }
}
'
curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "action.auto_create_index": "false" 
  }
}
'
curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "action.auto_create_index": "true" 
  }
}
'

curl -X POST "localhost:9200/my-index-000001/_doc/?pretty" -H 'Content-Type: application/json' -d'
{
  "@timestamp": "2099-11-15T13:12:00",
  "message": "GET /search HTTP/1.1 200 1070000",
  "user": {
    "id": "kimchy"
  }
}
'

