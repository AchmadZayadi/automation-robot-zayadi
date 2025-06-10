*** Settings ***
Library     OperatingSystem
Resource    ../resources/keyFridayApps.robot


*** Test Cases ***
Signin Friday - Success
    ${emailValue}=    Set Variable   dendy.zain@ottodigital.id
    ${passwordValue}=    Set Variable   1234567
    ${firebaseTokenValue}=     Set Variable     112233
    ${body}=    SignIn Request Body    ${emailValue}     ${passwordValue}      ${firebaseTokenValue}
    ${response}=    Friday SignIn - Success    ${body}
    Log    Response: ${response}

    # --------------------------------------------------------------------------------------------------------------------------------------------


ClockIn Friday - Success
    ${longitudeValue}=    Set Variable   -6.230644
    ${latitudeValue}=    Set Variable   12106.8447213456
    ${timestampValue}=     Set Variable     1749193990
    ${typeValue}=     Set Variable     ClockIn
    ${clockInOutOfficeFlagValue}=     Set Variable     1
    ${body}=    ClockIn Request Body    ${longitudeValue}     ${latitudeValue}      ${timestampValue}        ${typeValue}        ${clockInOutOfficeFlagValue}
    ${response}=    Friday ClockIn - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

ClockOut Friday - Success
    ${longitudeValue}=    Set Variable   -6.230644
    ${latitudeValue}=    Set Variable   12106.8447213456
    ${timestampValue}=     Set Variable     1749193990
    ${typeValue}=     Set Variable     ClockOut
    ${clockInOutOfficeFlagValue}=     Set Variable     2
    ${body}=    ClockOut Request Body    ${longitudeValue}     ${latitudeValue}      ${timestampValue}        ${typeValue}        ${clockInOutOfficeFlagValue}
    ${response}=    Friday ClockOut - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


ProfileEmployee Friday - Success
    ${response}=    Friday ProfileEmployee - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

ProfilePersonal Friday - Success
    ${response}=    Friday ProfilePersonal - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

AttendanceHistory Friday - Success
    ${response}=    Friday AttendanceHistory - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


OverTimeHistory Friday - Success
    ${response}=    Friday OverTimeHistory - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


OverTimeApplication Friday - Success
    ${response}=    Friday OverTimeApplication - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

LookupGroup Friday - Success
    ${response}=    Friday LookupGroup - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

DashboardCounter Friday - Success
    ${response}=    Friday DashboardCounter - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

RedeemHistory Friday - Success
    ${response}=    Friday RedeemHistory - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


OverTimeApplicationPost Friday - Success
    ${id}=    Set Variable   01JQ3GS25WGEY87S3R2PZ8Z7QJ
    ${ticketId}=    Set Variable   string
    ${startDate}=     Set Variable     1742738400
    ${endDate}=     Set Variable     1742738400
    ${membersId}=     Set Variable  Arrays   [01JPRQ0DZEG4GDYW19X5YWF2JA,014KG56DC01GG4TEB01ZEX7WFJ,01JQ5JRWQ4A5G5MM87BD8CR984]
    ${body}=    OverTimeApplicationPost Request Body    ${id}     ${ticketId}      ${startDate}        ${endDate}        ${membersId}
    ${response}=    Friday OverTimeApplicationPost - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


OverTimeApproval Friday - Success
    ${id}=    Set Variable   01JQ5T8FK7RWCYW0TYY0YB383P
    ${approvalFlag}=    Set Variable   2
    ${rejectReason}=     Set Variable     kosong
    ${body}=    OverTimeApproval Request Body    ${id}     ${approvalFlag}      ${rejectReason}
    ${response}=    Friday OverTimeApproval - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


ChangePassword Friday - Success
    ${oldPassword}=    Set Variable   123456
    ${newPassword}=    Set Variable   1234567
    ${body}=    ChangePassword Request Body    ${oldPassword}     ${newPassword}     
    ${response}=    Friday ChangePassword - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

RedeemApplication Friday - Success
    ${id}=    Set Variable   11
    ${requestorId}=    Set Variable   01JPRQ0DZEG4GDYW19X5YWF2JA
    ${startDate}=    Set Variable   1742798419368
    ${endDate}=    Set Variable   2025-03-25T00:00:00Z
    ${file}=    Set Variable   
    ${typeId}=    Set Variable   01JPS63MAYWQQ6ACK9RBYFAXP8
    ${body}=    RedeemApplication Request Body    ${id}     ${requestorId}      ${startDate}      ${endDate}      ${file}      ${typeId}     
    ${response}=    Friday RedeemApplication - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


RedeemApproval Friday - Success
    ${id}=    Set Variable   01JVXYJBGMPM9N5MV3SVF2T6KT
    ${approvalFlag}=    Set Variable   1
    ${body}=    RedeemApproval Request Body    ${id}     ${approvalFlag}         
    ${response}=    Friday RedeemApproval - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

LookupGroupById Friday - Success
    ${response}=    Friday LookupGroupById - Success
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------


SignOut Friday - Success
    ${body}=    SignOut Request Body   
    ${response}=    Friday SignOut - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

