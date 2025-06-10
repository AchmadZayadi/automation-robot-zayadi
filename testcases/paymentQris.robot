*** Settings ***
Library    OperatingSystem
Resource    ../resources/keyPaymentQris.robot

*** Test Cases ***
Inquiry QRStatic On Us - Success
    ${custAccount}=    Set Variable   089634679074
    ${qrData}=    Set Variable   00020101021126640015ID.OTTOCASH.WWW01189360081110014098770212OP1F000022470303UMI51380014ID.CO.QRIS.WWW02099999999990303UMI5204582153033605802ID5907toko hp6006bekasi61053837262239612OP1F000022470703A016304E7B6  
    ${body}=    Build Inquiry On Us Request Body    ${qrData}     ${custAccount}
    ${response}=    Inquiry QRStatic On Us - Success    ${body}
    Log    Response: ${response['message']}

Payment QRStatic On Us - Success
    ${amount}=    Evaluate   int("10000")
    ${feeAmount}=    Evaluate    int("0")
    ${custAccount}=    Set Variable    089634679074
    ${randomStrNumber}=    Evaluate    str(random.randint(111111111111, 999999999999))
    ${qrData}=    Set Variable   00020101021126640015ID.OTTOCASH.WWW01189360081110014098770212OP1F000022470303UMI51380014ID.CO.QRIS.WWW02099999999990303UMI5204582153033605802ID5907toko hp6006bekasi61053837262239612OP1F000022470703A016304E7B6  
    ${body}=    Build Payment On Us Request Body    ${qrData}    ${custAccount}    ${amount}    ${randomStrNumber}    ${feeAmount}
    ${response}=    Payment QRStatic On Us - Success    ${body}
    Log    Response: ${response['message']}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Inquiry QRDynamic On Us - Success
    Generate QR Code - Success
    ${custAccount}=    Set Variable   089634679074
    ${qrData}=    Set Variable    ${qrDataGlobal}
    ${body}=    Build Inquiry On Us Request Body    ${qrData}     ${custAccount}
    ${response}=    Inquiry QRDynamic On Us - Success    ${body}
    Log    Response: ${response['message']}

Payment QRDynamic On Us - Success
    ${amount}=    Set Variable   ${amountGlobal}
    ${feeAmount}=    Evaluate    int("0")
    ${custAccount}=    Set Variable    089634679074
    ${randomStrNumber}=    Evaluate    str(random.randint(111111111111, 999999999999))
    ${qrData}=    Set Variable    ${qrDataGlobal}
    ${body}=    Build Payment On Us Request Body    ${qrData}    ${custAccount}    ${amount}    ${randomStrNumber}    ${feeAmount}
    ${response}=    Payment QRDynamic On Us - Success   ${body}
    Log    Response: ${response['message']}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Reverse QRStatic Off Us - Success
    ${qrData}=    Set Variable    00020101021126640017ID.CO.BANKBSI.WWW0118936004510000108147021000006792850303URE51440014ID.CO.QRIS.WWW0215ID10221907030100303URE5204866153033605802ID5915MASJID AL MADIN6015JAKARTA SELATAN61051281062070703A016304120E
    ${body}=    Build Reverse QRStatic Request Body    ${qrData}
    ${response}=    ReverseQR - Success   ${body}
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

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRStatic Off Us - Success
    ${amount}=    Evaluate   int("15000")
    ${custAccount}=    Set Variable    089634679074
    ${booleanQR}=    Evaluate    eval("False")
    Log    Boolean: ${booleanQR}
    ${randomStrNumber}=    Evaluate    str(random.randint(111111111111, 999999999999))
    ${body}=    Build Payment Off Us Request Body    ${mpanGlobal}    ${midGlobal}    ${tidGlobal}    ${de100de32Global}    ${de18Global}    ${de22Global}    ${randomStrNumber}    ${de43Global}    ${custAccount}    ${billIdGlobal}    ${de57Global}    ${amount}    ${booleanQR}
    ${response}=    Payment QRStatic Off Us - Success    ${body}
    Log    Response: ${response}
    # --------------------------------------------------------------------------------------------------------------------------------------------

Reverse QRDynamic Off Us - Success
    Generate QR Code - Success
    ${qrData}=    Set Variable    ${qrDataGlobal}
    ${body}=    Build Reverse QRDynamic Request Body    ${qrData}
    ${response}=    ReverseQR - Success   ${body}
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

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRDynamic Off Us - Success
    ${amount}=    Set Variable   ${amountGlobal}
    ${custAccount}=    Set Variable    089634679074
    ${booleanQR}=    Evaluate    bool("False")
    ${randomStrNumber}=    Evaluate    str(random.randint(111111111111, 999999999999))
    ${body}=    Build Payment Off Us Request Body    ${mpanGlobal}    ${midGlobal}    ${tidGlobal}    ${de100de32Global}    ${de18Global}    ${de22Global}    ${randomStrNumber}    ${de43Global}    ${custAccount}    ${billIdGlobal}    ${de57Global}    ${amountGlobal}    ${booleanQR}
    ${response}=    Payment QRDynamic Off Us - Success    ${body}
    Log    Response: ${response}
