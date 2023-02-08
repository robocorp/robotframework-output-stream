*** Settings ***
Library     robot_out_stream    WITH NAME   log


*** Test Cases ***
Check no log
    Some Keyword


*** Keywords ***
This should not be logged
    [Arguments]    ${arg1}    ${arg2}
    Log To Console    ${arg1} - ${arg2}

Some Keyword
    Stop Logging keywords
    This should not be logged    1    2
    log.Start logging keywords
