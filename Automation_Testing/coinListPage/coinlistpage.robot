*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 
${startButton}    //*[@class="MuiButton-label" and contains(text(),"Get Started!")]

${coinListFooter}    //footer[@class="MuiPaper-root MuiAppBar-root MuiAppBar-positionStatic MuiAppBar-colorDefault MuiPaper-elevation0"]

${coinsHeader}    //*[@class="MuiToolbar-root MuiToolbar-regular MuiToolbar-gutters"]//div[text()="Coins"]

*** Variables ***


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

Scrollable Coin Page
    Scroll Element Into View    ${coinListFooter}

Search Coin
    Click Element    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]
    Input Text    //*[@class="MuiInputBase-input MuiOutlinedInput-input"]    Dogecoin
    Page Should Contain Element    //*[@class="MuiTableCell-root MuiTableCell-body MuiTableCell-sizeMedium css-q34dxg"]//h6[text()="Dogecoin"]