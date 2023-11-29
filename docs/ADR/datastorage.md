# ADR Data Storage
The date of an activity doesn't correlate to the date of scrapping (in our case population of data). Scrapping might happen days later, because the PR is merged later.

The Grafana data source should be listed in https://grafana.com/docs/grafana/latest/alerting/fundamentals/data-source-alerting/ to be able to perform alerting.

## Prometheus
Prometheus wants to be a monitoring solution. The documentation and issues highlite often, that the time of scrapping is important for prometheus. Therefore, prometheus team doesn't want that timestamps are provided.

### Node Exporter with textfile collector
Doesn't support timestamps according to https://github.com/prometheus/node_exporter#textfile-collector

### Backfilling
Backfilling with the command `promtool tsdb create-blocks-from openmetrics` supports timestamps (seconds).

Disadvantage:
- Prometheus' libraries might not be able to be used due to change of format with an additional UNIX timestamp
- Process with WAL doesn't look convinced
- A sample entrypoint in the database is shown over a long period of time (~1 min). This means, there is more knowledge needed to configure the time series database

Advantage:
- Supports timestamps

#### Usage
After running promtool, prometheus needs to be restarted in order to read the generated _write ahead logs_ files.

##### TODO in case of usage
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

## OpenTSDB
License model for running in the cloud unhandy.

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
- Cloud offerings high lited a lot
- Query language unknown to current developers and likely for future developers
- Due to commercial influxDB version 3, the end of support for version 2 (MIT) might come soon

Advantages:
- Unstructured data possible
- Alerting support
- Java library exists https://docs.influxdata.com/influxdb/v2/api-guide/client-libraries/

https://github.com/influxdata/influxdb2-sample-data/tree/master/bird-migration-data

## API
Plugins like the [infinity datastore plugin](https://github.com/grafana/grafana-infinity-datasource) offer to directly ask an API instead of a database. With frameworks like spring boot, it is easy possible to offer an API.
The "database" is stored in YAMLs. This might mean, that the collector should to store data also in YAMLs (no final descision so far).

Advantages:
- No DB needed
- Easy to setup

Disadvantages:
- Less documentation
- Open service port

## Conclusion
We use the API plugin instead of a separate database.
