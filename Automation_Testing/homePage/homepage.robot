*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]
${loginButton}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s" and contains(text(),"Login")]    
${currencySwitcher}    //*[@class='MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input']
${MYR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='MYR']
${EUR}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='EUR']
${JPY}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='JPY']
${GBP}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='GBP']
${AUD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='AUD']
${CAD}    //*[@class="MuiButtonBase-root MuiListItem-root MuiMenuItem-root MuiMenuItem-gutters MuiListItem-gutters MuiListItem-button" and @data-value='CAD']
@{currencyList}=    MYR    EUR    JPY    GBP    AUD    CAD
@{currencies}=    RM    €    ¥    £    $    $

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://stocgeex.xyz    chrome
    Maximize Browser Window
    Click Element    ${letsStartButton}

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

Login to kaching.one
    Click Button    ${loginButton}  
    Press Keys    None    ESC        



Close 
    Close Browser