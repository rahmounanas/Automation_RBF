*** Settings ***
Resource    ../../WebResources/Resource/Resource.robot
Test Setup    Ouvrir lapplication Web
Test Teardown    Teardown Web

*** Test Cases ***

Aller sur Produit
    [Tags]    TC002
    [Documentation]    Aller sur produit
    
    SeleniumLibrary.Wait Until Element Is Visible    //a[@href="/products"]    ${timeout}
    SeleniumLibrary.Click Element    //a[@href="/products"]
    Sleep    5s
    Log To Console    Success