#!/bin/bash
#
here=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -z "$1" ]]; then
	echo "Please provide a name for the new post"
	exit 1
fi

post_name="$1"

hugo -s ${here}/site new posts/${post_name}.md
