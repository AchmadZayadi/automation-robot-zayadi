*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Library           BuiltIn
Library           String
Resource          ../variables/dev.robot
Resource          keySecurePageQris.robot


*** Keywords ***
Build Inquiry On Us Request Body
    [Arguments]    ${qrData}    ${custAccount}
   ${bodyInquiryPurchaseQris}=    Create Dictionary
    ...    accountNumber=${custAccount}
    ...    dataQr=${qrData}
    ...    issuer=OTTOPAY
    RETURN    ${bodyInquiryPurchaseQris}

Build Payment On Us Request Body
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

Build Reverse QRDynamic Request Body
    [Arguments]    ${qrDataGlobal}
    ${reverseQRDynamic}=    Create Dictionary
    ...    qrData=${qrDataGlobal}
    RETURN    ${reverseQRDynamic}

Build Reverse QRStatic Request Body
    [Arguments]    ${qrData}
    ${reverseQRStatic}=    Create Dictionary
    ...    qrData=${qrData}
    RETURN    ${reverseQRStatic}

Build Payment Off Us Request Body
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

Generate QR Code - Success
    ${amount}=    Evaluate    int(15000)
    Set Global Variable    ${amountGlobal}    ${amount}
    ${trxRef}=    Get Time    result_format=%Y%m%d%H%M%S
    ${trxRef}=    Set Variable    TS${trxRef}
    ${body}=    Build Request Body    ${trxRef}    ${amount}
    ${signature}=    Generate Signature    ${body}
    ${qr_result}=    Generate QR Code    ${signature}    ${body}
    ${qrData}=    Set Variable   ${qr_result['qrData']}
    Set Global Variable    ${qrDataGlobal}    ${qrData}
    Log    Response: ${qr_result['qrData']}

Inquiry QRStatic On Us - Success
    [Arguments]    ${bodyInquiryPurchase}
    Create Session   Inquiry    ${BASE_URL_OTTOFIN}    verify=False
    ${response}=    POST On Session    Inquiry    ${BASE_INQUIRY_PURCHASE}    json=${bodyInquiryPurchase}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['code']}    00
    Log    QR Response: ${response.json()['qrType']} 
    Log    QR Response: ${response.json()['amount']} 
    RETURN    ${response.json()}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRStatic On Us - Success
    [Arguments]    ${bodyPaymentPurchaseQris}
    Create Session   payment    ${BASE_URL_OTTOFIN}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_PURCHASE}    json=${bodyPaymentPurchaseQris}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['code']}    00
    Log    QR Response: ${response.json()['rrn']}
    RETURN    ${response.json()}

# --------------------------------------------------------------------------------------------------------------------------------------------

Inquiry QRDynamic On Us - Success
    [Arguments]    ${bodyInquiryPurchase}
    Create Session   Inquiry    ${BASE_URL_OTTOFIN}    verify=False
    ${response}=    POST On Session    Inquiry    ${BASE_INQUIRY_PURCHASE}    json=${bodyInquiryPurchase}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['code']}    00
    Log    QR Response: ${response.json()['qrType']} 
    Log    QR Response: ${response.json()['amount']} 
    RETURN    ${response.json()}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRDynamic On Us - Success
    [Arguments]    ${bodyPaymentPurchaseQris}
    Create Session   payment    ${BASE_URL_OTTOFIN}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_PURCHASE}    json=${bodyPaymentPurchaseQris}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['code']}    00
    Log    QR Response: ${response.json()['rrn']}
    RETURN    ${response.json()}

    # --------------------------------------------------------------------------------------------------------------------------------------------

ReverseQR - Success
    [Arguments]    ${qrDataGlobal}
    Create Session   reverseqr    ${BASE_URL_QRIS_BUILDER}    verify=False
    ${response}=    POST On Session    reverseqr    ${BASE_REVERSE_QR}    json=${qrDataGlobal}
    Should Be Equal As Integers    ${response.status_code}    200
    Log    QR Test: ${qrDataGlobal}
    Log    QR Response: ${response.json()}
    RETURN    ${response.json()}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRStatic Off Us - Success
    [Arguments]    ${bodyPaymentQrOffUs}
    Create Session   payment    ${BASE_URL_PAYMENT_QRIS}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_CREDIT}    json=${bodyPaymentQrOffUs}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['de39']}    00
    Log    QR Response: ${response.json()}
    RETURN    ${response.json()}

    # --------------------------------------------------------------------------------------------------------------------------------------------

Payment QRDynamic Off Us - Success
    [Arguments]    ${bodyPaymentQrOffUs}
    Create Session   payment    ${BASE_URL_PAYMENT_QRIS}    verify=False
    ${response}=    POST On Session    payment    ${BASE_PAYMENT_CREDIT}    json=${bodyPaymentQrOffUs}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['de39']}    00
    Log    QR Response: ${response}
    RETURN    ${response}