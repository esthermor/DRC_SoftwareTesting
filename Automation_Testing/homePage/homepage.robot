*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]
${loginHeaderButton}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and contains(text(),"Login")]    
${currencySwitcher}    //*[@class='MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input']
${MYR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='MYR']
${EUR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='EUR']
${JPY}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='JPY']
${GBP}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='GBP']
${AUD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='AUD']
${CAD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='CAD']
@{currencyList}=    MYR    EUR    JPY    GBP    AUD    CAD
@{currencies}=    RM    €    ¥    £    $    $

${loginBox}    //*[@class="MuiPaper-root MuiAppBar-root MuiAppBar-positionStatic MuiAppBar-colorPrimary MuiPaper-elevation4"]
${signUpTab}    //*[@class="MuiButtonBase-root MuiTab-root MuiTab-textColorPrimary MuiTab-fullWidth css-251er" and contains(text(),"Sign Up")]
${loginTab}    //*[@class="MuiButtonBase-root MuiTab-root MuiTab-textColorPrimary MuiTab-fullWidth css-251er" and text()="Login"]
${usernameTextfield}    //*[@type="username"]
${emailSignUpTextfield}    //*[@type="email"]
${passwordSignUpTextfield}    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="Enter Password"]
${confirmSignUpTextfield}    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth" and label="Confirm Password"]
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]

${signUpButton}    //*[@class="MuiButton-label" and text()="Sign Up"]
${signUpSuccess}    //*[@class="MuiPaper-root MuiAlert-root MuiAlert-filledSuccess MuiPaper-elevation10"]
${signUpSignInGoogle}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and text()="Sign In With Google"]

${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]
${loginSignInGoogle}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and text()="Sign In With Google"]
${loginLink}    //p[text()="Already have an account?"]//*[@style="cursor: pointer;"]
${signUpLink}    //p[text()="Don't have an account?"]//*[@style="cursor: pointer;"]

${coinsHeader}    //*[@class="MuiToolbar-root MuiToolbar-regular MuiToolbar-gutters"]//div[text()="Coins"]

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://stocgeex.xyz    chrome
    Maximize Browser Window
    Click Element    ${letsStartButton}
    Reload Page
    Page Should Contain Element    ${startButton}

Homepage
    Click Element    ${startButton}
    
Switch Currency
    Click Element    ${currencySwitcher}
    FOR    ${currency}    IN    @{currencyList}
    Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
    END

    Click Element    ${MYR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'RM')]

    Click Element    ${currencySwitcher}
    Click Element    ${EUR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'€')]

    Click Element    ${currencySwitcher}
    Click Element    ${JPY}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'¥')]

    Click Element    ${currencySwitcher}
    Click Element    ${GBP}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'£')]

    Click Element    ${currencySwitcher}
    Click Element    ${AUD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'$')]

    Click Element    ${currencySwitcher}
    Click Element    ${CAD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    10
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'$')]

    Reload Page
    Page Should Contain Element    //p[@class='MuiTypography-root MuiTypography-body1' and contains(text(),'$')]

Sign Up User
    Click Button    ${loginHeaderButton}
    Wait Until Page Contains Element    ${loginBox}    10
    Click Element    ${signUpTab}
     
    # Enter username
    Click Element    ${usernameTextfield}
    Input Text    ${usernameTextfield}    Tester

    # Enter email
    Click Element    ${emailSignUpTextfield}    
    Input Text    ${emailSignUpTextfield}    Esther@gmail.com

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

    # Sign In with Google
    Click Button     ${signUpSignInGoogle}
    
    # Login Link
    Click Element    ${loginLink}
    Page Should Contain Element    //h1[text()="Welcome Back"]

Login to kaching.one
    # Enter email
    Click Button    ${loginHeaderButton}
    Click Element    ${emailLoginTextfield}
    Input Text    ${emailLoginTextfield}    Esther@gmail.com

    # Enter password
    Click Element    ${passwordLoginTextfield}
    Input Text    ${passwordLoginTextfield}    Testing@123

    # Login button
    Wait Until Element Is Enabled    ${loginButton}    10
    Click Element    ${loginButton}
    Wait Until Page Contains Element    ${loginSuccess}    10
    Page Should Contain Element    ${loginSuccess}

    # Sign In with Google
    Click Button    ${loginSignInGoogle}  

    #Sign Up Link
    Click Element      ${signUpLink}
    Page Should Contain Element    //h1[text()=" Create Account"]

    # Press Keys    None    ESC        
   
Navigation to Coin Page 
    Click Element    ${coinsHeader}
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h1" and text()="Coins"]

Close 
    Close Browser