*** Settings ***
Library    OperatingSystem
Resource    ../resources/keySecurePageQris.robot

*** Test Cases ***
Generate QRDynamic Off Us - SecurePage - Success
    ${amount}=    Evaluate    int(random.randint(11111, 44444))
    Set Global Variable    ${amountGlobal}    ${amount}
    ${trxRef}=    Get Time    result_format=%Y%m%d%H%M%S
    ${trxRef}=    Set Variable    TS${trxRef}
    Set Global Variable    ${trxRefPayment}    ${trxRef}
    ${body}=    Build Request Body    ${trxRefPayment}    ${amountGlobal}
    ${signature}=    Generate Signature    ${body}
    ${qr_result}=    Generate QR Code    ${signature}    ${body}
    ${qrData}=    Set Variable   ${qr_result['qrData']}
    Set Global Variable    ${qrDataSecurePageQRIS}    ${qrData}
    Log    Response: ${qr_result['qrData']}

Reverse QRDynamic Off Us - SecurePage - Success
    ${body}=    Build Reverse SecurePage QRDynamic Request Body    ${qrDataSecurePageQRIS}
    ${response}=    ReverseQR - Securepage   ${body}
    ${mpan}=    Set Variable    ${response['2601']}
    ${mid}=    Set Variable    ${response['2602']}
    ${de43}=    Set Variable    ${response['59']}${response['60']}${response['58']}
    ${tid}=    Set Variable    ${response['6207']}
    ${de18}=    Set Variable    ${response['52']}
    ${de22}=    Set Variable    ${response['62']}[:3]
    ${de100de32}=    Set Variable    ${mpan}[:8]
    ${de49}=    Set Variable    ${response['53']}
    ${de57}=    Set Variable    6105${response['61']}6270${response['62']}
    ${billId}=    Set Variable    ${response['6201']}
    SET Global Variable    ${mpanGlobal}    ${mpan}
    SET Global Variable    ${midGlobal}    ${mid}    
    SET Global Variable    ${de43Global}    ${de43}
    SET Global Variable    ${tidGlobal}    ${tid}
    SET Global Variable    ${de18Global}    ${de18}
    SET Global Variable    ${de22Global}    ${de22}
    SET Global Variable    ${de100de32Global}    ${de100de32}
    SET Global Variable    ${de49Global}    ${de49}
    SET Global Variable    ${de57Global}    ${de57}
    SET Global Variable    ${billIdGlobal}    ${billId}
    Log    mpan: ${mpan}
    Log    mid: ${mid}
    Log    de43: ${de43}
    Log    tid: ${tid}
    Log    de18: ${de18}
    Log    de22: ${de22}
    Log    de100de22: ${de100de32}
    Log    de49: ${de49}
    Log    de57: ${de57}
    Log    billId: ${billId}
    Log    Response: ${response}

Payment QRDynamic Off Us - Securepage - Success
    ${amount}=    Set Variable   ${amountGlobal}
    ${custAccount}=    Set Variable    089634679074
    ${booleanQR}=    Evaluate    bool("False")
    ${randomStrNumber}=    Evaluate    str(random.randint(111111111111, 999999999999))
    Set Global Variable    ${de37PaymentRrn}    ${randomStrNumber}
    ${body}=    Build Payment Off Us Request Body - Securepage    ${mpanGlobal}    ${midGlobal}    ${tidGlobal}    ${de100de32Global}    ${de18Global}    ${de22Global}    ${randomStrNumber}    ${de43Global}    ${custAccount}    ${billIdGlobal}    ${de57Global}    ${amountGlobal}    ${booleanQR}
    ${response}=    Payment QRDynamic Off Us - Securepage    ${body}
    Log    Response: ${response}

CheckStatus QRDynamic Off Us - Securepage - Success
    ${body}=    Check Status Payment Request Body - Securepage    ${trxRefPayment}
    ${signature}=    Generate Signature    ${body}
    ${qr_result}=    CheckStatus QRDynamic Off Us - Securepage    ${signature}    ${body}
    Log    Response: ${qr_result}