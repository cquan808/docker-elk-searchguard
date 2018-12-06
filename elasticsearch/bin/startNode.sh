#!/bin/sh
# Start searchguard elasticsearch
plugins/search-guard-6/tools/sgadmin.sh \
	-cd config/sg/ \
	-nhnv \
	-icl \
        -cacert config/root-ca.pem \
        -cert config/admin.pem \
	-key config/admin.key \
#	-keypass admin
