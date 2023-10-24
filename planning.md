# Planning

| Task                                                                                                                                  | Time (day) |
|---------------------------------------------------------------------------------------------------------------------------------------|------------|
| Integration of a java linter into the pipeline                                                                                        | 0.5        |
| Setup local development env.                                                                                                          | 0.5        |
| Create configuration.yaml for some planned activities                                                                                 | 0.5        |
| Deployment of sample activities and model description                                                                                 | 0.5        |
| Transfer meta model information to java objects (Analyzer)                                                                            | 3          |
| Check thresholds and add isImplemented=true/false (Analyzer)                                                                          | 0.5        |
| Export to prometheus push gateway                                                                                                     | 1          |
| Development of a build process (trigger build on push, push images with semantic versioning, semantic versioning?)                    | 1          |
| Preparation of Grafana Dashboards for different metrics (local grafana deployment -> fill test data -> click metric -> make template) | 4          |
| Create configuration.yaml for all planned activities                                                                                  | 1          |
| Implementation of Grafana Dashboards configuration into metricsCA (Analyzer Generate Dashboards)                                      | 2          |
| Figure out how to do PRs with (automated) schema validation in an enterprise organization                                             | 0.5        |
| Generate yaml schema for model objects for activities (Analyzer)                                                                      | 2          |
| Sort metrics in Dashboard (optional)                                                                                                  | 1          |
| Alarm send out for defined activities (optional)                                                                                      | 1          |
| Check yaml schema generation on configuration.yaml change in organization build pipeline                                              | 0.5        |
| Refinement of activities                                                                                                              | 0.5        |
| Integration of automated PRs for new patches into the pipeline                                                                        | 0.5        |
| Integration of test-coverage checks into the pipeline                                                                                 | 1          |
| Collector (from 3 APIs and MTTR/MTTP calculation, Pentest)                                                                            | 5          |
| Determine organizational teams and applications automated                                                                             | 2          |
| Deployment organizational activities                                                                                                  | 1          |
| Deployment MetricaCA                                                                                                                  | 3          |
| Deployment Collector                                                                                                                  | 1          |
| Deployment Grafana Stack                                                                                                              | 2          |

Remark: Some activities are to be performed by two developers, but it will not slow us down. We think that will come up to 3 days.
