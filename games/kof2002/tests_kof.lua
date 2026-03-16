assert(rb,"Run fbneo-training-mode.lua")
testsRun = false

function runTests()
    
    local passed_tests, failed_tests = 0,0
    local atTests = ""
    local passed = false
    local function setResults(_passed)
        if _passed then
            passed_tests = passed_tests +1
            return
        end
        local info = debug.getinfo(2, "Sl")
        failed_tests = failed_tests+1
        atTests = atTests.."failed_test: "..failed_tests.." is declared at line "..info.linedefined..".\n"
    end

    if  testsRun then
        -- Function to initialize the test environment
        local function initTest()
            -- Store initial values of global variables
            initial_dummy_random_guard = dummy_random_guard
            -- Mocking p2Crouch and p2Block functions
            original_p2Crouch = p2Crouch
            original_p2Block = p2Block            
            -- Mocked functions or values for testing purposes
            p2Crouch = function()
                print("Player 2 Crouching!")
            end

            p2Block = function()
                print("Player 2 Blocking!")
            end

        end
        -- Function to close the test environment
        local function closeTest()
            -- Restore initial values of global variables
            dummy_random_guard = initial_dummy_random_guard
             -- Restore the original functions
            p2Crouch = original_p2Crouch
            p2Block = original_p2Block
            print("Test environment closed. Restored initial global variable values.")
        end
        -- Perform tests here

        -- Test cases for the block function
        local function testBlockFunction()
            print("Testing block() function...")
            
             -- Function to test block() with dummy_random_guard = 1
             local function testBlockWithRandomGuard()
                print("Test case: dummy_random_guard = 1")
        
                -- Set dummy_random_guard to 1
                dummy_random_guard = 1
        
                -- Counter for occurrences of "down"
                local countDown = 0
        
                -- Repeat the test for a number of iterations
                local iterations = 10  -- Adjust as needed
                for i = 1, iterations do
                    -- Capture output to analyze later
                    local originalPrint = print
                    local capturedOutput = ""
                    print = function(...)
                        capturedOutput = capturedOutput .. table.concat({...}, "\t") .. "\n"
                    end
        
                    block()  -- Execute block function
        
                    -- Restore original print function
                    print = originalPrint
        
                    -- Check if "down" is found in the output
                    if capturedOutput:find("Player 2 Crouching!") then
                        countDown = countDown + 1
                    end
                end
        
                -- Verify based on occurrence of "down"
                if countDown > 0 then
                    print("Test passed! 'Player 2 Crouching!' is occasionally printed.")                    
                    passed = true
                else
                    print("Test failed! 'Player 2 Crouching!' is not printed.")
                    passed = false
                end
                setResults(passed)
            end

            -- Run the specific test case
            testBlockWithRandomGuard()
            -- Function to test block() with dummy_random_guard = 0
           local function testBlockWithNoRandomGuard()
               print("Test case: dummy_random_guard = 0")
       
               -- Set dummy_random_guard to 1
               dummy_random_guard = 0
       
               -- Counter for occurrences of "down"
               local countDown = 0
       
               -- Repeat the test for a number of iterations
               local iterations = 10  -- Adjust as needed
               for i = 1, iterations do
                   -- Capture output to analyze later
                   local originalPrint = print
                   local capturedOutput = ""
                   print = function(...)
                       capturedOutput = capturedOutput .. table.concat({...}, "\t") .. "\n"
                   end
       
                   block()  -- Execute block function
       
                   -- Restore original print function
                   print = originalPrint
       
                   -- Check if "down" is found in the output
                   if capturedOutput:find("Player 2 Crouching!") then
                       countDown = countDown + 1
                   end
               end
       
               -- Verify based on occurrence of "down"
               if countDown > 0 then
                   print("Test failed! 'Player 2 Crouching!' is occasionally printed.")
                   passed = false

               else
                   print("Test passed! 'Player 2 Crouching!' is not printed.")
                   passed= true
               end
               setResults(passed)
           end

           -- Run the specific test case
           testBlockWithNoRandomGuard()
            
            -- Test when dummy_random_guard is 0
         --[[    print("Test case: dummy_random_guard = 0")
            dummy_random_guard = 0
            block()  -- Execute block function
            -- Manually verify that player 2 should always block ]]
            
            print("Block() function tests completed.")
        end

        local function  printResults()
            if passed_tests > 0 then
                print("("..passed_tests.."): test passed.\n")                
            end
            if failed_tests  > 0 then
                print("("..failed_tests.."): test failed.\n")
                print(atTests)             
            end            
        end

        print("Running tests...")
        -- ... (insert your tests here)
        -- Run the test
        initTest()
        testBlockFunction()
        closeTest()
        printResults()
        testsRun = false
    end
end