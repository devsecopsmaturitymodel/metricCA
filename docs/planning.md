# Planning

| Task                                                                                                              | Time (day) | Person   | Status        |
|-------------------------------------------------------------------------------------------------------------------|------------|----------|-------------|
| Integration of a java linter into the pipeline                                                                    | 0.5        | T        | done         |
| Setup local development env.                                                                                      | 0.5        | R,T      | done |
| Create configuration.yaml for some planned activities                                                             | 0.5        | R,T      |          done   |
| Deployment of sample activities and model description                                                             | 0.5        | R,T      |         done    |
| Transfer meta model information to java objects (Analyzer)                                                        | 3          | R        |      done       |
| Check thresholds and add isImplemented=true/false for simple activities (Analyzer)                                                      | 0.5        | R        |        done      |
| ~~Check thresholds and add isImplemented=true/false for complex activities like security training (Analyzer)~~                                                      | 0.5        | R        |           |
| Provide data via API                                                                                                | 1          | T        | done |
| in progress (maybe a bug left)            |
| Development of a build process (trigger build on push, push images with semantic versioning, semantic versioning?) | 1          | T,(R)    | done         |
| Setup Grafana locally                                                                                    | 1.5        | T        | done         |
| Team Integration to show teams without activities as red                                                                                    | 1        | T        |      done    |
| Preparation of Grafana Dashboards for different metrics (fill test data -> click metric -> make template)         | 2.5        | T        | done |
| Create Overview-Dashboards         |        | T        | done |
| Create Team-Dashboards         |        | T        | done |
| Create Matrix-Dashboard         |        | T        |  done |
| Create skeleton.yaml for all planned activities                                                              | 1          | T,(R)    |         done    |
| Implementation of Grafana Dashboards configuration into metricsCA (Analyzer Generate Dashboards)                  | 2          | T        |        done     |
| ~~Figure out how to do PRs with (automated) schema validation in an enterprise organization~~                         | 0.5        | R,(Timo) |             |
| ~~Generate yaml schema for model objects for activities (Analyzer)~~                                                  | 2          | R        |             |
| Check yaml schema generation on skeleton.yaml change in organization build pipeline                          | 0.5        | T,(R)    |             |
| ~~Refinement of activities~~                                                                                          | 0.5        | R        |             |
| Integration of automated PRs for new patches into the pipeline                                                    | 0.5        | T        |             |
| Integration of test-coverage checks into the pipeline                                                             | 1          | T,(R)    |         done    |
| ~~Determine organizational teams and applications automated~~                                                         | 2          | R        |             |
| ~~Deployment organizational activities~~                                                                              | 1          | R,(T)    |             |
| ~~Deployment MetricCA~~                                                                                               | 3          | R,(T)    |     in progress        |
| Deployment Grafana Stack                                                                                          | 2          | T,(R)    |    in progress         |
| ~~Collector Confluence Deployment~~                                                                                   | 1          | R, (T)   | |
| Add more status with different colurs (e.g. gray/yellow)                                                         | 2          |  T  | |
| ~~Add HTTP-Collector~~                                                         | 2          |  R  | |


Remark: Some activities are to be performed by two developers, but it will not slow us down. We think that will come up to 3 days.



Backlog:
| Task                                                                                                                                  | Time (day) |Person|
|---------------------------------------------------------------------------------------------------------------------------------------|------------|---|
| Sort metrics in Dashboard (optional)                                                                                                  | 1          ||
| Alarm send out for defined activities (optional)                                                                                      | 1          ||
| Collector (from 3 APIs and MTTR/MTTP calculation, Pentest)                                                                            | 5          ||
| Deployment Collector                                                                                                                  | 1          |R,(T)|
| Use authenticated git repo                                                                                                                  | 1          ||



