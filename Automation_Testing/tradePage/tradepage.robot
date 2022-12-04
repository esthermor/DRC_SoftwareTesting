*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}    //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${loginHeaderButton}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and contains(text(),"Login")]    
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]
${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]
${loginBox}    //*[@class="MuiPaper-root MuiAppBar-root MuiAppBar-positionStatic MuiAppBar-colorPrimary MuiPaper-elevation4"]
${signUpTab}    //*[@class="MuiButtonBase-root MuiTab-root MuiTab-textColorPrimary MuiTab-fullWidth css-251er" and contains(text(),"Sign Up")]
${usernameTextfield}    //*[@type="username"]
${emailSignUpTextfield}    //*[@type="email"]
${passwordSignUpTextfield}    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="Enter Password"]
${confirmSignUpTextfield}    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth" and label="Confirm Password"]
${signUpButton}    //*[@class="MuiButton-label" and text()="Sign Up"]
${signUpSuccess}    //*[@class="MuiPaper-root MuiAlert-root MuiAlert-filledSuccess MuiPaper-elevation10"]

@{validValue}    0.8    1    +0.8    -0.8
@{invalidValue}    --0.8    ++0.8    -+0.8    -+0.8

*** Keywords ***
Login
    # Enter email
    Click Button    ${loginHeaderButton}
    Click Element    ${emailLoginTextfield}
    Input Text    ${emailLoginTextfield}    Testing_123@gmail.com

    # Enter password
    Click Element    ${passwordLoginTextfield}
    Input Text    ${passwordLoginTextfield}    Testing@123

    # Login button
    Wait Until Element Is Enabled    ${loginButton}    10
    Click Element    ${loginButton}
    Wait Until Page Contains Element    ${loginSuccess}    10
    Page Should Contain Element    ${loginSuccess}

Sign Up
    Click Button    ${loginHeaderButton}
    Wait Until Page Contains Element    ${loginBox}    10
    Click Element    ${signUpTab}
     
    # Enter email
    Click Element    ${emailSignUpTextfield}    
    Input Text    ${emailSignUpTextfield}    Tester1243@hotmail.com

    # Enter Password
    Click Element    ${passwordSignUpTextfield}
    Press Keys    ${passwordSignUpTextfield}    Testing@123
    
    # Enter Confirm Password
    Click Element    ${confirmSignUpTextfield}   
    Press Keys    ${confirmSignUpTextfield}    Testing@123
     
    # Sign Up button
    Click Element    ${signUpButton}
    Wait Until Page Contains Element    ${signUpSuccess}    10
    Page Should Contain Element    ${signUpSuccess}

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://kaching.one    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@class="MuiTypography-root jss5 MuiTypography-body1" and text()="Hello Investor!"]    30
    Click Element    ${letsStartButton}

Trade for user (not logged in)
    Wait Until Page Contains Element    //*[@class="alice-carousel"]    10
    Click Element    xpath=/html/body/div/div/header/div/div/div[1]/div/div[4]
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="Please login to start trading"]

Trade New User
    Run Keyword    Login
    Wait Until Page Contains Element    //*[@class="MuiButton-label" and text()="Start Trading"]    10
    Click Element    //*[@class="MuiButton-label" and text()="Start Trading"]

Wallet Balance (New User)
    Click Element    //*[@data-testid="PersonIcon"]
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4"]

Reset Balance
    Click Element    //*[text()="Reset Balance"]
    Page Should Contain Element    //h4[text()="30000.00"]
    Page Should Contain Element    //h4[text()=" USD"]
    Page Should Contain Element    //h4[text()="0"]
    Page Should Contain Element    //h4[text()=" BTC"]

Reload Page
    Reload Page
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-body1" and text()="BTC/USD"]    10
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-body1" and text()="BTC/USD"]

Scrollable Page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)

Buy Bitcoin with Valid Input
    FOR  ${buySize}  IN  @{validValue}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    ${buySize}
    ${brokerFee}    Execute Javascript    return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[7].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))
    ${price}    Execute Javascript    return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[5].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))
    
    ${brokerFeeConversion}    Evaluate    (0.1/100)*${price}
    ${test}    Execute Javascript    return (parseFloat(${brokerFeeConversion}.toFixed(2)))
    Should Be Equal    ${brokerFee}    ${test}

    ${totalCostValue}    Execute Javascript    return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[9].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))
    ${totalCost}    Evaluate    ${brokerFee}+${price}
    Should Be Equal    ${totalCostValue}    ${totalCost}
    END
    
Buy Bitcoin with Invalid Input
    FOR  ${buySize}  IN  @{invalidValue}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    ${buySize}
    Click Element    //*[@class="MuiButton-label" and text()="Submit"]
    Wait Until Page Contains Element    //*[@class="MuiAlert-message"]    5
    Page Should Contain Element    //*[@class="MuiAlert-message" and text()="invalid price"]    
    END
    
Sell Bitcoin with Valid Input
    FOR  ${sellSize}  IN  @{validValue}
    Click Element    //*[@class="MuiButton-label" and text()="Sell"]
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    ${sellSize}
    ${brokerFee}    Execute Javascript    return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[7].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))
    ${profit}    Execute Javascript    return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[5].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))

    ${brokerFeeConversion}    Evaluate    (0.1/100)*${profit}
    ${calculatedBrokerFee}    Execute Javascript    return (parseFloat(${brokerFeeConversion}.toFixed(2)))
    Should Be Equal    ${brokerFee}    ${calculatedBrokerFee}

    ${totalGainValue}    Execute Javascript        return (parseFloat(document.querySelectorAll('[class="MuiTypography-root MuiTypography-body1"]')[9].innerText.match(/\\-?([0-9]+(\\.[0-9]+)?)/)))
    ${totalGain}    Evaluate    ${profit}-${brokerFee}
    ${calculatedTotalGain}    Execute Javascript    return (parseFloat(${totalGain}.toFixed(2)))
    Should Be Equal    ${totalGainValue}    ${calculatedTotalGain}    
    END
    
Sell Bitcoin with Invalid Input
    FOR  ${sellSize}  IN  @{invalidValue}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    ${sellSize}
    Click Element    //*[@class="MuiButton-label" and text()="Submit"]
    Wait Until Page Contains Element    //*[@class="MuiAlert-message"]    5
    Page Should Contain Element    //*[@class="MuiAlert-message" and text()="invalid price"]    
    END