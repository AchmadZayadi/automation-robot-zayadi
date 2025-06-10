*** Variables ***
${TIMESTAMP}              1747642150
${APIKEY}                 E7141YAO700KI2O0PFE42Y2422022EI2
${AUTHORIZATION}          Basic T1AxRjAwMDAyMjQ3
${CONTENT_TYPE}           application/json
${BASE_URL}               https://dev-secure.ottopay.id
${BASE_URL_OTTOFIN}       http://12.12.12.6:8997
${BASE_URL_QRIS_BUILDER}          http://12.12.12.6:8995
${BASE_URL_PAYMENT_QRIS}    http://12.12.12.6:8977
${BASE_URL_SIGNATURE}     ${BASE_URL}/securepage-pgcore/api/general/createSignature
${BASE_URL_GENERATE_QR}   ${BASE_URL}/sp/emoney/api/trx
${GET_DETAIL_ORDER}   ${BASE_URL}/payment-services/v2.0.0/api/payment-detail
${BASE_CHECK_STATUS}   ${BASE_URL}/sp/service/v3.0.0/api/checkstatus
${BASE_CANCEL_ORDER}   ${BASE_URL}/securepage-be/payment-services/v2.1.0/api/cancel
${BASE_REQ_REFUND}   ${BASE_URL}/securepage-be/payment-services/v2.1.0/api/request_refund
${BASE_VOID}   ${BASE_URL}/securepage-be/payment-services/v2.0.0/api/payment/void
${BASE_INQUIRY_PURCHASE}    ${BASE_URL_OTTOFIN}/ottofin/v1.0/inquiry/qris
${BASE_PAYMENT_PURCHASE}    ${BASE_URL_OTTOFIN}/ottofin/v1.0/purchase/qris
${BASE_REVERSE_QR}        ${BASE_URL_QRIS_BUILDER}/merchant/reverseqr
${BASE_PAYMENT_CREDIT}    ${BASE_URL_PAYMENT_QRIS}/v1.0/qris/paymentCredit


${BASE_URL_FRIDAY}                   http://12.12.12.5:9005/friday-hris-svc/v1
${FRIDAY_SIGNIN}                     ${BASE_URL_FRIDAY}/auth/signin
${FRIDAY_LOGINLOGOUT}                ${BASE_URL_FRIDAY}/attendance/clock-in-out
${FRIDAY_PROFILE_EMPLOYEE}           ${BASE_URL_FRIDAY}/profile/employe
${FRIDAY_PROFILE_PERSONAL}           ${BASE_URL_FRIDAY}/profile/personal
${FRIDAY_ATTENDANCE_HISTORY}         ${BASE_URL_FRIDAY}/attendance/history/?startDate=1735668000&endDate=1742878436
${FRIDAY_OVERTIME_HISTORY}           ${BASE_URL_FRIDAY}/overtime/history/?startDate=1735689600&endDate=1742798765
${FRIDAY_OVERTIME_APPLICATION}       ${BASE_URL_FRIDAY}/overtime/application/?id=01JQ3GS25WGEY87S3R2PZ8Z7QJ
${FRIDAY_LOOKUP_GROUP}               ${BASE_URL_FRIDAY}/lookup/group
${FRIDAY_DASHBOARD_COUNTER}          ${BASE_URL_FRIDAY}/dashboard/counters
${FRIDAY_REDEEM_HISTORY}             ${BASE_URL_FRIDAY}/redeem/history?startDate=1706806800000&endDate=1747983196595
${FRIDAY_OVERTIME_APPLICATION_POST}  ${BASE_URL_FRIDAY}/overtime/application
${FRIDAY_OVERTIME_APPROVAL}          ${BASE_URL_FRIDAY}/overtime/approval
${FRIDAY_CHANGE_PASSWORD}            ${BASE_URL_FRIDAY}/profile/change-password
${FRIDAY_REDEEM_APPLICATION}         ${BASE_URL_FRIDAY}/redeem/application
${FRIDAY_REDEEM_APPROVAL}            ${BASE_URL_FRIDAY}/redeem/approval
${FRIDAY_SIGNOUT}                    ${BASE_URL_FRIDAY}/auth/signout
${FRIDAY_LOOKUP_GROUP_ID}            ${BASE_URL_FRIDAY}/lookup?groupId=01JPVPH4BQQ1RXY96PDTV6V8X2


${BASE_URL_OTTOPOINT_AUTH}           https://nc-apidev.ottopoint.id
${OTTOPOINT_LOGIN}                   ${BASE_URL_OTTOPOINT_AUTH}/loyalty/v2/login/user
${OTTOPOINT_BALANCE}                 ${BASE_URL_OTTOPOINT_AUTH}/loyalty/v2/check-balance/earning