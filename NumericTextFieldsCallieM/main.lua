-----------------------------------------------------------------------------------------
-- Title: Numeric Textfield
-- Name: Callie McWaters
-- Course: ICS20
-- This program displays a math question and asks the user to answer in a numeric textfield
----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)--

-- sets the background colour
display.setDefault("background", 204/255, 0/255, 102/255)

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
----------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local numberOfPoints = 0
local points

----------------------------------------------------------------------------------------
-- SOUNDS
----------------------------------------------------------------------------------------

local correctSound = audio.loadSound( "Sounds/correctSound.mp3" )
local correctSoundChannel
local incorrectSound = audio.loadSound( "Sounds/wrongSound.mp3")
local incorrectSoundChannel

----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(0, 15)
	randomNumber2 = math.random(0, 15)
	randomOperator = math.random(1, 3)

	if ( randomOperator == 1) then
		correctAnswer = randomNumber1 + randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif ( randomOperator == 2) then

		correctAnswer = randomNumber1 - randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

	elseif (randomOperator == 3) then

		correctAnswer = randomNumber1 * randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
    end
end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end


local function NumericFieldListener( event )

	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		--clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			correctSoundChannel = audio.play(correctSound)
			timer.performWithDelay(2100, HideCorrect)
			numberOfPoints = numberOfPoints + 1
			points.text = "Correct = ".. numberOfPoints

		-- if the users answer and the incorrect answer are the same:
		else
			incorrectObject.isVisible = true
			incorrectSoundChannel = audio.play(incorrectSound)
			timer.performWithDelay(2100, HideIncorrect)
		end
		event.target.text = ""
	end
end

----------------------------------------------------------------------------------------
-- OBJECT CREATION
----------------------------------------------------------------------------------------

-- displays an object and sets the colour
questionObject = display.newText( "", display.contentWidth/2, display.contentHeight/2, nil, 75 )
questionObject:setTextColor(204/255, 153/255, 255/255)

-- create the correct text and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2.5/3, nil, 75 )
correctObject:setTextColor(230/255, 51/255, 51/255)
correctObject.isVisible = false

-- create the incorrect text object make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2.5/3, nil, 75)
incorrectObject:setTextColor(51/255, 123/255, 230/255)
incorrectObject.isVisible = false

-- Create numeric field
NumericField = native.newTextField( display.contentWidth/2, display.contentHeight/1.5, 200, 80)
NumericField.inputType = "display"

-- add the event listener for the numeric field
NumericField:addEventListener( "userInput", NumericFieldListener )

-- display text for points
points = display.newText( "Correct = ".. numberOfPoints, display.contentWidth/3.5, display.contentHeight/5, nil, 50)
points:setTextColor(30/255, 219/255, 188/255)

----------------------------------------------------------------------------------------
-- FUNCTION CALLS
----------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()
