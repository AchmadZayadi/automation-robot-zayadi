*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Library           BuiltIn
Library           String
Resource          ../variables/dev.robot

*** Keywords ***

Build Request Body
    [Arguments]    ${trxRef}    ${amount}
    ${body}=    Create Dictionary
    ...    amount=${amount}
    ...    applicationType=WEB
    ...    backendURL=https://www.google.com
    ...    failedURL=https://www.google.com
    ...    issuer=OTTOCASH
    ...    merchantURL=https://www.google.com
    ...    promocode=
    ...    successURL=https://www.google.com
    ...    trxRef=${trxRef}
    ...    userId=089634679074
    RETURN    ${body}

Build Payment On Us Request Body - Securepage
    [Arguments]    ${qrData}    ${custAccount}    ${amount}    ${randomStrNumber}    ${feeAmount}
    ${bodyPaymentPurchaseQris}=    Create Dictionary
    ...    amount=${amount}
    ...    approvalCode=131024197884
    ...    custAccount=${custAccount}
    ...    custName=
    ...    dataQr=${qrData}
    ...    datetime=
    ...    fee=${feeAmount}
    ...    issuer=OCBI
    ...    refNumber=${randomStrNumber}
    ...    rrn=${randomStrNumber}
    ...    saldo=${amount}
    RETURN    ${bodyPaymentPurchaseQris}

Build Payment Off Us Request Body - Securepage
    [Arguments]    ${mpanGlobal}    ${midGlobal}    ${tidGlobal}    ${de100de32Global}    ${de18Global}    ${de22Global}    ${randomStrNumber}    ${de43Global}    ${custAccount}    ${billIdGlobal}    ${de57Global}    ${amount}    ${booleanQR}
    ${bodyPaymentQrOffUs}=    Create Dictionary
    ...    de02=${mpanGlobal}4
    ...    de03=260000
    ...    de04=00000${amount}00
    ...    de05=
    ...    de06=
    ...    de07=0523101223
    ...    de09=
    ...    de10=
    ...    de100=${de100de32Global}
    ...    de102=9360081196346790741
    ...    de12=101223
    ...    de13=0523
    ...    de17=0523
    ...    de18=${de18Global}
    ...    de22=${de22Global}
    ...    de28=C00000000
    ...    de32=${de100de32Global}
    ...    de33=360002
    ...    de37=${randomStrNumber}
    ...    de38=056904
    ...    de41=${tidGlobal}
    ...    de42=${midGlobal}
    ...    de43=${de43Global}
    ...    de48=PI04Q001CD00MC03UMI
    ...    de49=360
    ...    de50=
    ...    de51=
    ...    de57=${de57Global}
    ...    onUsCustAccount=${custAccount}
    ...    onUsIssuer=OCBI
    ...    onUsIssuerRefNumber=${randomStrNumber}
    ...    onUsPayment=${booleanQR}
    ...    onUsTag6201=${billIdGlobal}
    RETURN    ${bodyPaymentQrOffUs}



Build Reverse SecurePage QRDynamic Request Body
    [Arguments]    ${qrDataGlobal}
    ${reverseQRDynamic}=    Create Dictionary
    ...    qrData=${qrDataGlobal}
    RETURN    ${reverseQRDynamic}


Check Status Payment Request Body - Securepage
    [Arguments]    ${trxRef}
    ${bodyCheckStatusPayment}=    Create Dictionary
    ...    trxRef=${trxRef}
    RETURN    ${bodyCheckStatusPayment}


Generate Signature
    [Arguments]    ${body}
    # ${body}=    Build Request Body
    Log    ${BASE_URL_SIGNATURE}
    Create Session    signature    ${BASE_URL}    verify=False
    ${headers}=    Create Dictionary
    ...    Timestamp=${TIMESTAMP}
    ...    Apikey=${APIKEY}
    ...    Content-Type=${CONTENT_TYPE}
    # Gunakan path endpoint relatif, misal ${BASE_URL_SIGNATURE}
    ${response}=    POST On Session    signature    ${BASE_URL_SIGNATURE}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    # Ambil isi response text sebagai string, sudah berupa string, tidak perlu Evaluate lagi
    ${signature}=    Remove String    ${response.text}    "
    Log    Generated Signature: ${signature}
    RETURN    ${signature}

# --------------------------------------------------------------------------------------------------------------------------------------------

Generate QR Code
    [Arguments]    ${signature}    ${body}
    # ${body}=    Build Request Body
    Create Session    qr    ${BASE_URL}    verify=False
    ${headers}=    Create Dictionary
    ...    Timestamp=${TIMESTAMP}
    ...    Authorization=${AUTHORIZATION}
    ...    Signature=${signature}
    ...    Content-Type=${CONTENT_TYPE}
    # Gunakan path endpoint relatif misal /generate-qr
    ${response}=    POST On Session    qr    ${BASE_URL_GENERATE_QR}    headers=${headers}    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['responseCode']}    00
    Should Be Equal As Strings    ${response.json()['responseDesc']}    SUCCESS
    Log    QR Response: ${response.text}
    RETURN    ${response.json()}

# --------------------------------------------------------------------------------------------------------------------------------------------

ReverseQR - Securepage
    [Arguments]    ${qrDataSecurePageQRIS}
    Create Session   reverseqr    ${BASE_URL_QRIS_BUILDER}    verify=False
    ${response}=    POST On Session    reverseqr    ${BASE_REVERSE_QR}    json=${qrDataSecurePageQRIS}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    QR Test: ${qrDataSecurePageQRIS}
    Log    QR Response: ${response.json()}
    RETURN    ${response.json()}

# --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRDynamic On Us - Securepage
    [Arguments]    ${bodyPaymentPurchaseQris}
    Create Session   payment    ${BASE_URL_OTTOFIN}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_PURCHASE}    json=${bodyPaymentPurchaseQris}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['code']}    00
    Log    QR Response: ${response.json()['rrn']}
    RETURN    ${response.json()}

# --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRDynamic Off Us - Securepage
    [Arguments]    ${bodyPaymentQrOffUs}
    Create Session   payment    ${BASE_URL_PAYMENT_QRIS}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_CREDIT}    json=${bodyPaymentQrOffUs}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['de39']}    00
    Log    QR Response: ${response}
    RETURN    ${response}

# --------------------------------------------------------------------------------------------------------------------------------------------

CheckStatus QRDynamic Off Us - Securepage
    [Arguments]    ${signature}    ${bodyCheckStatusPayment}
    # ${body}=    Build Request Body
    Create Session    checkStatus   ${BASE_URL}    verify=False
    ${headers}=    Create Dictionary
    ...    Timestamp=${TIMESTAMP}
    ...    Authorization=${AUTHORIZATION}
    ...    Signature=${signature}
    ...    Content-Type=${CONTENT_TYPE}
    ${response}=    POST On Session    checkStatus    ${BASE_CHECK_STATUS}    headers=${headers}    json=${bodyCheckStatusPayment}
    Should Be Equal As Integers    ${response.status_code}    200
    # Should Be Equal As Strings    ${response.json()['responseCode']}    00
    # Should Be Equal As Strings    ${response.json()['responseDesc']}    SUCCESS
    Should Contain    [ '00', '68' ]    ${response.json()['responseCode']}
    Should Contain    [ 'Success', 'Pending Transaction' ]    ${response.json()['responseDesc']}
    Log    QR Response: ${response.text}
    RETURN    ${response.json()}