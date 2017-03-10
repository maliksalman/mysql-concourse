#!/bin/bash
set -e -x

root=$PWD

product_file="$(ls -1 ${root}/${pivnet_dir}/${pivnet_tile_prefix}-*.pivotal)"

chmod +x stemcell-downloader/stemcell-downloader-linux

mkdir -p "${root}/stemcell"

./stemcell-downloader/stemcell-downloader-linux \
  --iaas-type "${pcf_iaas}" \
  --product-file "${product_file}" \
  --product-name "${pivnet_product}" \
  --download-dir "${root}/stemcell"

stemcell="$(ls -1 "${root}"/stemcell/*.tgz)"

chmod +x ./tool-om/om-linux

./tool-om/om-linux --target https://opsman.${pcf_ert_domain} \
  --skip-ssl-validation \
  --username "$pcf_opsman_admin" \
  --password "$pcf_opsman_admin_passwd" \
  upload-stemcell \
  --stemcell "${stemcell}"