#!/bin/sh
. /vagrant/config.sh

#Create and configure an Fn context for OCI
fn create context ${compartment_name} --provider oracle
fn use context ${compartment_name}
fn update context oracle.compartment-id ${compartment_id}
fn update context api-url https://functions.${region}.oci.oraclecloud.com
fn update context registry ${region}.ocir.io/${registry}/${repo}
fn update context oracle.profile ${compartment_name}

#Connect to the OCI docker registry
docker login ${region}.ocir.io -u ${registry}/${user} -p ${token}