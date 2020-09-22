#!/bin/sh
# ---Globals---
ALL_GREEN=true

# ---Helpers---
fail() {
	if [ "$FAIL_FAST" = true ]; then
		exit 1
	else
		ALL_GREEN=false
		echo
	fi
}

usage() {
	echo 'usage: 0x0.sh file [file | -]'
	echo '       0x0.sh url [url]'
	echo '       0x0.sh shorten [url]'
	echo '       0x0.sh [-h | --help | help]'
}

# ---Tests---
# Test 1
assertion='Error message is printed when curl is not in PATH'
command='./0x0.sh'
expected_output='curl: not found'
actual_output="$(PATH="" $command 2>&1)"

if [ ! "$actual_output" = "$expected_output" ]; then
	echo '---ASSERTION---'
	echo "$assertion"
	echo '---COMMAND---'
	echo "$command"
	echo '---EXPECTED OUTPUT---'
	echo "$expected_output"
	echo '---ACTUAL OUTPUT---'
	echo "$actual_output"
	fail
fi

# Test 2
assertion='Error message is printed when too few arguments are passed'
command='./0x0.sh file'
expected_output="$(usage)"
actual_output="$($command 2>&1)"

if [ ! "$actual_output" = "$expected_output" ]; then
	echo '---ASSERTION---'
	echo "$assertion"
	echo '---COMMAND---'
	echo "$command"
	echo '---EXPECTED OUTPUT---'
	echo "$expected_output"
	echo '---ACTUAL OUTPUT---'
	echo "$actual_output"
	fail
fi

# ---Report---
if [ "$ALL_GREEN" = true ]; then
	echo 'All tests passed'
fi
