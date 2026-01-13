#!/bin/sh
curl -s "wttr.in/?format=%t&m" | sed 's/^/󰖐  /'
