*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections
Library         BuiltIn
Library         String
Resource        ../variables/dev.robot
Resource        keyOttopointApps.robot
Library         Collections
Library         String
Library         OperatingSystem
Library         BuiltIn


*** Variables ***
${InstitutionId}     ONCP0004
${Deviceid}          7179948586
${Geolocation}       -6.236942520911433, 106.825000507283605
${ChannelId}         H2H
${AppsId}            appsid
${Signature}         5a2d5a1dbd129a031bf36cb83891e48765ebbcb31bcb40bd4d0942708cf725143e64af6276cfb3d633093bd683c4d6bc4a814bc9fa08d67c86cb8680060ea5f6
${Timestamp}         1726033478
${key}               a461030a-6c8d-4658-bc09-dea08fd0f706
${Authorization}     NGE3MDZkODQtOTE2Yy00MGYyLWExNjYtMjg5NzAwZmI3MzEx
${AUTH_TOKEN}        None


*** Keywords ***

Generate Random Numeric
    [Arguments]    ${length}
    ${result}=    Evaluate    ''.join(__import__('random').choices('0123456789', k=int(${length})))
    RETURN    ${result}

Generate Random AlphaNumeric
    [Arguments]    ${length}
    ${result}=    Evaluate    ''.join(__import__('random').choices('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789', k=int(${length})))
    RETURN    ${result}

Sort JSON Object
    [Arguments]    ${json_string}
    ${parsed}=    Evaluate    __import__('json').loads('''${json_string}''')
    ${sorted}=    Evaluate    dict(sorted(${parsed}.items()))
    ${re_serialized}=    Evaluate    __import__('json').dumps(${sorted}, separators=(',', ':'))
    RETURN    ${re_serialized}

Generate Signature
    [Arguments]    ${body}    ${data}
    ${sorted_body}=    Sort JSON Object    ${body}
    ${trimmed}=    Replace String Using Regexp    ${sorted_body}    [^a-zA-Z0-9{}:.,]    ''
    ${lower}=    Convert To Lower Case    ${trimmed}
    ${combined}=    Catenate    SEPARATOR=&    ${lower}    ${data.deviceID}    ${data.institutionID}    ${data.geolocation}    ${data.channelID}    ${data.appsID}    ${data.timeStamp}    ${data.key}
    ${signature}=    Evaluate    __import__('hmac').new(bytes('''${data.key}''','utf-8'), bytes('''${combined}''','utf-8'), __import__('hashlib').sha512).hexdigest()
    RETURN    ${signature}

Set headers
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${Authorization}
    ...    timestamp=${Timestamp}
    ...    institutionId=${InstitutionId}
    ...    deviceId=${Deviceid}
    ...    Geolocation=${Geolocation}
    ...    channelId=${ChannelId}
    ...    appsId=${AppsId}
    ...    Signature=    
    RETURN    ${headers}

Set headersLogin
    ${headers}=    Create Dictionary
    ...    timestamp=${Timestamp}
    ...    institutionId=${InstitutionId}
    ...    deviceId=${Deviceid}
    ...    Geolocation=${Geolocation}
    ...    channelId=${ChannelId}
    ...    appsId=${AppsId}
    ...    Signature=${Signature}
    RETURN    ${headers}

Login Request Body
    [Arguments]     ${phone}   ${expireTime}    
    ${bodySign}=    Set Variable    {"phone":"081299465055","expireTime":"500000s"}
    &{data}=    Create Dictionary
    ...    timestamp=${Timestamp}
    ...    deviceId=${Deviceid}
    ...    Geolocation=${Geolocation}
    ...    appsID=${AppsId}
    ...    channelID=${ChannelId}
    ...    institutionId=${InstitutionId}
    ...    key=${key}

    ...    Signature=${Signature}
    RETURN          ${bodySign}




# --------------------------------------------------------------------------------------------------------------------------------------------
Login - Success
    ${headersOttopoint}=     Set headersLogin
    [Arguments]         ${bodySign}
    Create Session      Login   ${OTTOPOINT_LOGIN}    verify=False
    ${response}=    POST On Session    Login    ${OTTOPOINT_LOGIN}    json=${bodySign}        headers=${headersOttopoint}
    Should Be Equal As Integers    ${response.status_code}    200

    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------


CheckBalance - Success
    ${headersOttopoint}=     Set headers
    Create Session      CheckBalance   ${OTTOPOINT_BALANCE}    verify=False
    ${response}=        GET On Session    CheckBalance    ${OTTOPOINT_BALANCE}         headers=${headersOttopoint}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

