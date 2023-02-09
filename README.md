# Compact and streaming-ready output for Robot Framework.

A custom output listener for Robot Framework enabling real-time analysis in a more compact format.

> Note: The current version is still pre-alpha and the [format specified](/docs/format.md) may still change.

## Why

The default Robot Framework output and reports quickly get really big or break when running big or long-running cases. Log handling is also using a lot of resources and if robot execution just breaks, the output.xml usually is corrupted and needs manual fixes.

### Scoping the problem

The default output of Robot Framework (output.xml, log.html and report.html):
* Unable to stream the log by default during the run
* The output generation is a resource-heavy task that can and does break executions.
* `output.xml`, `log.html`, `report.html` get really big on disk.
* The `output.xml` needs "closing", so any problems while creating it yield a corrupted XML file and no logs.
  * Post-processing is only possible in some cases and is also resource intensive.
  * ..and in cases where the `output.xml` already breaks the post-processing is not possible.
* Flattening and changing the robot code is a big task and is only sometimes possible.

### Scoping the solution
We need:
* Compact format to reduce the file size and reduce the load on machine resources.
* The output file that is intact after each write (journaling/transactional pattern).
* Ability to control how much space the logs can take.
* Ability to stream the log during the run
* Match the original data content, so it is possible to create the existing logs from the new data format.
* Solution needs to work without changes to the robot code itself.

## What

Implementation is based on a Robot Framework Listener, so it's possible to use it in any Robot Framework run using the `--listener` argument.

### Installation

Install with:

`pip install robotframework-output-stream`

### Usage

`python -m robot -l NONE -r NONE -o NONE --listener robot_out_stream.RFStream:--dir=<dir_to_output>:--max-file-size=<5m>:--max-files=<5>:--log=<log.html>`

* The `-l NONE and -r NONE -o NONE` arguments disable the standard Robot Framework output.
* More details on the arguments are below.


## Dealing with sensitive data in the logs

* See: [Handling Sensitive Data](/docs/handling_sensitive_data.md)


## How

The "how" of the solution is essentially the listener arguments, data format and the parsers:

* [Format specification](/docs/format.md)
* [Listener arguments](/docs/arguments.md)
