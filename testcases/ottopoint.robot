*** Settings ***
Library     OperatingSystem
Resource    ../resources/keyOttopointApps.robot


*** Test Cases ***

Login - Success
    ${phone}=    Set Variable   081299465055
    ${expireTime}=    Set Variable   500000s

    ${body}=    Login Request Body    ${phone}     ${expireTime}      
    ${response}=    Login - Success    ${body}
    Log    Response: ${response}

    # --------------------------------------------------------------------------------------------------------------------------------------------


CheckBalance - Success
    ${response}=    CheckBalance - Success   
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------
