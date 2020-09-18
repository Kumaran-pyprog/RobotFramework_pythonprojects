*** Settings ***
Library  SeleniumLibrary  implicit_wait=30

Suite Setup  Open Browser  about:Blank  ${Browser}
Suite Teardown  Close Browser

*** Variables ***
${home URL}  http://demostore.supersqa.com/
${Browser}  Chrome
${My Account locator}  //*[@id="site-navigation"]/div[1]/ul/li[4]/a
${Email Field locator}      id:username
${Password Field locator}   id:password
${Remember me}   id:rememberme
${login button locator}  //button[@name='login']
${Error Msg locator}     css:#content > div > div.woocommerce > ul > li
${logout}   xpath://*[@id="post-9"]/div/div/div/p[1]/a

*** Test Cases ***
Test case for negative login test
    TC_001 Checking login without username and password
    TC_002 Checking login with username and without password
    TC_003 Checking login without username and with password
    TC_004 Checking loging with fake username and with fake password
    #TC_005 Checking loging with username and with password

*** Keywords ***
TC_001 Checking login without username and password
    Go To   ${home URL}
    Maximize Browser Window
    Press Keys  ${My Account locator}    ENTER
    #Input Text  ${Email Field locator}     Username
    #Input Text  ${Password Field locator}  Password
    Click Button  ${login button locator}
    ${Actual Msg}  Get Text  ${Error Msg locator}
    should be equal  ${Actual Msg}  Error: Username is required.


TC_002 Checking login with username and without password

    Go To   ${home URL}
    Maximize Browser Window
    Press Keys  ${My Account locator}    ENTER
    Input Text  ${Email Field locator}     happy99026@gmail.com
    Click Button  ${login button locator}
    ${Actual Msg}  Get Text  ${Error Msg locator}
    should be equal  ${Actual Msg}  ERROR: The password field is empty.

TC_003 Checking login without username and with password
    Go To   ${home URL}
    Maximize Browser Window
    Press Keys  ${My Account locator}    ENTER
    Input Text  ${Password Field locator}     Password
    Click Button  ${login button locator}
    ${Actual Msg}  Get Text  ${Error Msg locator}
    should be equal  ${Actual Msg}  Error: Username is required.


TC_004 Checking loging with fake username and with fake password
    Go To   ${home URL}
    Maximize Browser Window
    Press Keys  ${My Account locator}    ENTER
    Input Text  ${Email Field locator}        username
    Input Text  ${Password Field locator}     Password
    Click Button   ${login button locator}
    ${Actual Msg}  Get Text  ${Error Msg locator}
    should be equal  ${Actual Msg}  ERROR: Invalid username. Lost your password?
