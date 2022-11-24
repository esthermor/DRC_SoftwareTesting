*** Settings ***
Library    SeleniumLibrary    
Documentation    DRCTestCases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]
${currencySwitcher}    //*[@class='MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input']
@{currencyList}=    MYR    EUR    JPY    GBP    AUD    CAD
${currencyBox}    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]
${MYR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='MYR']
${EUR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='EUR']
${JPY}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='JPY']
${GBP}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='GBP']
${AUD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='AUD']
${CAD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='CAD']
${loginHeaderButton}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and contains(text(),"Login")]    
${portfolioHeader}    //*[@class="MuiToolbar-root MuiToolbar-regular MuiToolbar-gutters"]//*[text()="Portfolio"]
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]
${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]

${scrollDown}    window.scrollTo(0,document.body.scrollHeight)
${scrollUp}    window.scrollTo(0,-document.body.scrollHeight)
${chart}    //canvas[@role="img"]
${circularProgress}    //*[@class="MuiCircularProgress-svg"]
${addNewCoin}    //*[@class="MuiButton-label" and text()="Add New Coin"]
${linearProgress}    //*[@class="MuiLinearProgress-root MuiLinearProgress-colorPrimary MuiLinearProgress-indeterminate"]
${scrollToCoinList}    document.querySelector('[class="MuiTypography-root MuiTypography-body1 MuiFormControlLabel-label css-9l3uo3"]').scrollIntoViewIfNeeded()
${addETH}    xpath=/html/body/div/div/div[2]/div[3]/div[2]/div/div[2]/table/tbody/tr[2]/td[4]/img
${addUSDT}    xpath=/html/body/div/div/div[2]/div[3]/div[2]/div/div[2]/table/tbody/tr[3]/td[4]/img
${editIcon}    //*[@class="MuiButton-label"]
${editPage}    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth"]
${holdingAmountTextField}    //*[@class="MuiFormControl-root MuiTextField-root MuiFormControl-fullWidth"]
${coinQuantityTextField}    xpath=/html/body/div[2]/div[3]/div/div/div[4]/div/input
${javascript}    return (function(){let k=[...document.querySelectorAll('[class="MuiTypography-root MuiTypography-h5"]')];for(const e of k){let text=e.textContent;let x=text.match(/(?<=(\\s*\\=\\s*))([0-9]+(\\.([0-9])+)?)/);if(x){return (x[0])}}return null})()

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
    Click Element    ${portfolioHeader}
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Current Asset"]    10

Refresh Portfolio Page
    Reload Page
    Wait Until Page Contains Element    ${chart}    10
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Current Asset"]

Scrollable Portfolio Page
    Execute Javascript    ${scrollDown}
    Execute Javascript    ${scrollUp}

Switch Currency
    Click Element    ${currencySwitcher}
    FOR    ${currency}    IN    @{currencyList}
    Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
    END

    Sleep    5

    Click Element    ${MYR}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="RM"]
    
    Click Element    ${currencySwitcher}
    Click Element    ${EUR}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="€"]

    Click Element    ${currencySwitcher}
    Click Element    ${JPY}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="¥"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    /${currencyBox}    10
    Click Element    ${GBP}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="£"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    ${currencyBox}    10
    Click Element    ${AUD}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="$"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    ${currencyBox}    10
    Click Element    ${CAD}
    Wait Until Page Does Not Contain Element    ${circularProgress}    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h5" and text()="$"]

    Reload Page
    Wait Until Page Contains Element    //*[@class="MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input" and text()=" USD "]    10
    Page Should Contain Element    //*[@class="MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input" and text()=" USD "]

Check Assets in Portfolio
    Page Should Contain Element    //*[text()="Youre Portfolio is empty"]

Add New Coin
    [Documentation]    Add Coins into the Current Asset list
    Click Element    ${addNewCoin}
    Wait Until Page Does Not Contain Element    ${linearProgress}    10
    Wait Until Page Does Not Contain Element    ${circularProgress}    30
    Execute Javascript    ${scrollToCoinList}
    Sleep    2
    Click Element    ${addETH}
    Click Element    ${addUSDT}
    Click Element    ${portfolioHeader}
    Execute Javascript    ${scrollUp}
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Current Asset"]    10
    Wait Until Page Does Not Contain Element    //*[text()="Youre Portfolio is empty"]    10    
    
Edit Holding Amount
    Click Element    ${editIcon}
    Page Should Contain Element    ${editPage}
    
    [Documentation]    To check the conversion from Holding Amount to Coin Quantity and vice versa
    Click Element    ${holdingAmountTextField}
    Press Keys    ${holdingAmountTextField}    100
    ${coinQuantity}    Get Value    ${coinQuantityTextField}
    ${coinConversion}    Execute Javascript    ${javascript}
    ${conversionHoldingToQuantity}    Evaluate    100/${coinConversion}    
    Should Be Equal As Numbers    ${coinQuantity}    ${conversionHoldingToQuantity}   

    Click Element    xpath=/html/body/div[2]/div[3]/div/div/div[4]/div/input
    Press Keys    xpath=/html/body/div[2]/div[3]/div/div/div[4]/div/input    CTRL+a\ue003
    Input Text    xpath=/html/body/div[2]/div[3]/div/div/div[4]/div/input    100
    ${holdingAmount}    Get Value    xpath=/html/body/div[2]/div[3]/div/div/div[2]/div/input
    ${conversionQuantitytoHolding}    Evaluate    100*${coinConversion}
    Should Be Equal As Numbers    ${holdingAmount}    ${conversionQuantityToHolding}
    
    Click Element    //*[@class="MuiButton-label" and text()="Submit"]

Delete Asset
    [Documentation]    Remove Bitcoin from the Current Asset list
    Click Element    xpath=/html/body/div/div/div[2]/div[1]/div[3]/div/div/div/table/tbody/tr[1]/td[2]/div/div/button/img
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-body1 css-zx0575" and text()="Are you sure you want to delete "]    10
    Click Element    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-1ujsas3" and text()="Delete"]
    Page Should Contain Element    //*[@class="MuiAlert-message"]

Close Browser
    Close Browser


