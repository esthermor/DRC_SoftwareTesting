*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]
${searchBox}    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
${coinListLargeContainer}    //*[@class="MuiTableBody-root css-1xnox0e"]
${coinListSmallCOntainer}    //*[@class="MuiTableCell-root MuiTableCell-head MuiTableCell-stickyHeader MuiTableCell-alignLeft MuiTableCell-sizeSmall css-xzap77"]
${densePad}    //*[@class="MuiButtonBase-root MuiSwitch-switchBase MuiSwitch-colorPrimary PrivateSwitchBase-root MuiSwitch-switchBase MuiSwitch-colorPrimary css-1nr2wod"]

${coinsHeader}    //*[@class="MuiToolbar-root MuiToolbar-regular MuiToolbar-gutters"]//div[text()="Coins"]

@{coinID}    Bitcoin    Dogecoin    Radix

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

Navigation to Coin Page 
    Click Element    ${coinsHeader}
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h1" and text()="Coins"]

Refresh Coin Page
    Reload Page
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h1" and text()="Coins"]

Switch Currency
    Click Element    ${currencySwitcher}
    FOR    ${currency}    IN    @{currencyList}
    Page Should Contain Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]//li[@data-value='${currency}']
    END

    Click Element    ${MYR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="RM"]

    Click Element    ${currencySwitcher}
    Click Element    ${EUR}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="€"]

    Click Element    ${currencySwitcher}
    Click Element    ${JPY}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="¥"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${GBP}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="£"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${AUD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="$"]

    Click Element    ${currencySwitcher}
    Wait Until Page Contains Element    //*[@class="MuiList-root MuiMenu-list MuiList-padding"]    10
    Click Element    ${CAD}
    Wait Until Page Does Not Contain Element    //*[@class="MuiCircularProgress-svg"]    20
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="$"]

    Reload Page
    Wait Until Page Contains Element    //*[@class="MuiBox-root css-8atqhb"]    10
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-alignRight MuiTableCell-sizeMedium css-1i36psw" and text()="$"]

Scrollable Coin Page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)

Search Invalid Coin
    Click Element    ${searchBox}
    Input Text    ${searchBox}    Testcoin
    Page Should Not Contain    //*[@class="MuiTableBody-root css-1xnox0e"]    

Search Valid Coins
    FOR    ${coinID}    IN    @{coinID}
    Click Element    ${searchBox}
    Press Keys    ${searchBox}    CTRL+a/ue003
    Input Text    ${searchBox}    ${coinID}
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-sizeMedium css-q34dxg"]//h6[text()="${coinID}"]

    # Click Coin
    Click Element    //*[@class="MuiTypography-root MuiTypography-subtitle2" and text()="${coinID}"]
    Wait Until Page Contains Element    //canvas[@role="img"]    20
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h4" and text()="${coinID}"]
    Click Element    ${coinsHeader}
    END

Dense Padding
    Wait Until Page Contains Element    ${coinListLargeContainer}    10
    Click Element    ${densePad}
    Page Should Contain Element    ${coinListSmallCOntainer}

