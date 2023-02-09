*** Settings ***
Library     robot_out_stream    WITH NAME   log


*** Test Cases ***
Check no log
    Some Keyword


*** Keywords ***
This should not be logged
    [Arguments]    ${arg1}    ${arg2}
    Log    Still log this    level=WARN
    Log    Dont log this

Some Keyword
    Stop Logging keywords
    This should not be logged    1    2
    log.Start logging keywords
