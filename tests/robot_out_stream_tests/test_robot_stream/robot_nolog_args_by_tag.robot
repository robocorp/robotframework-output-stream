*** Settings ***
Library     robot_out_stream    WITH NAME    log


*** Test Cases ***
Check no log
    Some Keyword
    This should be logged    3    4


*** Keywords ***
These args should not be logged
    [Arguments]    ${arg1}    ${arg2}
    Log To Console    ${arg1} - ${arg2}

This should be logged
    [Arguments]    ${arg1}    ${arg2}
    Log To Console    ${arg1} - ${arg2}

Some Keyword
    [Tags]    log:ignore-keyword-arguments
    These args should not be logged    1    2
