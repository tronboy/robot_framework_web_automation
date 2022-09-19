*** Settings ***
Library  Selenium2Library  timeout=10     run_on_failure=Capture Page Screenshot
Library  BuiltIn
Library  String


*** Variables ***
${URL}  https:Your_Desired_URL
${SCREENSHOT_PATH}  ./screenshots/your desired name


*** Test Cases ***

Open Browser
     Open browser

Login
     loginto

VerifyLogin
    VerifyLogin    

Logout
    Logout

Close Browser
     close browser


*** Keywords ***

OpenBrowser
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    incognito
    Call Method    ${options}    add_argument    headless	 #Comment this line to view the run in chrome Browser incognito mode
    Create WebDriver    Chrome    chrome_options=${options}
    #Chrome Headless
    Go To   ${URL}
    set selenium speed     0.80
    wait until location is  ${URL}
    wait until page contains element    id:login-form
    wait until page contains    //A text that is static in your Login page
    set window size     1920    1080
    set screenshot directory    ${SCREENSHOT_PATH}

loginto
     input text     id:mat-input-0  Username
     input text     id:mat-input-1  Password
     click element  xpath://span[contains(text(),'LOGIN')]
	 
VerifyLogin
    wait until page contains 	timeout=20   //A text on screen after logging in

Logout
    click element   xpath:/html[1]/body[1]/app[1]/vertical-layout-1[1]/div[1]/div[1]/div[1]/toolbar[1]/mat-toolbar[1]/div[1]
    wait until page contains    Logout
    click element   xpath://span[contains(text(),'Logout')]
    wait until page contains    //A text in Logout page		timeout=10
