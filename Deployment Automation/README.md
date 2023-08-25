# Deployment Automation
All scripts related to automating Azure resource deployment and configuration

## Ideas
All of these ideas come from a MSSP perspective, meaning that this script's intention is as listed below but it is implied that is should loop tenants and output results in a "organized manner" which has yet been thought about.


- [ ] Workspace check \
```check for the existence of particular resources, return a report consisting of the general/defined resource attributes relevant if exists, if does not exist add the item to a $DNEArray to be shown in "report"/output```
- [ ] Sentinel Resource status \
```Return the number of Playbooks, (and list) analytics rules, (list and content) automation rules```
- [ ] Sentinel Alerting Report \
``` parameter gets the look back period (24/48/72 hours, 7/14/30 days)```

