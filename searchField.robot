*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  http://demostore.supersqa.com/
${Browser}  Chrome
${SearchFieldId}   woocommerce-product-search-field-0
${SearchTerm Text}  Logo Collection
${Expected URL Text}  http://demostore.supersqa.com/product/logo-collection/

${MsgBox Class}   class:"woocommerce-info"
${NOT FOUND MSG}  No product were found matching your selection.



*** Test Cases ***
Test Case for Search
    TC_003_TestCase_Search
    TC_004_TestCase_SearchNotAvail

*** Keywords ***
TC_003_TestCase_Search
    Open Browser              ${URL}  ${Browser}
    Maximize Browser Window
    Input Text                ${SearchFieldId}  Logo Collection
    Press Keys                ${SearchFieldId}         ENTER
    #URL path
    Location Should Contain   ${Expected URL Text}
    Close Browser

TC_004_TestCase_SearchNotAvail
    Open Browser              ${URL}  ${Browser}
    Maximize Browser Window
    Input Text                ${SearchFieldId}   Flying Ninja
    Press Keys                ${SearchFieldId}          ENTER
    #Get the title of the page
    ${title}                  Get Title
    Should be equal           ${title}    ${Expected URL Text}
    Element Text Should be    ${Expected URL Text}   ${NOT FOUND MSG}
    Close Browser



