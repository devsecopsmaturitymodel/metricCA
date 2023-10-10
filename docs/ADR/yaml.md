# Architectural Decision YAML structure

As a Product Owner, I easily want to find the entries I need to change.

## DSOMM

In an enterprise, hundreds of teams will be listed which makes it hard to find the own time and update the YAML as a product owner.

## YAML Folder structure

To have the team name in the folder name has the following advantages:

- Easy to manage

To have the team name in the folder name has the following disadvantages:

- Folder name should only be [a-Z0-9]\-

As an alternative, config.yaml/metadata.yaml can be used to define the team names within the corresponding folder.

## YAML structure

Team folders on the first level allow the product owner to easily find relevant entries.

In this structure, the Product Owner will need guidance on how to add new YAMLs to the team-based folder or new files need to be added automatically.

We use the categories  Team-based  and  Application-based . For example the activity  Nominate a security champion  is often team based. While the activity  Branch protection is enabled  is application-based.

The YAMLs describe the requirements. The maturity model state based on the status of each activity is analyzed by the application.

Date format is `Year-Month-Day`.

Application-based sample `teamRebels/applicationDeathStar.yaml`:

```YAML
application settings:
  desired level: Basic understanding of security practices # one team can have multiple applications in different levels
  application id: 1234 # e.g. from deployment

activities:
  # Plan
  conduction of simple threat modeling on a technical level:
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
    read date:
      - 2022-09-02
      - 2023-09-01
  security requirements:
    read date:
      - 2022-09-02
      - 2023-09-01
  # Code
  source control protection:
    url: example.com/repo/123 # Link to application URL
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
    url: https://github.com/org/repo/.github/workflows # access checked on PR

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

  # TODO we could ask for an infrastructure component, e.g. openshift, aws-k8s, local docker platform and inherit this
  same artifact for environments:
    artifact url: https://hub.docker.com/org/image-name/

  # Operate
  # mean time to patch: Hard to identify
  automated PRs for patches:
    configuration url: https://github.com/org/repo/dependabot.yaml

  # Monitor
  logging capabilities:
    - confirmed by security team member: Max Mustermann
      confirmed date: 2023-10-09

  # TODO we could ask for an infrastructure component, e.g. openshift, aws-k8s, local docker platform and inherit this
  centralized application logging:
    logging_url: https://grafana.tool.internal.local/applicationId

  # TODO we could ask for an infrastructure component, e.g. openshift, aws-k8s, local docker platform and inherit this  
  simple application metrics:
    - confirmed by po: Max Mustermann
      confirmed date: 2023-10-09
    # supported?
    # configured?

  # TODO link to a sample instead of confirmed?
  advanced app. metrics:
    - confirmed by po: Max Mustermann
      confirmed date: 2023-10-09

  targeted alerting:
    - confirmed by po: Max Mustermann
      confirmed date: 2023-10-09

  definition of simple BCDR practices for critical components:
    url: https://org.confluence.com/application/incident-response
    confirmed by po: Max Mustermann
    confirmed date: 2023-10-09

  # TODO link to a sample instead of confirmed?
  advanced logging:
    security_team_confirmation:
      - confirmed by: Max Mustermann
        confirmed date: 2023-10-09


```

Application-based yamls have the prefix `application`, a second application for the team rebels could be named like `teamXYZ/applicationStarDestroyer.yaml`.

Team-based sample `teamRebels/team.yaml`:

```YAML
activities:
  each team has a security champion:
    nomination: Max Mustermann # Name of the security champion
  regular security training for all:
    - title: xyz
      start-date: 2023-09-01 # or end date?
      hours: 8 # total number of hours for all participants in the team
      reference: https://training.example.com/containerSecurity # link to training slides, optional
  coding standard:
    - read date: 2022-09-02
    - read date: 2023-09-01
    
```

Team-based activities are inherited to Application-Based activities.

Disadvantages:

* One yaml might reduce the overview.

### Required Activities ( Desired Level )

The level of the application is determined by analysing the current performed activities.
As an organization, I require yearly Penetration Tests for all external exposed applications.

An example is shown in the following table:

|  | Level 1 (internal) | Level 2 (external) | Level 3 (external and processing of sensitive data) |
|--|--------------------|--------------------|-----------------------------------------------------|
| Activity |  | Pentest Bi-Yearly | Pentest Yearly |

Notifications with different time-based thresholds are attached to the activities in the different levels.

Because  Pentest Bi-Yearly  is less strict than  Pentest Yearly , there will be no warning for  Pentest Bi-Yearly , except a Penetration test hasn't been performed for more than two years.

## Types
The following activity types exist:

* hours (e.g. regular security training for all)
* existingAttribute (e.g. each team has a security champion)
  * url, e.g. (environment depending configuration parameters (secrets))
* date based e.g. coding standard, inherited:
  * date and documentation (e.g. conduction of simple threat modeling on a technical level)
  * confirmed by (e.g. security code review)
    * confirmed finding (e.g. Continuous penetration tests)

The activities and the corresponding activity types might be configured in a `configuration.yaml`

## configuration.yaml mounted to the service
Thresholds are not part of the configuration, because they are handled in grafana.
TODO: Ask SI if we can populate thresholds
```YAML
data privacy requirements:
  components:
    - array: date # TODO 
  mapping: Logging: PII logging concept
  level: Level 1
conduction of simple threat modeling on a technical level:
  components:
    array:
      - title: string  
        date: date
        array:
          - title: string
          - url: url
  level: Level 2
```

## Name Mapping
For example in MetricCA the activity `reduction of the attack surface` in DSOMM has the name `reduced attack surface` internally.
Therefore, we need a mapping in a `configuration.yaml`:
```YAML
activityNameMapping:
  reduction of the attack surface:
    mappedName: reduced attack surface
    level: Level 2
```