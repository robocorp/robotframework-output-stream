# Compact and streaming-ready output for Robot Framework.

A custom output listener for Robot Framework enabling realtime analysis in a more compact format.

> The current version is still pre-alpha and the [format specified](/docs/format.md) may still change.

## Why

The default Robot Framework output and reports quickly get really big or break when running big or long-running cases. Log handling is also using a lot of resources and taking time. Also, if robot execution just breaks, the output.xml usually is corrupted and needs fixes.

### Scoping the problem
* Unable to stream the log by default during the run
* The generation of output.xml and then the log.html etc., are really resource-heavy tasks that can and do break executions and even lock-up entire machines.
* output.xml, log.html, report.html duplicate data
* The output.xml needs "closing", so any problems while exporting yield a corrupted XML file.
* Post-processing is only possible in some cases and is also resource intensive.
* Flattening and changing the robot code is a big task in big cases and is only sometimes possible. And is optimization that will eventually still break.

### Scoping the solution
We need:
* Ability to stream the log during the run
* Ability to control how much time and space the logs can take
* Compact format to reduce the file size
* The output file is intact after each write (journaling/transactional pattern)
* Separate the data from the log visualization and enable styling of the log.html
* Enable log.html that uses the data from separate files, to avoid duplication of data
* Keep the same data content so that it is possible to create the existing logs from the new data format.


## Details

Its implementation is based on a Robot Framework Listener, so, it's possible to use it in any Robot Framework run by using the `--listener` argument.

## Installation

Install with:

`pip install robotframework-output-stream`

## Usage

`python -m robot -l NONE -r NONE -o NONE --listener robot_out_stream.RFStream:--dir=<dir_to_output>:--max-file-size=<5m>:--max-files=<5>:--log=<log.html>`


* The `-l NONE and -r NONE -o NONE` arguments disable the standard Robot Framework output.
* More details on the arguments below.

### Listener Arguments

  `--dir`
  
    Points to a directory where the output files should be written.
    (default: '.' -- i.e.: working dir).
    
    Note: if a ':' is used it should be changed to <COLON> (because a ':'
    char is used as the separator by Robot Framework).
    So, something as `c:/temp/foo` should be written as `c<COLON>/temp/foo`.
    
    Example:
    
      --dir=./output
      --dir=c<COLON>/temp/output

  `--max-file-size`
  
    Specifies the maximum file size before a rotation for the output file occurs.
    
    The size can be specified with its unit.
    The following units are supported: `gb, g, mb, m, kb, k, b`
    (to support gigabytes=gb or g, megabytes=mb or m, kilobytes=kb or k, bytes=b).
    
    Note: if no unit is specified, it's considered as bytes.
    
    Example:
    
      --max-file-size=200kb
      --max-file-size=2mb
      --max-file-size=1gb
      --max-file-size=10000b

  `--max-files`
  
    Specifies the maximum number of files to be generated in the logging before
    starting to prune old files.
    
    i.e.: If `--max-files=2`, it will generate `output.rfstream`, `output_2.rfstream`
    and when `output_3.rfstream` is about to be generated it'll erase `output.rfstream`.
    
    Example:
    
      --max-files=3

  `--log`
  
    If specified writes html contents which enables the log contents to be
    viewed embedded in an html file.
    It should point to a path in the filesystem.
    
    Note: if a ':' is used it should be changed to <COLON> (because a ':'
    char is used as the separator by Robot Framework).
    So, something as `c:/temp/log.html` should be written as `c<COLON>/temp/log.html`.
    
    Note: the contents embedded in the file will contain the files written on disk
    but embedded as a compressed information (so, its size should be less than
    the size of the contents on disk), note that contents prunned from the log
    (due to the --max-files setting) will NOT appear in the log.html.
    
    Example:
    
      --log=./logs/log.html
      --log=c<COLON>/temp/log.html

## The file format

Details of the file format and specifications can be found in the [format specification](/docs/format.md)
