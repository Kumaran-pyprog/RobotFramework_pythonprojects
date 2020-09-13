*** Settings ***
Library  SeleniumLibrary  implicit_wait=30
Library  BuiltIn import BuiltIn.Sleep
#relative path
#Resource  ../MyAccount/proceedcheckoutmsglocator.robot

*** Variables ***
${URL}  http://demostore.supersqa.com/
${Browser}  Chrome
${first item addtocart}            //*[@id="main"]/ul/li[1]/a[2]
${second item addtocart}           //*[@id="main"]/ul/li[4]/a[2]
${second item view cart}           //body//a[3]
${proceed checkout box locator}    //*[@id="post-7"]/div/div/div[2]/div/div/a
${checkout MSG box1 locator}       //*[@id="post-8"]/div/div/div[2]/div
${checkout MSG box2 locator}       //*[@id="post-8"]/div/div/div[3]/div

*** Test Cases ***
Test case add two items to cart
    TC_001 Go to home page  ${URL}  ${Browser}
    TC_002 Add items to cart and navigate to checkout  ${first item addtocart}  ${second item addtocart}
    TC_003_proceed_checkout_message notice for returning user to login
    [Teardown]  Close Browser

*** Keywords ***
TC_001 Go to home page
    # go to homepage
    #default arguments passing
    [Arguments]  ${URL}  ${Browser}
    log to console  website is: ${URL}
    log to console  bowser name is: ${Browser}

    Open Browser       ${URL}  ${Browser}
    #maximize tthe window
    Maximize Browser Window

TC_002 Add items to cart and navigate to checkout
    #add the two items in the cart
    #passing the locator
    [Arguments]   ${first item addtocart}  ${second item addtocart}
    log to console  First item locator is: ${first item addtocart}
    log to console  Second item locator is: ${second item addtocart}

    Click Link               ${first item addtocart}
    BuiltIn.Sleep  1
    Click Link               ${second item addtocart}
    BuiltIn.Sleep  1

TC_003_proceed_checkout_message notice for returning user to login
    #Press the view button in polo to see the items in cart
    Press Keys               //body//a[3]      ENTER
    #click the proceed button
    Press Keys               ${proceed checkout box locator}     ENTER
    #verify there is notice returning to user
    ${get text1}              Get Text  ${checkout MSG box1 locator}
    Log  checkout box1: ${get text1}  console=True
    should be equal          ${get text1}  Returning customer? Click here to login
    ${get text2}              Get Text  ${checkout MSG box2 locator}
    Log  checkout box2: ${get text2}  console=True
    should be equal          ${get text2}  Have a coupon? Click here to enter your code
