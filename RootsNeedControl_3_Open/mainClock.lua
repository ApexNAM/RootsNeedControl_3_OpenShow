local clockFont = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",120)
local yearFont = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",50)
local thanksFont = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",30)

function DrawClock()
    love.graphics.push()

    love.graphics.setFont(clockFont)
    love.graphics.printf(os.date('*t').hour..":"..os.date('*t').min..":"..os.date('*t').sec,C_GameManager.textWidth, 250, love.graphics.getWidth(), "center")

    love.graphics.setFont(yearFont)
    love.graphics.printf(os.date('*t').year.."."..os.date('*t').month.."."..os.date('*t').day,C_GameManager.textWidth, 400, love.graphics.getWidth(), "center")

    love.graphics.setFont(thanksFont)

    if Current_Lang.language_current == 1 then
        love.graphics.printf("Roots Need Control 3.0을 플레이해주셔서 감사합니다.\n아무키나 눌러서 메인메뉴로 이동하세요.",C_GameManager.textWidth, 480, love.graphics.getWidth(), "center")
    elseif Current_Lang.language_current == 2 then
        love.graphics.printf("Thank you for playing Roots Need Control 3.0.\nPress any key to go to the main menu.",C_GameManager.textWidth, 480, love.graphics.getWidth(), "center")
    elseif Current_Lang.language_current == 3 then
        love.graphics.printf("Roots Need Control 3.0をプレイしていただきありがとうございます。\n任意のキーを押してメインメニューに移動してください。",C_GameManager.textWidth, 480, love.graphics.getWidth(), "center")
    end

    love.graphics.pop()
end

function DateTimeBoolean_month()
    return dateTable.month
end

function DateTimeBoolean_day()
    return dateTable.day
end