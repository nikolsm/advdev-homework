#!/bin/bash
# Reset Production Project (initial active services: Blue)
# This sets all services to the Blue service so that any pipeline run will deploy Green
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 GUID"
    exit 1
fi

GUID=$1
echo "Resetting Parks Production Environment in project ${GUID}-parks-prod to Green Services"

# Code to reset the parks production environment to make
# all the green services/routes active.
# This script will be called in the grading pipeline
# if the pipeline is executed without setting
# up the whole infrastructure to guarantee a Blue
# rollout followed by a Green rollout.

# To be Implemented by Student


oc patch route/parksmap -n ${GUID}-parks-prod -p '{"spec":{"to":{"name": "parksmap-green"}}}'

oc delete svc/mlbparks-blue -n ${GUID}-parks-prod
oc delete svc/mlbparks-green -n ${GUID}-parks-prod
oc expose dc mlbparks-green -l type=parksmap-backend --port 8080 -n ${GUID}-parks-prod
oc expose dc mlbparks-blue --port 8080 -n ${GUID}-parks-prod


oc delete svc/nationalparks-blue -n ${GUID}-parks-prod
oc delete svc/nationalparks-green -n ${GUID}-parks-prod
oc expose dc nationalparks-green -l type=parksmap-backend --port 8080 -n ${GUID}-parks-prod
oc expose dc nationalparks-blue --port 8080 -n ${GUID}-parks-prod

