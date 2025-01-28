*** Settings ***
Resource    ../../WebResources/Resource/Resource.robot
Test Setup    Ouvrir lapplication Web
Test Teardown    Teardown Web

*** Test Cases ***

Ouvrir la plateforme
    [Tags]    TC002
    [Documentation]    Cas de test d'ouverture de la plateforme
    
    Sleep    5s
    Log To Console    Success