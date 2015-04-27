#!/bin/bash
base_dir=$(cd $(dirname $0) && pwd)
exec env packer build -only=virtualbox-iso $base_dir/template.json
exec env packer build -only=virtualbox-iso -var-file=virtualbox-i386-variables.json $base_dir/template.json
exec env packer build -only=amazon-ebs $base_dir/template.json
