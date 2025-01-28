*** Settings ***
Documentation    Ouverture d'app
Resource    ../Resource/Resource.robot

*** Variables ***
${browser}                chrome
${chrome_option_zoom}    --force-device-scale-factor=1.5
${chrome_driver}            C:\\DEV\\chromedriver.exe
${language}                --lang=fr

*** Keywords ***
Ouvrir lapplication Web
    ${Telechargement}=    Creation Path vers Telechargement interne
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}=    Create Dictionary    download.default_directory=${Telechargement}    safebrowsing.enabled=False    
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --disable-popup-blocking
    Call Method    ${chrome_options}    add_argument    ${chrome_option_zoom}
    Call Method    ${chrome_options}    add_argument    --disable-search-engine-choice-screen
    Call Method    ${chrome_options}    add_argument    ${language}

    IF    "Windows" in """%{os}"""
        Open Browser    ${url_app}    ${browser}    options=${chrome_options}    executable_path=${chrome_driver}
    ELSE
        Open Browser    ${url_app}    ${browser}    options=${chrome_options}
    END    
    Maximize Browser Window

Creation Path vers Telechargement interne
    ${temp}=    Remove String    ${CURDIR}    ${/}WebRessources${/}Pages
    ${chemin}=    Set Variable    ${temp}${/}WebJDD${/}Telechargement${/}
    [Return]    ${chemin}

Teardown Web
    Close All Excel Documents
    Close Browser