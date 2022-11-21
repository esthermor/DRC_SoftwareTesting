*** Settings ***
Library    SeleniumLibrary    
Library    EyesLibrary    runner=web    ApiKey=hOnE68XZBAX3dsA4CFevYOilUuZECcYDihKB103WA0j20110         
Documentation    DRCTestCases

*** Variables ***
${letsStartButton}    //*[@class="MuiButton-label" and contains(text(),"Let's Start!")] 

*** Test Cases ***
Open & Verify Kaching.one
    Open Browser    https://stocgeex.xyz    chrome
    Maximize Browser Window

Refresh Welcome Page
    Reload Page
    Wait Until Page Contains Element    //*[@class="MuiTypography-root MuiTypography-h2" and text()="Hello Player 1!"]
    Page Should Contain Element    //*[@class="MuiTypography-root MuiTypography-h2" and text()="Hello Player 1!"]

Navigate to Home Page
    Click Element    ${letsStartButton}