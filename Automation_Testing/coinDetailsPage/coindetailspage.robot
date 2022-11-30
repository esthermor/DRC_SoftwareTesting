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

${unfilledFavButton}    //img[@src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEwAAABICAYAAABcBhM9AAAACXBIWXMAACxLAAAsSwGlPZapAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAPNSURBVHgB7dzvSxNxHAfw726uU4kEo5HMH6E98UkPtGT2LFBo0SjwgdEDH/ugR0EPpEDoQYFQ9NDyL7B6UMjMwEgHxkA33JbbQMVyKWxsazY3t7nb+hy0ca6T20dvY9bn9WTb9753fO+N9/me83syRgipIpoS+3GJROIKvGqZCsLhcKylpcXNjmF3d/cSx3GnmQp0Ol0uGAw6DQZDQqlvDSvB0tJSM8/zVhjgKaYCrVb7Hl5us2PQaDQv6+rqjEwF2Ww2HYlELsJbxcA4RlAoMCQKDEmu6NeMj4+boM4UwozFYvzg4OAdqBuqBOxyub75/f7P0rbV1dXA2NiYTa7/yMhIb3t7u17a1tXVda2pqekCU4EgCNnZ2dm3mUwmLm0bHh62wNus0v71MCMmcxIwg2xCuyoFXzQxMXErV8Rut08d1t/j8ViK+09PT6tS8P84JZ6j9PjxeDwF7fXFHemSRKLAkCgwpBqv13tT2hAIBDQOh+NjbW1t4a4ealoIXnJMJWKBh5plkbb5fL7N4rHkud3u7zCGA/3hZjrO1JOF8Xw6B/INyWRSmJ+fv67X69MHehYX01QqJQ6EZxUmhpU7xPr6+g1WeTyEligeC12SSBQYEgWGVNK3FZUAtTO4v7//Rm4b3IFvsWpRLUW/ClHRVwMFhkSBIVFgSBQYEgWGRIEhUWBIFBgSBYZEgSFRYEgUGBIFhkSBIVFgSBQYEgWGRIEhUWBIFBgSBYZEgSFp4I+n96UNoVBIu7Kycr6hoaHQtrOzE+3r63sCbwX2b9JaLJZHer3+TL4hHo+zzs7OrcbGRsWdy75kswrRks1yocCQKDAkudU7aafTeU+6Jj8cDnNut/sFx3GFZZzJZPJXd3f3A3YCwaQmTmBn85/T6bS4BPQ5FPjCs0Yw0YkTXJodBRysVRCEVNEqnx/shII7A7/0XMRzgx+IllL2pUsSiQJDosCQSlqy2dbW9tNms92Fa78Q8NramlgsXyvtu7y87O3p6RllFWC1Wp8ZjUbFWjQ3N/dQp9Pt5T/DeQn9/f0RVk4mk6k5VwK73f6FVcjCwoKjlDGJY2dHRJckEgWGRIEhHXmdfjQaDft8PrNSP/gtoQNufKeU+nk8nsWhoaHHctsmJydHOzo6LisdY2Nj4ymMaU+pnzh2Vq1gBuotpRBjn8iVA1/JdLEyo0sSiQJDosCQyv5w1sDAwFez2az4b2OgBLVub2+/k9s2MzPzAW5KXykdw2Aw+Nn/ogqfyJVFlyQSBYZEgSFVzRO5PM8vZjKZq3Lb4KskFyOEkL/9BsGk4DRc6eKeAAAAAElFTkSuQmCC"]
${filledFavButton}    //img[@src="data:image/png;base64,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AAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAAAAAECAAAAAAQIAAAAABAgAAAAAAAAQIAAAAABAgAAAAAECAAAAAAQIAAAAAAAAECAAAAAAQIAAAAABAgAAAAAECAAAAAAAABAgAA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"]
${emailLoginTextfield}    //*[@type="email"]
${passwordLoginTextfield}    //*[@type="password"]
${loginButton}    //*[@class="MuiButton-label" and text()="Login"]
${loginSuccess}    //*[@class="MuiAlert-message"]

${ethereumCoin}    //h6[@class="MuiTypography-root MuiTypography-h6" and text()="Ethereum"]
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
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h2" and text()="Hello Investor!"]    30
    Click Element    ${letsStartButton}

Navigate to Coin Details Page (Ethereum)
    Execute Javascript    window.scrollTo(0,370)
    Wait Until Element Is Visible    ${ethereumCoin}    10
    Click Element    ${ethereumCoin}
    Wait Until Page Contains Element    ${chart}    10
    Page Should Contain Element    ${ethereumPage}

# Scrollable Coin Details Page
#     Execute Javascript    window.scrollTo(0,document.body.scrollHeight)    

# Refresh Coin Details Page
#     Reload Page
#     Wait Until Page Contains Element    ${ethereumPage}
#     Page Should Contain Element    ${ethereumPage}

# Switch Currency
#     Click Element    ${currencySwitcher}
#     FOR    ${currency}    IN    @{currencyList}
#     Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
#     END
    
    # Click Element    ${MYR}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="RM"]

    # Click Element    ${currencySwitcher}
    # Click Element    ${EUR}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="€"]

    # Click Element    ${currencySwitcher}
    # Click Element    ${JPY}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="¥"]

    # Click Element    ${currencySwitcher}
    # Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    # Click Element    ${GBP}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="£"]

    # Click Element    ${currencySwitcher}
    # Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    # Click Element    ${AUD}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="$"]

    # Click Element    ${currencySwitcher}
    # Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    # Click Element    ${CAD}
    # Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="$"]

    # Reload Page
    # Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="USD"]
    # Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="USD"]

# Crypto Converter
#     [Documentation]    To check the conversion from Crypto Amount to Currency Amount and vice versa

#     FOR    ${value}    IN    @{validInput}
#     Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    CTRL+a\ue003
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    ${value}
#     ${currencyAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[3]/div[2]/div/input
#     ${coinPrice}     Execute Javascript    return (parseFloat(Array.prototype.map.call(document.querySelectorAll("[class='MuiTypography-root MuiTypography-h4']"),(z=>z.innerText.match(/\\$([0-9,]+(\\.[0-9]+))/))).filter(z=>z)[0]?.[1].replaceAll(',','')??'NaN'))
#     ${conversionCryptoToCurrency}    Evaluate    ${value}*${coinPrice}
#     Should Be Equal As Numbers    ${currencyAmount}    ${conversionCryptoToCurrency}    
#     END
        
#     FOR  ${value}  IN  @{invalidInput}
#     Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    CTRL+a\ue003
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert crypto amount"]    ${value}
#     ${currencyAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[3]/div[2]/div/input
#     ${coinPrice}     Execute Javascript    return (parseFloat(Array.prototype.map.call(document.querySelectorAll("[class='MuiTypography-root MuiTypography-h4']"),(z=>z.innerText.match(/\\$([0-9,]+(\\.[0-9]+))/))).filter(z=>z)[0]?.[1].replaceAll(',','')??'NaN'))
#     ${conversionCryptoToCurrency}    Evaluate    ${value}*${coinPrice}
#     Should Not Be Equal   ${currencyAmount}    ${conversionCryptoToCurrency}      
#     END
    
#     Execute Javascript    document.querySelectorAll('[class="MuiInputBase-input MuiOutlinedInput-input"]')[1].scrollIntoViewIfNeeded()
#     Sleep    2

#     FOR  ${value}  IN  @{validInput}
#     Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]     
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    CTRL+a\ue003
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    ${value}
#     ${cryptoAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[1]/div[2]/div/input
#     ${conversionCurrencyToCrypto}    Evaluate    ${value}/${coinPrice}
#     Should Be Equal As Numbers    ${cryptoAmount}    ${conversionCurrencyToCrypto}    
#     END
    
#     FOR  ${value}  IN  @{invalidInput}
#     Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]     
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    CTRL+a\ue003
#     Press Keys    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]//ancestor::div[label="insert currency amount"]    ${value}
#     ${cryptoAmount}    Get Value    xpath=/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div/div/div[1]/div[2]/div/input
#     ${conversionCurrencyToCrypto}    Evaluate    ${value}/${coinPrice}
#     Should Not Be Equal    ${cryptoAmount}    ${conversionCurrencyToCrypto}    
#     END

Display "Candlestick" Chart
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)
    Sleep    1
    Click Element    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-text"]
    Page Should Contain Element    //*[@title="Reset Zoom"]

    # Zoom In Icon
    Get Element Size    //*[@class="apexcharts-candlestick-area"]

# Coin Page Statistics
#     Page Should Contain Element    ${communityScore}
#     Page Should Contain Element    ${developerScore}
#     Page Should Contain Element    ${liquidityScore} 
#     Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="%"]
    
# Favourite Coin
#     Click Element    ${unfilledFavButton}    
#     Page Should Contain Element    ${loginBox} 

#     # Log user in
#     Click Element    ${emailLoginTextfield}
#     Input Text    ${emailLoginTextfield}    Testing_123@gmail.com

#     Click Element    ${passwordLoginTextfield}
#     Input Text    ${passwordLoginTextfield}    testing@123

#     Wait Until Element Is Enabled    ${loginButton}    10
#     Click Element    ${loginButton}    
#     Wait Until Page Does Not Contain Element    ${loginBox}
#     Wait Until Page Does Not Contain Element    ${loginSuccess}
#     Page Should Contain Element    ${filledFavButton}