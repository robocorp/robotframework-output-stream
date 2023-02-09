*** Settings ***
Library     robot_out_stream    WITH NAME    log


*** Test Cases ***
Check no log
    # Variables named password is not logged by default
    ${password}=    Set Variable    pass123
    Some Keyword    ${password}

    # We can mark something to be hidden from any output
    log.Hide From Output    pass456
    Some Keyword    pass456


*** Keywords ***
Some Keyword
    [Arguments]    ${password}
    Log    ${password}
