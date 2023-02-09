*** Settings ***
Library     robot_out_stream    WITH NAME   log


*** Test Cases ***
Check no log
    Some Keyword


*** Keywords ***
Keyword to check
    [Arguments]    ${arg1}    ${arg2}
    Log To Console    ${arg1} - ${arg2}
    [Return]    ${arg1} - ${arg2}

Some Keyword
    Stop Logging variables
    Keyword to check    This should not be logged    And this neither
    log.Start logging variables
