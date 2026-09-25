#!/bin/sh
/xray/xray run -config /xray/config.json &
exec nginx -g 'daemon off;'
