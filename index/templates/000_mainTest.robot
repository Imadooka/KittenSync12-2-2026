*** Settings ***
Library    Browser

*** Test Cases ***
Open KitchenSync Homepage
    New Browser    chromium    headless=False
    New Context
    New Page    http://127.0.0.1:8000/

    Wait For Elements State    body    visible
    Get Title
    Sleep    2s
