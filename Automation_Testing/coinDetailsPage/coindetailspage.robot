*** Settings ***
Library    SeleniumLibrary
Documentation    DRCtestcases

*** Variables ***
${letsStartButton}   //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://stocgeex.xyz    chrome
    Maximize Browser Window
    Click Element    ${letsStartButton}

Scrollable Coin Details Page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight)

Navigate to Coin Details Page
    Wait Until Element Is Visible    //h6[@class="MuiTypography-root MuiTypography-h6" and text()="Ethereum"]    10
    # Scroll Element Into View    
    Click Element    //h6[@class="MuiTypography-root MuiTypography-h6" and text()="Ethereum"]