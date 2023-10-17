# Architectural Decision Dashboard

There are at least two different dashboards:

* As an information security manager, I want an overview of the different (sub)-dimensions of all teams and their history.
* As a team, I want an overview of the performance of my team and its history.

## DSOMM

DSOMM as a target application is great in case it is used to present the DevSecOps Framework model data.
In case another way of highlighting the DevSecOps Framework, e.g. confluence is used, it depends.

Advantages of having it in DSOMM:

* More community support
* SpiderWeb Diagram with heatmap given
* For DSOMM: Showing of not-used features

Tasks to use DSOMM completely (including Framework display):

* Adjust Levels: 1h
* Adjust Dimensions: 6h
* Adjust activity content: 16h
* Transfer activity content: 8h
* Write a MetricCA to DSOMM transformation: 8h

Tasks to use DSOMM partially:

* Adjust Levels: 1h
* Adjust Dimensions: 6h
* Partially transfer activity content: 4h
* Write a MetricCA to DSOMM transformation: 8h

Saved:

* Creation of a spiderweb diagram with heatmap: 16h
* Maintenance of frontend: 30h for next 3 years

## Grafana:

It is possible to use Grafana as a metrics viewer. The datasource would be XYZ

### Metrics not covered:

- Spider web
- Spider web with heatmap but "heatmap" alone.

Flow:
MetricCA statistic generation -> Push metrics to Prometheus -> Time Series Database -> Grafana

The tools stack needs to be maintained:

* Prometheus
* Time Series Database
* Grafana

It is possible to write own extensions for sending notifications/information from Grafana to other tools, e.g. to the vulnerability management tool DefectDojo.

DSOMM/separate application:

* Development of a metrics framework with "re-usable" metrics: 24h
* Transformation of data to metrics: 8h
* Development of a method to display history: 12h

Recommendation:

* WebComponent for separate application, but we would be able to integrate it into DSOMM
* Integreation in DSOMM

# ADR Plugin System

We need to have the architecture in a way that we can add easily other interfaces/tools like Jira, Confluence, ...
The Software Strategy Pattern could fit this purpose (see also [Strategy](https://refactoring.guru/design-patterns/strategy).

# ADR Extensibility/Plugins

In order to send out notifications to DefectDojo, the [defectdojo-client-java](https://github.com/secureCodeBox/defectdojo-client-java) is handy to use to communicate with DefectDojo.
Is it ok to load the library in the main project? Do we want a "plugin" which loads the library by itself.

## Generation of Grafana dashboards
To define thresholds within the YAMLs would be beneficial in order to lower the dependency to Grafana.

The following existing libraries could be found to generate dashboards:
https://github.com/bhattchaitanya/Grafana-Dashboard-Generator, Java, last update 7 years
https://github.com/appnexus/grafana-api-java-client, java, last update 5 years
https://github.com/uber/grafana-dash-gen#step-5-create-an-alert-and-add-it-to-the-graph, javascript, last update a month ago

### JSONNET
https://github.com/databricks/sjsonnet, java, month
https://github.com/grafana/grafonnet, jsonnet, last update days