#!/bin/bash

#s3cmd -c ./rgw.cfg mk s3://zoneminder

s3cmd -c ./rgw.cfg ls s3://zoneminder/
