*** Settings ***
Library    SeleniumLibrary    
Documentation    DRCTestCases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]
${currencySwitcher}    //*[@class='MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input']
@{currencyList}=    MYR    EUR    JPY    GBP    AUD    CAD
${MYR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='MYR']
${EUR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='EUR']
${JPY}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='JPY']
${GBP}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='GBP']
${AUD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='AUD']
${CAD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='CAD']
${loginHeaderButton}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and contains(text(),"Login")]    
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]
${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]

*** Keywords ***
Login to kaching.one
    # Enter email
    Click Button    ${loginHeaderButton}
    Click Element    ${emailLoginTextfield}
    Input Text    ${emailLoginTextfield}    Testing_123@gmail.com

    # Enter password
    Click Element    ${passwordLoginTextfield}
    Input Text    ${passwordLoginTextfield}    testing@123

    # Login button
    Wait Until Element Is Enabled    ${loginButton}    10
    Click Element    ${loginButton}
    Wait Until Page Contains Element    ${loginSuccess}    10
    Page Should Contain Element    ${loginSuccess}

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://stocgeex.xyz    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h2" and text()="Hello Investor!"]    10
    Click Element    ${letsStartButton}
      
Run Keyword     
    Login to kaching.one

Navigate to Portfolio Page
    Click Element    //*[@class="MuiToolbar-root MuiToolbar-regular MuiToolbar-gutters"]//*[text()="Portfolio"]
    Wait Until Page Contains Element    //canvas[@role="img"]    30
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Portfolio"]

# Refresh Portfolio Page
#     Reload Page
#     Wait Until Page Contains Element    //canvas[@role="img"]    10
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Portfolio"]

# Scrollable Portfolio Page
#     Execute Javascript    window.scrollTo(0,document.body.scrollHeight)
#     Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)

# Switch Currency
#     Click Element    ${currencySwitcher}
#     FOR    ${currency}    IN    @{currencyList}
#     Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
#     END

#     Click Element    ${MYR}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="RM"]
#     Click Element    ${currencySwitcher}
#     Click Element    ${EUR}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="€"]

#     Click Element    ${currencySwitcher}
#     Click Element    ${JPY}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="¥"]

#     Click Element    ${currencySwitcher}
#     Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
#     Click Element    ${GBP}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="£"]

#     Click Element    ${currencySwitcher}
#     Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
#     Click Element    ${AUD}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="$"]

#     Click Element    ${currencySwitcher}
#     Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
#     Click Element    ${CAD}
#     Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="$"]

#     Reload Page
#     Wait Until Page Contains Element    //*[@class="MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input" and text()=" USD "]    10
#     Page Should Contain Element    //*[@class="MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input" and text()=" USD "]


# SHOULD DO THE IF NO COIN IN LIST THEN RUN KEYWORD, ADD NEW COIN
    Click Element    //*[@class="MuiSvgIcon-root MuiSvgIcon-fontSizeMedium MuiAvatar-fallback css-13y7ul3"]

# Edit Holding Amount
#     Click Element    //*[@class="MuiButton-label"]
#     Page Should Contain Element    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth"]
#     Click Element    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth"]
#     Press Keys    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth"]    100
#     ${coinQuantity}    Get Value    xpath=/html/body/div[2]/div[3]/div/div/div[4]/div/input
#     ${coinUSD}    Get Text    //*[@class="MuiTypography-root MuiTypography-h5"]
#     ${conversion}        

    # Click Element    //*[@class="MuiButton-label" and text()="Submit"]


Delete Asset
    [Documentation]    Remove Bitcoin from the Current Asset list
    Click Element    xpath=/html/body/div/div/div[2]/div[1]/div[3]/div/div/div/table/tbody/tr[1]/td[2]/div/img
    # Check asset should be deleted from list    

Add New Coin
    [Documentation]    Add Bitcoin into the Current Asset list
    Click Element    //*[@class="MuiButton-label" and text()="Add New Coin"]
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h1" and text()="Coins"]
    Execute Javascript    window.scrollTo(0,1500)        
    Click Element    xpath=/html/body/div/div/div[2]/div[3]/div[2]/div/div[2]/table/tbody/tr[1]/td[4]/img
    Page Should Contain Element    //*[@class="MuiAlert-message" and text()="Bitcoin added to your watchlist"]
    

