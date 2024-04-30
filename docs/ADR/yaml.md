# Architectural Decision YAML structure

As a Product Owner, I easily want to find the entries I need to change.

## DSOMM

In an enterprise, hundreds of teams will be listed which makes it hard to find the own time and update the YAML as a product owner.

## YAML Folder structure

To have the team name in the folder name has the following advantages:

- Easy to manage

To have the team name in the folder name has the following disadvantages:

- Folder name should only be [a-zA-z0-9_\-]

As an alternative, config.yaml/metadata.yaml can be used to define the team names within the corresponding folder.

### YAML structure (Full Flexible)

Team folders on the first level allow the product owner to easily find relevant entries.

In this structure, the Product Owner will need guidance on how to add new YAMLs to the team-based folder or new files need to be added automatically.

We use the categories Team-based and Application-based. For example the activity _Nominate a security champion_ is often team-based. While the activity _Branch protection is enabled_ is application-based.

The YAMLs describe the requirements. The maturity model state based on the status of each activity is analyzed by the application.

#### Skeleton Definition
Skeletons are used to define the structure of the metrics, specially the components, thresholds and display in grafana. The concrete activity are defined in java classes.
Sample:
```yaml
apiVersion: v1
kind: skeleton

activity definitions:

  conduction of simple threat modeling on a technical level:
    components:
      - string: title
        dateperiod-5y: conduction date
        links:
          - string: title
          - string: url
    level: Level 1
  regular conduction of simple threat modeling on a technical level:
    components:
      - string: title
        dateperiod-2y: conduction date
        links:
          - string: title
          - string: url
    level: Level 2
  source control protection:
    level: Level 1
    components:
      - string: url # TODO create type url
```

Application-based sample `team-rebels/application-deathStar.yaml`:

Up to this point, we support to the maximum level of two nesting in the YAML file. Consequently, creating an array three times within it is currently not feasible. However, we envision implementing full recursion in the future to enhance flexibility and enable more advanced structuring beyond the current limitations.

```YAML
apiVersion: v1
kind: application
application settings:
  desired level: Basic understanding of security practices # one team can have multiple applications in different levels
  application id: 1234 # e.g. from deployment
  name: Death Star

includes:
  - path/to/an/other/activity-definition # base is `metricCA.application.path`
  - path/to/an/other-other/activity-definition # base is `metricCA.application.path`

activities:
  # Plan
  conduction of simple threat modeling on a technical level:
    - title: Feature Y
      date: 2023-10-01
      links: # Maybe some teams would like the option for multiple links, e.g. to a used threat library
        - title: Documentation of new Feature Y
          url: https://link-for-example-in-confluencex
    - title: Feature X
      date: 2023-11-01
      links: # Maybe some teams would like the option for multiple links, e.g. to a used threat library
        - title: Documentation of new Feature X
          url: https://link-for-example-in-confluence
  #      finding handling: do we want finding handling confirmation?
  #        security_team_confirmation:
  #          - confirmed by: Max Mustermann
  #            confirmed date: 2023-10-09

  data privacy requirements:
    - read date: 2022-09-02
    - read date: 2023-09-01
  security requirements:
    - read date: 2022-09-02
    - read date: 2023-09-01
  # Code
  source control protection:
    - url: example.com/repo/service-1 # Link to application repository URL
    - url: example.com/repo/service-1 # Link to application repository URL
    # branch protection is checked on PR; Later automatically via collector

  # One application might have multiple images
  reduction of the attack surface: # check on merge that the image is distroless or an organization specific image
    - confirmed by: Max Mustermann # optional
      confirmation date: 2023-09-10 # optional, might need re-assessment after two years

  security code review:
    - confirmed by: Max Mustermann # optional
      confirmation date: 2023-09-10 # optional, might need re-assessment after two years    

  # Build
  defined build process:
    - url: https://github.com/org/repo/.github/workflows # access checked on PR
    - url: https://github.com/org/repo/.github/workflows # access checked on PR

  # Test
  #mttr: hard to determine/continuously update manually
  usage of a vulnerability management system:
    - confirmed by: Max Mustermann # optional
      confirmation date: 2023-09-10 # optional, might need re-assessment after two years

  test for stored secrets:
    - confirmed by: Max Mustermann # optional
      confirmation date: 2023-09-10 # optional, might need re-assessment after two years  

  #  continuous penetration tests: # usage of collector

  # wouldn't mix tests TODO remove
  iast: # e.g. contrast security
    security_team_confirmation:
      - confirmed by: Max Mustermann
        confirmed date: 2023-10-09

  sast: # e.g. findsecuritybugs, checkmarx 
    security_team_confirmation:
      - confirmed by: Max Mustermann
        confirmed date: 2023-10-09

  # release and deployment

  # maybe url to artifacts?
  archiving of artifacts:
    po_confirmation:
      - confirmed by: Max Mustermann
        confirmed date: 2023-10-09

  environment depending configuration parameters (secrets):
    secret handling url: https://github.com/org/repo/deployment/sealed-secret.yaml
```
#### Summary
Advantages:
- Flexible to adapt to new requirements of organizations

Disadvantages:
- Hard to deserialize yamls into objects

### Activity YAML Structure and Classes
As an alternative to have a flexible non-typed YAML structure, we can define the structure of the YAMLs in classes.
#### Skeleton Definition
Skeletons are used to define the structure of the metrics, specially the thresholds and display in grafana. The concrete activity are defined in java classes.
```YAML
apiVersion: v1
kind: skeleton

activity definitions:
  - class name: "UrlActivity" # class defines attributes
    activity names:
      - "source control protection"
      - "build and deployment"
    grafana panel type: "count"
    thresholds:
      - level: "Level 1"
        type: "activity"
        targets:
          - type: "count"
            "min value": 1
        period:
          period type: sliding
          timeframe: "2Y"
      - level: "Level 2"
        type: "activity"
        targets:
          - type: "count"
            "min value": 1
        period:
          period type: sliding
          timeframe: "1Y"
  - class name: "UrlActivity"
    activity names:
      - "security requirements"
    grafana panel type: "count"
    thresholds:
      - level: "Level 1"
        type: "activity"
        targets:
          - type: "count"
            "min value": 1
        period:
          period type: sliding
          timeframe: "1Y"

  - class name: "DateTitleAndLinkActivity"
    activity names:
      - "conduction of simple threat modeling on a technical level"
    grafana panel type: "timeseries-flatdate"
    thresholds:
      - level: "Level 1"
        period:
          period type: sliding
          timeframe: "10Y"
        type: "activity"
        targets:
          - type: "count"
            "min value": 1
      - level: "Level 2"
        type: "activity"
        period:
          period type: sliding
          timeframe: "1Y"
        targets:
          - type: "count"
            "min value": 1
      - level: "Level 3"
        type: "activity"
        period:
          period type: sliding
          timeframe: "1Y"
        targets:
          - type: "count"
            "min value": 4
```

#### Activity Definition
```yaml
apiVersion: v1
kind: application
settings:
  desired level: Level 1 # one team can have multiple applications in different levels
  application: "sauron" # e.g. from deployment
  team: "two towers"

# TODO optional fields results in null values in the output is good?

activities:
  source control protection:
    components:
      - url: "https://test1.com"
        date: 2023-05-01
      - date: 2022-10-01
        url: "https://test1.com"
      - date: 2021-10-01
        url: "https://test1.com"
      - date: 2023-12-19
        url: "https://test1.com"
      - date: 2022-11-19
        url: "https://test2.com"
      - date: 2023-12-19
        url: "https://test2.com"
  conduction of simple threat modeling on a technical level:
    components:
      - date: "2009-11-01"
        title: "test"
        links:
          - title: "testtitle"
            url: "https://test1.com"
      - date: "2020-05-01"
        title: "test"
        links:
          - title: "testtitle"
            url: "https://test1.com"
      - date: "2020-11-01"
        title: "test"
        links:
          - title: "testtitle"
            url: "https://test1.com"
      - date: "2023-11-01"
        title: "test"
        links:
          - title: "testtitle"
            url: "https://test1.com"
```

#### Summary
Advantages:
- Easy to deserialize yamls into objects

Disadvantages:
- Hard to adapt to new requirements of organizations

### Required Activities ( Desired Level )

The level of the application is determined by analysing the current performed activities.
As an organization, I require yearly Penetration Tests for all external exposed applications.

An example is shown in the following table:

|  | Level 1 (internal) | Level 2 (external) | Level 3 (external and processing of sensitive data) |
|--|--------------------|--------------------|-----------------------------------------------------|
| Activity |  | Pentest Bi-Yearly | Pentest Yearly |

Notifications with different time-based thresholds are attached to the activities in the different levels.

Because  Pentest Bi-Yearly  is less strict than  Pentest Yearly , there will be no warning for  Pentest Bi-Yearly , except a Penetration test hasn't been performed for more than two years.


## Name Mapping
For example in MetricCA the activity `reduction of the attack surface` in DSOMM has the name `reduced attack surface` internally.
Therefore, we need a mapping in a `configuration.yaml`:
```YAML
activityNameMapping:
  reduction of the attack surface:
    mappedName: reduced attack surface
    level: Level 2
```


## Formats
Date format is `YYYY-MM-DD`. All files must use the characters [a-zA-z0-9_\-] only.

### DatePeriod vs Date
Activties like `Branch protection is enabled` are only a point in time. A `Date` component is possible here. This would result in a lot of conditions in the code, e.g.:
```java
if (component instanceof DatePeriodComponent) {
    // do something
} else if (component instanceof DateComponent) {
    // do something
}
```
Therefore, we use `DatePeriod` for all activities. In case a `Date` is to be counted, only, the `DatePeriod` is used with a long timeframe, e.g. 10 years.

This makes it harder to add a new activity, but easier to implement the code. 
Activity YAML with DatePeriod:
```YAML
```YAML
activities:
  source control protection:
    components:
      - url: "https://test1.com"
        date: 2023-05-01
      - date: 2022-10-01
        url: "https://test1.com"
```
instead of ´Date´ (NOT USED):
```YAML
activities:
  source control protection:
    components:
      - url: "https://test1.com"
      - url: "https://test1.com"
```
