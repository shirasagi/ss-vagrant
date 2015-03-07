#!/bin/bash
base_dir=$(cd $(dirname $0) && pwd)
exec env packer build -only=virtualbox-iso $base_dir/template.json
