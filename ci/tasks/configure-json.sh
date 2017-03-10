#!/bin/bash

set -e


# Set Vars
json_file_path="mysql-concourse/json_templates/${pcf_iaas}/${terraform_template}"
json_file_template="${json_file_path}/mysql-template.json"
json_file="json_file/mysql.json"

cp ${json_file_template} ${json_file}

if [[ ! -f ${json_file} ]]; then
  echo "Error: cant find file=[${json_file}]"
  exit 1
fi
