*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${loginBox}    //*[@class="MuiPaper-root MuiAppBar-root MuiAppBar-positionStatic MuiAppBar-colorPrimary MuiPaper-elevation4"]
${currencySwitcher}    //*[@class='MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input']
${MYR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='MYR']
${EUR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='EUR']
${JPY}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='JPY']
${GBP}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='GBP']
${AUD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='AUD']
${CAD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='CAD']
@{currencyList}=    MYR    EUR    JPY    GBP    AUD    CAD

${unfilledFavButton}    xpath=/html/body/div/div/div[2]/div[1]/div[1]/img[2]
${filledFavButton}    xpath=/html/body/div/div/div[2]/div[1]/div[1]/img[2]
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]
${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]

${ethereumCoin}    //*[text()="ETH"]
${chart}    //canvas[@role="img"]
${ethereumPage}    //*[@class="MuiTypography-root MuiTypography-h3" and text()="Ethereum"]

${communityScore}    //*[@class="MuiTypography-root MuiTypography-h4" and text()="Community Score"]
${developerScore}    //*[@class="MuiTypography-root MuiTypography-h4" and text()="Developer Score"]
${liquidityScore}    //*[@class="MuiTypography-root MuiTypography-h4" and text()="Liquidity Score"]

@{validInput}    500    +500    -500    5e10
@{invalidInput}    +-500    -+500    ++500    --500

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://kaching.one    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //*[@class="MuiTypography-root jss5 MuiTypography-body1" and text()="Hello Investor!"]    30
    Click Element    ${letsStartButton}

Navigate to Coin Details Page (Ethereum)
    Execute Javascript    window.scrollTo(0,500)
    Wait Until Element Is Visible    ${ethereumCoin}    10
    Wait Until Element Is Visible    //*[@class="alice-carousel__stage-item __active __target"]    10
    Click Element    ${ethereumCoin}
    Wait Until Page Contains Element    ${chart}    10
    Page Should Contain Element    ${ethereumPage}

Scrollable Coin Details Page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)    

Refresh Coin Details Page
    Reload Page
    Wait Until Page Contains Element    ${ethereumPage}
    Page Should Contain Element    ${ethereumPage}

Switch Currency
    Click Element    ${currencySwitcher}
    FOR    ${currency}    IN    @{currencyList}
    Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
    END
    
    Click Element    ${MYR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='RM']

    Click Element    ${currencySwitcher}
    Click Element    ${EUR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='€']

    Click Element    ${currencySwitcher}
    Click Element    ${JPY}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='¥']

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${GBP}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='£']

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${AUD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='$']

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${CAD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[text()='$']

    Reload Page
    Wait Until Page Contains Element    //*[text()="USD"]
    Page Should Contain Element    //*[text()="USD"]

Crypto Converter
    [Documentation]    To check the conversion from Crypto Amount to Currency Amount and vice versa
    
    Execute Javascript    document.querySelectorAll('[class="MuiInputBase-input MuiOutlinedInput-input"]')[0].scrollIntoViewIfNeeded()
    Sleep    2

    FOR    ${value}    IN    @{validInput}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    ${value}
    ${currencyAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[3]/div[2]/div/input
    ${coinPrice}     Execute Javascript    return (parseFloat(Array.prototype.map.call(document.querySelectorAll("[id='coinPrice']"),(z=>z.innerText.match(/\\$([0-9,]+(\\.[0-9]+))/))).filter(z=>z)[0]?.[1].replaceAll(',','')??'NaN'))
    ${conversionCryptoToCurrency}    Evaluate    ${value}*${coinPrice}
    Should Be Equal As Numbers    ${currencyAmount}    ${conversionCryptoToCurrency}    
    END
        
    FOR  ${value}  IN  @{invalidInput}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    ${value}
    ${currencyAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[3]/div[2]/div/input
    ${coinPrice}     Execute Javascript    return (parseFloat(Array.prototype.map.call(document.querySelectorAll("[id='coinPrice']"),(z=>z.innerText.match(/\\$([0-9,]+(\\.[0-9]+))/))).filter(z=>z)[0]?.[1].replaceAll(',','')??'NaN'))
    ${conversionCryptoToCurrency}    Evaluate    ${value}*${coinPrice}
    Should Not Be Equal   ${currencyAmount}    ${conversionCryptoToCurrency}      
    END
    
    Execute Javascript    document.querySelectorAll('[class="MuiInputBase-input MuiOutlinedInput-input"]')[1].scrollIntoViewIfNeeded()
    Sleep    2

    FOR  ${value}  IN  @{validInput}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]     
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    ${value}
    ${cryptoAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[1]/div[2]/div/input
    ${conversionCurrencyToCrypto}    Evaluate    ${value}/${coinPrice}
    Should Be Equal As Numbers    ${cryptoAmount}    ${conversionCurrencyToCrypto}    
    END
    
    FOR  ${value}  IN  @{invalidInput}
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]     
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    CTRL+a\ue003
    Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    ${value}
    ${cryptoAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[1]/div[2]/div/input
    ${conversionCurrencyToCrypto}    Evaluate    ${value}/${coinPrice}
    Should Not Be Equal    ${cryptoAmount}    ${conversionCurrencyToCrypto}    
    END

Display "Candlestick" Chart
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)
    Sleep    1
    Click Element    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-text"]
    Page Should Contain Element    //*[@title="Reset Zoom"]

    # Zoom In Icon
    ${sizeBeforeIn}    Get Element Size    //*[@class="apexcharts-candlestick-area"]
    Click Element    //*[@class="apexcharts-zoomin-icon"]
    ${sizeAfterIn}    Get Element Size     //*[@class="apexcharts-candlestick-area"]
    Should Be True    ${sizeBeforeIn} < ${sizeAfterIn}
       
    # Zoom Out Icon
    Click Element    //*[@class="apexcharts-zoomout-icon"]
    ${sizeAfterOut}    Get Element Size    //*[@class="apexcharts-candlestick-area"]
    Should Be True    ${sizeAfterOut} < ${sizeAfterIn}

    # Reset Zoom Icon
    ${originalSize}    Get Value    //*[@class="apexcharts-candlestick-area" and @barWidth]
    Log    ${originalSize}
    Click Element    //*[@class="apexcharts-reset-icon"]
    Wait Until Element Is Visible    //*[@class="apexcharts-reset-icon"]    5
    ${sizeReset}    Get Value    //*[@class="apexcharts-candlestick-area" and @barWidth]
    Log    ${sizeReset}
    Should Be Equal    ${originalSize}    ${sizeReset}

    # Menu Button
    Click Element    //*[@class="apexcharts-menu-icon"]
    Page Should Contain Element    //*[@class="apexcharts-menu apexcharts-menu-open"]

Coin Information
    Execute Javascript    document.querySelectorAll('[class="MuiButton-label"]')[4].scrollIntoViewIfNeeded()
    Page Should Contain Element    //*[@class="MuiButton-label" and text()="Read more"]
    Sleep    3
    Click Element    //*[@class="MuiButton-label" and text()="Read more"]
    Page Should Contain Element    //*[@class="MuiButton-label" and text()="Show less"]
    Click Element    //*[@class="MuiButton-label" and text()="Show less"]
    Page Should Contain Element    //*[@class="MuiButton-label" and text()="Read more"]

Coin Page Statistics
    Page Should Contain Element    ${communityScore}
    Page Should Contain Element    ${developerScore}
    Page Should Contain Element    ${liquidityScore} 
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="%"]
    
Favourite Coin
    Click Element    ${unfilledFavButton}    
    Page Should Contain Element    ${loginBox} 

    # Add favourite coin for user not logged in
    Click Element    ${emailLoginTextfield}
    Input Text    ${emailLoginTextfield}    Testing_123@gmail.com

    Click Element    ${passwordLoginTextfield}
    Input Text    ${passwordLoginTextfield}    testing@123

    Wait Until Element Is Enabled    ${loginButton}    10
    Click Element    ${loginButton}    
    Wait Until Page Does Not Contain Element    ${loginBox}    10
    Wait Until Page Does Not Contain Element    ${loginSuccess}    10
    Page Should Contain Element    ${filledFavButton}