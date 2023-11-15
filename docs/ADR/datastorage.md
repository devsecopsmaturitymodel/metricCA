# ADR Data Storage
The date of an activity doesn't correlate to the date of scrapping (in our case population of data). Scrapping might happen days later, because the PR is merged later.

The Grafana data source should be listed in https://grafana.com/docs/grafana/latest/alerting/fundamentals/data-source-alerting/ to be able to perform alerting.

## Prometheus
### Node Exporter with textfile collector
Doesn't support timestamps according to https://github.com/prometheus/node_exporter#textfile-collector

### Backfilling
Backfilling with the command `promtool tsdb create-blocks-from openmetrics` supports timestamps (seconds).

Disadvantage:
- Prometheus' libraries might not be able to be used due to change of format with an additional UNIX timestamp

Advantage:
- Supports timestamps

#### Usage
After running promtool, prometheus needs to be restarted in order to read the generated _write ahead logs_ files.

##### TODO
Change `command` to first read configMap and then start prometheus.

## RDBMS (PostgresSQL/MySQL/MariaDB)

Disadvantage:
- SQL Statements needs to be written or generated to query the database
- Will lead to a lot of tables with joining

Advantage:
- Supports timestamps
- ORM supported for easy writing
- Query language widely known 

URL: https://blog.devgenius.io/how-to-setup-grafana-with-postgresql-database-using-docker-compose-a-step-by-step-guide-e5a9cce90ba3

## MongoDB
Is a payed enterprise plugin: https://grafana.com/docs/plugins/

Disadvantage:
- No alerting mentioned on https://grafana.com/docs/grafana/latest/alerting/fundamentals/data-source-alerting/, but https://grafana.com/grafana/plugins/grafana-mongodb-datasource/ states that alerting is possible
- Might be difficult to perform comparisons

Advantage:
- Easy to store unstructured data (we do not know the structure beforehand)
- Supports timestamps

## ElasticSearch
OSS EOL -> Not considered

Disadvantages
- EOF WARNING: Support for Elasticsearch versions after their end-of-life (currently versions < 7.16) was removed. Using unsupported version of Elasticsearch may lead to unexpected and incorrect results. Data source successfully connected.

Advantages:
- Unstructured data possible
- Alerting support

URL: https://www.metricfire.com/blog/using-grafana-with-elasticsearch-tutorial/

## influxDB

Disadvantages
- Maintained by one company
- Query language unknown to current developers and likely for future developers

Advantages:
- Unstructured data possible
- Alerting support
- Java library exists https://docs.influxdata.com/influxdb/v2/api-guide/client-libraries/

https://github.com/influxdata/influxdb2-sample-data/tree/master/bird-migration-data

## Conclusion
In order to store unstructured data, influxDB is used besides the mentioned disadvantages.