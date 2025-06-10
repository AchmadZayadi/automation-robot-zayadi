*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections
Library         BuiltIn
Library         String
Resource        ../variables/dev.robot
Resource        keyFridayApps.robot

*** Variables ***
${AUTH_TOKEN}    None


*** Keywords ***
SignIn Request Body
    [Arguments]     ${emailValue}   ${passwordValue}    ${firebaseTokenValue}
    ${bodySign}=    Create Dictionary
    ...     email=${emailValue}
    ...     password=${passwordValue}
    ...     firebaseToken=${firebaseTokenValue}
    RETURN      ${bodySign}

Friday LookupGroupById - Success

    Create Session      LookupGroupById   ${FRIDAY_LOOKUP_GROUP_ID}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=        GET On Session    LookupGroupById    ${FRIDAY_LOOKUP_GROUP_ID}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

ClockIn Request Body
    [Arguments]     ${longitudeValue}   ${latitudeValue}    ${timestampValue}   ${typeValue}    ${clockInOutOfficeFlagValue}
    ${bodyClockIn}=    Create Dictionary
    ...     longitude=${longitudeValue}
    ...     latitude=${latitudeValue}
    ...     timestamp=${timestampValue}
    ...     type=${typeValue}
    ...     clockInOutOfficeFlag=${clockInOutOfficeFlagValue}
    RETURN      ${bodyClockIn}

ClockOut Request Body
    [Arguments]     ${longitudeValue}   ${latitudeValue}    ${timestampValue}   ${typeValue}    ${clockInOutOfficeFlagValue}
    ${bodyClockOut}=    Create Dictionary
    ...     longitude=${longitudeValue}
    ...     latitude=${latitudeValue}
    ...     timestamp=${timestampValue}
    ...     type=${typeValue}
    ...     clockInOutOfficeFlag=${clockInOutOfficeFlagValue}
    RETURN      ${bodyClockOut}


OverTimeApplicationPost Request Body
    [Arguments]     ${id}   ${ticketId}    ${startDate}   ${endDate}    ${membersId}
    ${bodyOverTimeApplicationPost}=    Create Dictionary
    ...     id=${id}
    ...     ticketId=${ticketId}
    ...     startDate=${startDate}
    ...     endDate=${endDate}
    ...     membersId=${membersId}
    RETURN      ${bodyOverTimeApplicationPost}

OverTimeApproval Request Body
    [Arguments]     ${id}   ${approvalFlag}    ${rejectReason}
    ${bodyOverTimeApproval}=    Create Dictionary
    ...     id=${id}
    ...     approvalFlag=${approvalFlag}
    ...     rejectReason=${rejectReason}
    RETURN      ${bodyOverTimeApproval}

ChangePassword Request Body
    [Arguments]     ${oldPassword}   ${newPassword}    
    ${bodyChangePassword}=    Create Dictionary
    ...     oldPassword=${oldPassword}
    ...     newPassword=${newPassword}
    RETURN      ${bodyChangePassword}

RedeemApplication Request Body
    [Arguments]     ${id}   ${requestorId}      ${startDate}      ${endDate}      ${file}         ${typeId}    
    ${bodyRedeemApplication}=    Create Dictionary
    ...     id=${id}
    ...     requestorId=${requestorId}
    ...     startDate=${startDate}
    ...     endDate=${endDate}
    ...     file=${file}
    ...     typeId=${typeId}
    RETURN      ${bodyRedeemApplication}

RedeemApproval Request Body
    [Arguments]     ${id}   ${approvalFlag}      
    ${bodyRedeemApproval}=    Create Dictionary
    ...     id=${id}
    ...     approvalFlag=${approvalFlag}
    RETURN      ${bodyRedeemApproval}

SignOut Request Body
    [Arguments]     
    ${bodySignOut}=    Create Dictionary
    RETURN      ${bodySignOut}



# --------------------------------------------------------------------------------------------------------------------------------------------
Friday SignIn - Success
    [Arguments]         ${bodySign}
    Create Session      SignIn   ${FRIDAY_SIGNIN}    verify=False
    ${response}=    POST On Session    SignIn    ${FRIDAY_SIGNIN}    json=${bodySign}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    Log         SIGNIN Response: ${response.json()} 
    Log         SIGNIN Response: ${response.json()['data']['expiresIn']} 
    ${token}=    Set Variable    ${response.json()['data']['token']}
    Log         SIGNIN Token: ${token}
    Set Global Variable    ${AUTH_TOKEN}    ${token}
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday ClockIn - Success
    [Arguments]         ${bodyClockIn}
    Create Session      ClockIn   ${FRIDAY_LOGINLOGOUT}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    ClockIn    ${FRIDAY_LOGINLOGOUT}         headers=${auth_header}       json=${bodyClockIn}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    Log    SIGNIN Response: ${response.json()['data']['id']} 
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday ClockOut - Success
    [Arguments]         ${bodyClockOut}
    Create Session      ClockOut   ${FRIDAY_LOGINLOGOUT}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    ClockOut    ${FRIDAY_LOGINLOGOUT}         headers=${auth_header}       json=${bodyClockOut}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    Log    SIGNIN Response: ${response.json()['data']['id']} 
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------


Friday ProfileEmployee - Success

    Create Session      ProfileEmployee   ${FRIDAY_PROFILE_EMPLOYEE}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    ProfileEmployee    ${FRIDAY_PROFILE_EMPLOYEE}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday ProfilePersonal - Success

    Create Session      ProfilePersonal   ${FRIDAY_PROFILE_PERSONAL}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    ProfilePersonal    ${FRIDAY_PROFILE_PERSONAL}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday AttendanceHistory - Success

    Create Session      AttendanceHistory   ${FRIDAY_ATTENDANCE_HISTORY}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    AttendanceHistory    ${FRIDAY_ATTENDANCE_HISTORY}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------


Friday OverTimeHistory - Success

    Create Session      OverTimeHistory   ${FRIDAY_OVERTIME_HISTORY}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    OverTimeHistory    ${FRIDAY_OVERTIME_HISTORY}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday OverTimeApplication - Success

    Create Session      OverTimeApplication   ${FRIDAY_OVERTIME_APPLICATION}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    OverTimeApplication    ${FRIDAY_OVERTIME_APPLICATION}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday LookupGroup - Success

    Create Session      LookupGroup   ${FRIDAY_LOOKUP_GROUP}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    LookupGroup    ${FRIDAY_LOOKUP_GROUP}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------
Friday DashboardCounter - Success

    Create Session      DashboardCounter   ${FRIDAY_DASHBOARD_COUNTER}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    DashboardCounter    ${FRIDAY_DASHBOARD_COUNTER}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday RedeemHistory - Success

    Create Session      RedeemHistory   ${FRIDAY_REDEEM_HISTORY}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    RedeemHistory    ${FRIDAY_REDEEM_HISTORY}         headers=${auth_header}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings     ${response.json()['meta']['code']}    2000100
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday OverTimeApplicationPost - Success
    [Arguments]         ${bodyOverTimeApplicationPost}
    Create Session      OverTimeApplicationPost   ${FRIDAY_OVERTIME_APPLICATION_POST}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    OverTimeApplicationPost    ${FRIDAY_OVERTIME_APPLICATION_POST}         headers=${auth_header}       json=${bodyOverTimeApplicationPost}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday OverTimeApproval - Success
    [Arguments]         ${bodyOverTimeApproval}
    Create Session      OverTimeApproval   ${FRIDAY_OVERTIME_APPROVAL}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    OverTimeApproval    ${FRIDAY_OVERTIME_APPROVAL}         headers=${auth_header}       json=${bodyOverTimeApproval}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday ChangePassword - Success
    [Arguments]         ${bodyChangePassword}
    Create Session      ChangePassword   ${FRIDAY_CHANGE_PASSWORD}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    ChangePassword    ${FRIDAY_CHANGE_PASSWORD}         headers=${auth_header}       json=${bodyChangePassword}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------


Friday RedeemApplication - Success
    [Arguments]         ${bodyRedeemApplication}
    Create Session      RedeemApplication   ${FRIDAY_REDEEM_APPLICATION}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    RedeemApplication    ${FRIDAY_REDEEM_APPLICATION}         headers=${auth_header}       json=${bodyRedeemApplication}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------


Friday RedeemApproval - Success
    [Arguments]         ${bodyRedeemApproval}
    Create Session      RedeemApproval   ${FRIDAY_REDEEM_APPROVAL}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    RedeemApproval    ${FRIDAY_REDEEM_APPROVAL}         headers=${auth_header}       json=${bodyRedeemApproval}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------

Friday SignOut - Success
    [Arguments]         ${bodySignOut}
    Create Session      SignOut   ${FRIDAY_SIGNOUT}    verify=False
    ${auth_header}=     Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    SignOut    ${FRIDAY_SIGNOUT}         headers=${auth_header}       json=${bodySignOut}
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response.json()}
    
    # --------------------------------------------------------------------------------------------------------------------------------------------



