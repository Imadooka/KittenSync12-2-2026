*** Settings ***

Library    Browser

Suite Setup    Open Browser To Homepage

*** Keywords ***

Open Browser To Homepage
    Browser.New Browser    browser=chromium    headless=False    slowMo=50ms
    Browser.New Context    viewport=None
    Browser.New Page    url=http://127.0.0.1:8000/

*** Test Cases ***

Test 1 : Open Homepage
    Wait For Elements State    body    visible
    ${title}=    Get Title
    Sleep    2s
    Should Be Equal    ${title}    วัตถุดิบในครัว

Test 2 : Search Menu Test
    Fill Text    id=searchBox    น่องไก่
    Sleep    5s
    ${menu_name}=    Get Text    h3:has-text("น่องไก่")
    Should Contain   ${menu_name}    น่องไก่

Test 3 : Add Ingredient Quantity Test
    # ตรวจปุ่ม + เพิ่มจำนวนวัตถุดิบ
    ${before}=    Get Text    id=delta-3
    Click    css=button#qty-plus-3[data-step="1"]
    Sleep    3s
    ${after}=    Get Text    id=delta-3

    ${expected}=    Evaluate    int(${before}) + 1

    Should Be Equal As Integers    ${after}    ${expected}
    Sleep    3s

Test 4 : Navigate to Ingredient Detail Page
    Click    css=img[alt="น่องไก่"]
    Wait For Elements State    css=.modal-panel    visible
    Sleep    10s

    ${menu_Name}=    Get Text    id=recipeTitle
    Should Be Equal    ${menu_Name}    เมนูจาก: น่องไก่
    # Click    css=button.modal-x
    # Sleep    2s
    # Wait For Elements State    css=#recipeModal    hidden

Test 5 : Test YouTube Button
    sleep    2s
    Click    css=button.howto-btn >> nth=0
    Sleep    2s
    Click    text=ดูวิธีทำบน YouTube
    Sleep    5s
    

*** Comments ***
Test 6 : Test Recipe Display
    # ทดสอบว่าเมนูแสดงถูกต้อง (ไม่มี [object Object])
    Click    css=img[alt="น่องไก่"]
    Wait For Elements State    css=.modal-panel    visible
    ${recipe_text}=    Get Text    css=.recipe-meta
    Should Not Contain    ${recipe_text}    [object Object]

Test 7 : Test Ingredient Details Display
    # ทดสอบว่าวัตถุดิบในป๊อปอัปแสดงถูกต้อง
    Click    css=img[alt="น่องไก่"]
    Click    css=button.howto-btn
    Wait For Elements State    id=howtoModal    visible
    ${ingredients}=    Get Text    id=howtoIngredients
    Should Not Contain    ${ingredients}    [object Object]

